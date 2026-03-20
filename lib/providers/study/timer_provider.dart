import 'dart:async' show Future, Timer, unawaited;
import 'dart:math';
import 'package:flutter/foundation.dart';
import 'package:flutter_foreground_task/flutter_foreground_task.dart';
import 'package:marquer/services/timer_feedback_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:marquer/api/models/study/complete_study_session_request.dart';
import 'package:marquer/api/models/study/study_session.dart';
import 'package:marquer/api/models/study/timer_mode.dart';
import 'package:marquer/api/services/study_service.dart';
import 'package:marquer/providers/study/study_sessions_provider.dart';
import 'package:marquer/providers/study/study_stats_provider.dart';
import 'package:marquer/providers/study/timer_state.dart';
import 'package:marquer/providers/study/timer_state_machine.dart';
import 'package:marquer/services/foreground_timer_service.dart';
import 'package:marquer/services/toast_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wakelock_plus/wakelock_plus.dart';

final timerProvider = NotifierProvider<TimerNotifier, TimerState>(
  () => TimerNotifier(),
);

class TimerNotifier extends Notifier<TimerState> {
  final _service = StudyService();
  final _sm = const TimerStateMachine();
  Timer? _ticker;
  int _tickCount = 0;
  SharedPreferences? _prefs;
  DateTime? _lastTickTime;
  bool _bgCallbackRegistered = false;

  Future<SharedPreferences> get _sharedPrefs async =>
      _prefs ??= await SharedPreferences.getInstance();

  // ── Background service helpers ──

  Future<void> _saveBgState() {
    final modeStr = switch (state.mode) {
      TimerMode.countUp => 'countUp',
      TimerMode.countDown => 'countDown',
      TimerMode.pomodoro => 'pomodoro',
    };

    String? phaseStr;
    if (state.mode == TimerMode.pomodoro) {
      phaseStr = switch (state.phase) {
        TimerPhase.work => 'work',
        TimerPhase.shortBreak => 'shortBreak',
        TimerPhase.longBreak => 'longBreak',
        TimerPhase.idle => 'work',
      };
    }

    return saveTimerBgState(
      mode: modeStr,
      elapsedSeconds: state.elapsedSeconds,
      paused: !state.isRunning,
      targetSeconds: state.targetSeconds,
      phase: phaseStr,
      phaseElapsedSeconds:
          state.mode == TimerMode.pomodoro ? state.phaseElapsedSeconds : null,
      phaseTotalSeconds:
          state.mode == TimerMode.pomodoro
              ? state.currentPhaseTotalSeconds
              : null,
    );
  }

  void _ensureBgCallback() {
    if (_bgCallbackRegistered) return;
    _bgCallbackRegistered = true;
    FlutterForegroundTask.addTaskDataCallback(_onBgAction);
  }

  void _onBgAction(Object data) {
    if (data is! Map) return;
    final action = data['action'] as String?;
    final elapsed = data['elapsed'] as int?;
    switch (action) {
      case 'pause':
        _pauseFromBg(elapsed);
        break;
      case 'resume':
        _resumeFromBg(elapsed);
        break;
      case 'stop':
        _pauseFromBg(elapsed);
        state = state.copyWith(stopRequested: true);
        FlutterForegroundTask.launchApp('/study/active');
        break;
      case 'countdown_complete':
        _ticker?.cancel();
        WakelockPlus.disable();
        if (elapsed != null) {
          state = state.copyWith(
            elapsedSeconds: elapsed,
            isRunning: false,
          );
        }
        unawaited(TimerFeedbackService.playCompletionFeedback());
        break;
    }
  }

  void _pauseFromBg(int? elapsed) {
    _ticker?.cancel();
    state = state.copyWith(
      isRunning: false,
      elapsedSeconds: elapsed ?? state.elapsedSeconds,
    );
    WakelockPlus.disable();
    if (state.serverSession != null) {
      final id = state.serverSession!.id;
      final body = {
        'status': 'paused',
        'actual_duration_seconds': state.elapsedSeconds,
        'pomodoro_completed_cycles': state.completedCycles,
      };
      unawaited(() async {
        try { await _service.updateSession(id, body); } catch (e) { debugPrint(e.toString()); }
      }());
    }
  }

  void _resumeFromBg(int? elapsed) {
    state = state.copyWith(
      isRunning: true,
      elapsedSeconds: elapsed ?? state.elapsedSeconds,
    );
    WakelockPlus.enable();
    _startTicker();
    unawaited(_saveBgState());
    if (state.serverSession != null) {
      final id = state.serverSession!.id;
      unawaited(() async {
        try { await _service.updateSession(id, {'status': 'active'}); } catch (e) { debugPrint(e.toString()); }
      }());
    }
  }

  String _notificationText() {
    return switch (state.mode) {
      TimerMode.countUp => 'Studying: ${TimerStateMachine.formatTime(state.elapsedSeconds)}',
      TimerMode.countDown => 'Time remaining: ${TimerStateMachine.formatTime(state.remainingSeconds)}',
      TimerMode.pomodoro => switch (state.phase) {
        TimerPhase.work => 'Work \u2014 ${TimerStateMachine.formatTime(state.remainingSeconds)} remaining',
        TimerPhase.shortBreak => 'Short Break \u2014 ${TimerStateMachine.formatTime(state.remainingSeconds)}',
        TimerPhase.longBreak => 'Long Break \u2014 ${TimerStateMachine.formatTime(state.remainingSeconds)}',
        TimerPhase.idle => 'Studying: ${TimerStateMachine.formatTime(state.elapsedSeconds)}',
      },
    };
  }

  String _pausedNotificationText() =>
      'Paused \u2014 ${TimerStateMachine.formatTime(state.elapsedSeconds)}';

  // ── Local persistence ──

  void _saveLocal() {
    final session = state.serverSession;
    if (session == null) return;
    unawaited(_sharedPrefs.then((prefs) {
      prefs.setInt('timer_session_id', session.id);
      prefs.setInt('timer_elapsed_seconds', state.elapsedSeconds);
      prefs.setInt('timer_completed_cycles', state.completedCycles);
    }));
  }

  void _clearLocal() {
    unawaited(_sharedPrefs.then((prefs) {
      prefs.remove('timer_session_id');
      prefs.remove('timer_elapsed_seconds');
      prefs.remove('timer_completed_cycles');
    }));
  }

  // ── Public API ──

  @override
  TimerState build() => TimerState(mode: TimerMode.countUp);

  Future<void> loadFromSession(StudySession session) async {
    _ensureBgCallback();
    _ticker?.cancel();

    final prefs = await _sharedPrefs;
    final localSessionId = prefs.getInt('timer_session_id');
    int elapsedSeconds = session.actualDurationSeconds;
    int completedCycles = session.pomodoroCompletedCycles;
    bool localWasNewer = false;

    if (localSessionId == session.id) {
      final localElapsed = prefs.getInt('timer_elapsed_seconds') ?? 0;
      final localCycles = prefs.getInt('timer_completed_cycles') ?? 0;
      if (localElapsed > elapsedSeconds || localCycles > completedCycles) localWasNewer = true;
      elapsedSeconds = max(elapsedSeconds, localElapsed);
      completedCycles = max(completedCycles, localCycles);
    }

    final bgPaused = await FlutterForegroundTask.getData<bool>(key: 'bg_paused') ?? true;
    final bgPhase = await FlutterForegroundTask.getData<String>(key: 'bg_phase');
    if (!bgPaused) {
      final virtualStartMs = await FlutterForegroundTask.getData<int>(key: 'bg_virtual_start_ms');
      if (virtualStartMs != null) {
        final bgElapsed = (DateTime.now().millisecondsSinceEpoch - virtualStartMs) ~/ 1000;
        final isInBreak = session.timerMode == TimerMode.pomodoro &&
            (bgPhase == 'shortBreak' || bgPhase == 'longBreak');
        if (!isInBreak && bgElapsed > elapsedSeconds) {
          elapsedSeconds = bgElapsed;
          localWasNewer = true;
        }
      }
    }

    final bgSnapshot = await FlutterForegroundTask.getData<int>(key: 'bg_elapsed_snapshot_s');
    if (bgSnapshot != null && bgSnapshot > elapsedSeconds) {
      elapsedSeconds = bgSnapshot;
      localWasNewer = true;
    }

    int phaseElapsedSeconds = 0;
    if (session.timerMode == TimerMode.pomodoro) {
      final phaseTotalS = await FlutterForegroundTask.getData<int>(key: 'bg_phase_total_s');
      if (!bgPaused) {
        final phaseVirtualStartMs = await FlutterForegroundTask.getData<int>(key: 'bg_phase_virtual_start_ms');
        if (phaseVirtualStartMs != null) {
          phaseElapsedSeconds = (DateTime.now().millisecondsSinceEpoch - phaseVirtualStartMs) ~/ 1000;
          if (phaseTotalS != null) phaseElapsedSeconds = phaseElapsedSeconds.clamp(0, phaseTotalS);
        }
      } else {
        final snapshot = await FlutterForegroundTask.getData<int>(key: 'bg_phase_snapshot_elapsed_s');
        if (snapshot != null) {
          phaseElapsedSeconds = phaseTotalS != null ? snapshot.clamp(0, phaseTotalS) : snapshot;
        }
      }
    }

    final restoredPhase = session.timerMode == TimerMode.pomodoro
        ? switch (bgPhase) {
            'shortBreak' => TimerPhase.shortBreak,
            'longBreak' => TimerPhase.longBreak,
            _ => TimerPhase.work,
          }
        : TimerPhase.idle;

    state = TimerState(
      isRunning: session.status.name == 'active' && !bgPaused,
      phase: restoredPhase,
      elapsedSeconds: elapsedSeconds,
      phaseElapsedSeconds: phaseElapsedSeconds,
      mode: session.timerMode,
      completedCycles: completedCycles,
      totalCycles: session.pomodoroCycles ?? 4,
      serverSession: session,
      workMinutes: session.pomodoroWorkMinutes ?? 25,
      shortBreakMinutes: session.pomodoroShortBreakMinutes ?? 5,
      longBreakMinutes: session.pomodoroLongBreakMinutes ?? 15,
      targetSeconds: session.plannedDurationSeconds,
    );

    if (localWasNewer) {
      unawaited(_service.updateSession(session.id, {
        'actual_duration_seconds': elapsedSeconds,
        'pomodoro_completed_cycles': completedCycles,
      }));
    }

    final bgStopRequested = await FlutterForegroundTask.getData<bool>(key: 'bg_stop_requested') ?? false;
    if (bgStopRequested) {
      await FlutterForegroundTask.saveData(key: 'bg_stop_requested', value: false);
      state = state.copyWith(isRunning: false, stopRequested: true);
      return;
    }

    final bgCountdownCompleted = await FlutterForegroundTask.getData<bool>(key: 'bg_countdown_completed') ?? false;
    if (bgCountdownCompleted) {
      await FlutterForegroundTask.saveData(key: 'bg_countdown_completed', value: false);
      state = state.copyWith(isRunning: false);
      return;
    }

    if (session.status.name == 'active' && !bgPaused) {
      WakelockPlus.enable();
      _startTicker();
      unawaited(_saveBgState());
      unawaited(startTimerForegroundService(_notificationText()));
    }
  }

  Future<void> start(StudySession session) async {
    _ensureBgCallback();
    _ticker?.cancel();
    _clearLocal();
    state = TimerState(
      isRunning: true,
      phase: session.timerMode == TimerMode.pomodoro ? TimerPhase.work : TimerPhase.idle,
      mode: session.timerMode,
      completedCycles: 0,
      totalCycles: session.pomodoroCycles ?? 4,
      serverSession: session,
      workMinutes: session.pomodoroWorkMinutes ?? 25,
      shortBreakMinutes: session.pomodoroShortBreakMinutes ?? 5,
      longBreakMinutes: session.pomodoroLongBreakMinutes ?? 15,
      targetSeconds: session.plannedDurationSeconds,
    );
    WakelockPlus.enable();
    _startTicker();
    unawaited(_saveBgState());
    unawaited(startTimerForegroundService(_notificationText()));
  }

  Future<void> pause() async {
    _ticker?.cancel();
    state = state.copyWith(isRunning: false);
    WakelockPlus.disable();
    unawaited(FlutterForegroundTask.saveData(key: 'bg_elapsed_snapshot_s', value: state.elapsedSeconds));
    unawaited(FlutterForegroundTask.saveData(key: 'bg_phase_snapshot_elapsed_s', value: state.phaseElapsedSeconds));
    unawaited(clearTimerBgState());
    unawaited(updateTimerNotification(_pausedNotificationText(), paused: true));
    if (state.serverSession != null) {
      try {
        await _service.updateSession(state.serverSession!.id, {
          'status': 'paused',
          'actual_duration_seconds': state.elapsedSeconds,
          'pomodoro_completed_cycles': state.completedCycles,
        });
      } catch (e) { debugPrint(e.toString()); }
    }
  }

  Future<void> resume() async {
    state = state.copyWith(isRunning: true);
    WakelockPlus.enable();
    _startTicker();
    unawaited(_saveBgState());
    unawaited(startTimerForegroundService(_notificationText()));
    if (state.serverSession != null) {
      try {
        await _service.updateSession(state.serverSession!.id, {'status': 'active'});
      } catch (e) { debugPrint(e.toString()); }
    }
  }

  void _resetTimerState() {
    _ticker?.cancel();
    WakelockPlus.disable();
    unawaited(TimerFeedbackService.stop());
    unawaited(clearTimerBgState());
    unawaited(stopTimerForegroundService());
    _clearLocal();
    state = TimerState(mode: TimerMode.countUp);
  }

  Future<void> complete() async {
    final session = state.serverSession;
    final elapsed = state.elapsedSeconds;
    final cycles = state.completedCycles;

    if (elapsed < 60) {
      if (session != null) {
        try {
          await _service.cancelSession(session.id);
          ref.invalidate(studyStatsProvider);
          ref.invalidate(studySessionsProvider);
        } catch (e) {
          debugPrint(e.toString());
          ToastService.showError('Failed to cancel session. Please try again.');
          return;
        }
      }
      _resetTimerState();
      ToastService.showError('Study time under 1 minute does not count');
      return;
    }

    _resetTimerState();
    if (session != null) {
      try {
        await _service.completeSession(session.id, CompleteStudySessionRequest(
          actualDurationSeconds: elapsed,
          pomodoroCompletedCycles: cycles,
        ));
        ref.invalidate(studyStatsProvider);
        ref.invalidate(studySessionsProvider);
      } catch (e) { debugPrint(e.toString()); }
    }
  }

  Future<void> cancel() async {
    final session = state.serverSession;
    _resetTimerState();
    if (session != null) {
      try {
        await _service.cancelSession(session.id);
        ref.invalidate(studyStatsProvider);
        ref.invalidate(studySessionsProvider);
      } catch (e) { debugPrint(e.toString()); }
    }
  }

  void clearStopRequest() {
    state = state.copyWith(stopRequested: false);
    unawaited(FlutterForegroundTask.saveData(key: 'bg_stop_requested', value: false));
    unawaited(updateTimerNotification(_pausedNotificationText(), paused: true));
  }

  Future<void> _syncProgress() async {
    if (state.serverSession == null) return;
    try {
      await _service.updateSession(state.serverSession!.id, {
        'actual_duration_seconds': state.elapsedSeconds,
        'pomodoro_completed_cycles': state.completedCycles,
      });
    } catch (_) {}
  }

  void pauseTicker() => _ticker?.cancel();

  void _startTicker() {
    _ticker?.cancel();
    _tickCount = 0;
    _lastTickTime = DateTime.now();
    _ticker = Timer.periodic(const Duration(seconds: 1), (_) => _tick());
  }

  void _tick() {
    if (!state.isRunning) return;
    _lastTickTime = DateTime.now();
    _tickCount++;
    if (_tickCount % 60 == 0 && state.serverSession != null) {
      unawaited(_syncProgress());
    }
    _saveLocal();

    final result = _sm.tick(state);
    state = result.state;

    if (result.phaseCompleted) {
      unawaited(TimerFeedbackService.playVibrationOnly());
      unawaited(_saveBgState());
    }
    if (result.timerCompleted) {
      _ticker?.cancel();
      WakelockPlus.disable();
      unawaited(TimerFeedbackService.playCompletionFeedback());
    }
  }

  void recoverFromBackground() {
    if (_lastTickTime == null || !state.isRunning) return;
    final missedSeconds = DateTime.now().difference(_lastTickTime!).inSeconds - 1;
    if (missedSeconds > 1) {
      final result = _sm.recoverMissedTime(state, missedSeconds);
      state = result.state;
      if (result.timerCompleted) {
        _ticker?.cancel();
        WakelockPlus.disable();
        unawaited(TimerFeedbackService.playCompletionFeedback());
        return;
      }
    }
    _lastTickTime = DateTime.now();
    if (state.isRunning && !(_ticker?.isActive ?? false)) _startTicker();
  }
}
