import 'dart:async' show Future, Timer, unawaited;
import 'dart:math';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_foreground_task/flutter_foreground_task.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:marquer/api/models/study/complete_study_session_request.dart';
import 'package:marquer/api/models/study/study_session.dart';
import 'package:marquer/api/models/study/timer_mode.dart';
import 'package:marquer/api/services/study_service.dart';
import 'package:marquer/providers/study/study_sessions_provider.dart';
import 'package:marquer/providers/study/study_stats_provider.dart';
import 'package:marquer/services/foreground_timer_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wakelock_plus/wakelock_plus.dart';

enum TimerPhase { work, shortBreak, longBreak, idle }

class TimerState {
  final bool isRunning;
  final TimerPhase phase;
  final int elapsedSeconds; // total study time (excludes breaks)
  final int phaseElapsedSeconds; // elapsed in current phase
  final TimerMode mode;
  final int completedCycles;
  final int totalCycles;
  final StudySession? serverSession;
  // Pomodoro config
  final int workMinutes;
  final int shortBreakMinutes;
  final int longBreakMinutes;
  // Count-down
  final int? targetSeconds;

  TimerState({
    this.isRunning = false,
    this.phase = TimerPhase.idle,
    this.elapsedSeconds = 0,
    this.phaseElapsedSeconds = 0,
    required this.mode,
    this.completedCycles = 0,
    this.totalCycles = 4,
    this.serverSession,
    this.workMinutes = 25,
    this.shortBreakMinutes = 5,
    this.longBreakMinutes = 15,
    this.targetSeconds,
  });

  int get currentPhaseTotalSeconds {
    switch (phase) {
      case TimerPhase.work:
        return workMinutes * 60;
      case TimerPhase.shortBreak:
        return shortBreakMinutes * 60;
      case TimerPhase.longBreak:
        return longBreakMinutes * 60;
      case TimerPhase.idle:
        return 0;
    }
  }

  int get remainingSeconds {
    if (mode == TimerMode.countDown && targetSeconds != null) {
      return (targetSeconds! - elapsedSeconds).clamp(0, targetSeconds!);
    }
    if (mode == TimerMode.pomodoro) {
      return (currentPhaseTotalSeconds - phaseElapsedSeconds).clamp(
        0,
        currentPhaseTotalSeconds,
      );
    }
    return elapsedSeconds;
  }

  TimerState copyWith({
    bool? isRunning,
    TimerPhase? phase,
    int? elapsedSeconds,
    int? phaseElapsedSeconds,
    TimerMode? mode,
    int? completedCycles,
    int? totalCycles,
    StudySession? serverSession,
    int? workMinutes,
    int? shortBreakMinutes,
    int? longBreakMinutes,
    int? targetSeconds,
  }) => TimerState(
    isRunning: isRunning ?? this.isRunning,
    phase: phase ?? this.phase,
    elapsedSeconds: elapsedSeconds ?? this.elapsedSeconds,
    phaseElapsedSeconds: phaseElapsedSeconds ?? this.phaseElapsedSeconds,
    mode: mode ?? this.mode,
    completedCycles: completedCycles ?? this.completedCycles,
    totalCycles: totalCycles ?? this.totalCycles,
    serverSession: serverSession ?? this.serverSession,
    workMinutes: workMinutes ?? this.workMinutes,
    shortBreakMinutes: shortBreakMinutes ?? this.shortBreakMinutes,
    longBreakMinutes: longBreakMinutes ?? this.longBreakMinutes,
    targetSeconds: targetSeconds ?? this.targetSeconds,
  );
}

final timerProvider = NotifierProvider<TimerNotifier, TimerState>(
  () => TimerNotifier(),
);

class TimerNotifier extends Notifier<TimerState> {
  final _service = StudyService();
  Timer? _ticker;
  int _tickCount = 0;
  SharedPreferences? _prefs;
  DateTime? _lastTickTime;

  Future<SharedPreferences> get _sharedPrefs async =>
      _prefs ??= await SharedPreferences.getInstance();

  String _formatTime(int seconds) {
    final h = seconds ~/ 3600;
    final m = (seconds % 3600) ~/ 60;
    final s = seconds % 60;
    if (h > 0) {
      return '${h.toString().padLeft(2, '0')}:${m.toString().padLeft(2, '0')}:${s.toString().padLeft(2, '0')}';
    }
    return '${m.toString().padLeft(2, '0')}:${s.toString().padLeft(2, '0')}';
  }

  Future<void> _saveBgState() {
    String modeStr;
    switch (state.mode) {
      case TimerMode.countUp:
        modeStr = 'countUp';
        break;
      case TimerMode.countDown:
        modeStr = 'countDown';
        break;
      case TimerMode.pomodoro:
        modeStr = 'pomodoro';
        break;
    }

    String? phaseStr;
    if (state.mode == TimerMode.pomodoro) {
      switch (state.phase) {
        case TimerPhase.work:
          phaseStr = 'work';
          break;
        case TimerPhase.shortBreak:
          phaseStr = 'shortBreak';
          break;
        case TimerPhase.longBreak:
          phaseStr = 'longBreak';
          break;
        case TimerPhase.idle:
          phaseStr = 'work';
          break;
      }
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

  String _notificationText() {
    switch (state.mode) {
      case TimerMode.countUp:
        return 'Studying: ${_formatTime(state.elapsedSeconds)}';
      case TimerMode.countDown:
        return 'Time remaining: ${_formatTime(state.remainingSeconds)}';
      case TimerMode.pomodoro:
        final timeText = _formatTime(state.remainingSeconds);
        switch (state.phase) {
          case TimerPhase.work:
            return 'Work \u2014 $timeText remaining';
          case TimerPhase.shortBreak:
            return 'Short Break \u2014 $timeText';
          case TimerPhase.longBreak:
            return 'Long Break \u2014 $timeText';
          case TimerPhase.idle:
            return 'Studying: ${_formatTime(state.elapsedSeconds)}';
        }
    }
  }

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

  @override
  TimerState build() => TimerState(mode: TimerMode.countUp);

  Future<void> loadFromSession(StudySession session) async {
    _ticker?.cancel();

    final prefs = await _sharedPrefs;
    final localSessionId = prefs.getInt('timer_session_id');
    int elapsedSeconds = session.actualDurationSeconds;
    int completedCycles = session.pomodoroCompletedCycles;
    bool localWasNewer = false;

    if (localSessionId == session.id) {
      final localElapsed = prefs.getInt('timer_elapsed_seconds') ?? 0;
      final localCycles = prefs.getInt('timer_completed_cycles') ?? 0;
      if (localElapsed > elapsedSeconds || localCycles > completedCycles) {
        localWasNewer = true;
      }
      elapsedSeconds = max(elapsedSeconds, localElapsed);
      completedCycles = max(completedCycles, localCycles);
    }

    // Recover elapsed time accumulated by the background foreground service
    // (handles the case where the app was killed but the service kept running).
    final bgPaused =
        await FlutterForegroundTask.getData<bool>(key: 'bg_paused') ?? true;
    if (!bgPaused) {
      final virtualStartMs = await FlutterForegroundTask.getData<int>(
        key: 'bg_virtual_start_ms',
      );
      if (virtualStartMs != null) {
        final bgElapsed =
            (DateTime.now().millisecondsSinceEpoch - virtualStartMs) ~/ 1000;
        if (bgElapsed > elapsedSeconds) {
          elapsedSeconds = bgElapsed;
          localWasNewer = true;
        }
      }
    }

    state = TimerState(
      isRunning: session.status.name == 'active',
      phase: TimerPhase.work,
      elapsedSeconds: elapsedSeconds,
      phaseElapsedSeconds: 0,
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

    if (session.status.name == 'active') {
      WakelockPlus.enable();
      _startTicker();
      unawaited(_saveBgState());
      unawaited(startTimerForegroundService(_notificationText()));
    }
  }

  Future<void> start(StudySession session) async {
    _ticker?.cancel();
    _clearLocal();
    state = TimerState(
      isRunning: true,
      phase:
          session.timerMode == TimerMode.pomodoro
              ? TimerPhase.work
              : TimerPhase.idle,
      elapsedSeconds: 0,
      phaseElapsedSeconds: 0,
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
    unawaited(clearTimerBgState());
    unawaited(stopTimerForegroundService());
    if (state.serverSession != null) {
      try {
        await _service.updateSession(state.serverSession!.id, {
          'status': 'paused',
          'actual_duration_seconds': state.elapsedSeconds,
          'pomodoro_completed_cycles': state.completedCycles,
        });
      } catch (e) {
        debugPrint(e.toString());
      }
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
        await _service.updateSession(
          state.serverSession!.id,
          {'status': 'active'},
        );
      } catch (e) {
        debugPrint(e.toString());
      }
    }
  }

  Future<void> complete() async {
    _ticker?.cancel();
    WakelockPlus.disable();
    unawaited(clearTimerBgState());
    unawaited(stopTimerForegroundService());
    _clearLocal();
    final session = state.serverSession;
    final elapsed = state.elapsedSeconds;
    final cycles = state.completedCycles;
    state = TimerState(mode: TimerMode.countUp);
    if (session != null) {
      try {
        await _service.completeSession(
          session.id,
          CompleteStudySessionRequest(
            actualDurationSeconds: elapsed,
            pomodoroCompletedCycles: cycles,
          ),
        );
        ref.invalidate(studyStatsProvider);
        ref.invalidate(studySessionsProvider);
      } catch (e) {
        debugPrint(e.toString());
      }
    }
  }

  Future<void> cancel() async {
    _ticker?.cancel();
    WakelockPlus.disable();
    unawaited(clearTimerBgState());
    unawaited(stopTimerForegroundService());
    _clearLocal();
    final session = state.serverSession;
    state = TimerState(mode: TimerMode.countUp);
    if (session != null) {
      try {
        await _service.cancelSession(session.id);
        ref.invalidate(studyStatsProvider);
        ref.invalidate(studySessionsProvider);
      } catch (e) {
        debugPrint(e.toString());
      }
    }
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

  /// Pauses the Dart ticker without changing isRunning state.
  /// Used when the Activity is destroyed (detached) but the process is kept
  /// alive by the foreground service. recoverFromBackground() restores it.
  void pauseTicker() {
    _ticker?.cancel();
  }

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

    if (state.mode == TimerMode.pomodoro) {
      _tickPomodoro();
    } else {
      final newElapsed = state.elapsedSeconds + 1;
      // Count-down: auto-complete when done
      if (state.mode == TimerMode.countDown &&
          state.targetSeconds != null &&
          newElapsed >= state.targetSeconds!) {
        state = state.copyWith(
          elapsedSeconds: state.targetSeconds,
          isRunning: false,
        );
        _ticker?.cancel();
        WakelockPlus.disable();
        HapticFeedback.heavyImpact();
        // Navigate to completion — handled by screen listening to state
        return;
      }
      state = state.copyWith(elapsedSeconds: newElapsed);
    }
    unawaited(updateTimerNotification(_notificationText()));
  }

  void _tickPomodoro() {
    final newPhaseElapsed = state.phaseElapsedSeconds + 1;
    final phaseTotal = state.currentPhaseTotalSeconds;

    if (newPhaseElapsed >= phaseTotal) {
      // Phase complete
      HapticFeedback.heavyImpact();
      _handlePomodoroPhaseComplete();
    } else {
      // Still in current phase
      // Only count study seconds during work phase
      final newStudyElapsed =
          state.phase == TimerPhase.work
              ? state.elapsedSeconds + 1
              : state.elapsedSeconds;
      state = state.copyWith(
        elapsedSeconds: newStudyElapsed,
        phaseElapsedSeconds: newPhaseElapsed,
      );
    }
  }

  void recoverFromBackground() {
    if (_lastTickTime == null || !state.isRunning) return;

    final missedSeconds =
        DateTime.now().difference(_lastTickTime!).inSeconds - 1;
    if (missedSeconds > 1) {
      if (state.mode == TimerMode.countDown && state.targetSeconds != null) {
        final newElapsed =
            (state.elapsedSeconds + missedSeconds).clamp(0, state.targetSeconds!);
        if (newElapsed >= state.targetSeconds!) {
          state = state.copyWith(
            elapsedSeconds: state.targetSeconds,
            isRunning: false,
          );
          _ticker?.cancel();
          WakelockPlus.disable();
          HapticFeedback.heavyImpact();
          return;
        }
        state = state.copyWith(elapsedSeconds: newElapsed);
      } else if (state.mode == TimerMode.pomodoro) {
        _recoverPomodoro(missedSeconds);
      } else {
        // countUp: add missed seconds
        state = state.copyWith(
          elapsedSeconds: state.elapsedSeconds + missedSeconds,
        );
      }
    }

    _lastTickTime = DateTime.now();
    if (state.isRunning && !(_ticker?.isActive ?? false)) _startTicker();
  }

  void _recoverPomodoro(int missedSeconds) {
    int remaining = missedSeconds;

    while (remaining > 0 && state.isRunning) {
      final phaseRemaining =
          state.currentPhaseTotalSeconds - state.phaseElapsedSeconds;

      if (remaining < phaseRemaining) {
        // Still within current phase
        final newElapsed =
            state.phase == TimerPhase.work
                ? state.elapsedSeconds + remaining
                : state.elapsedSeconds;
        state = state.copyWith(
          elapsedSeconds: newElapsed,
          phaseElapsedSeconds: state.phaseElapsedSeconds + remaining,
        );
        break;
      } else {
        // Current phase completes — consume it and advance
        remaining -= phaseRemaining;
        final newElapsed =
            state.phase == TimerPhase.work
                ? state.elapsedSeconds + phaseRemaining
                : state.elapsedSeconds;

        if (state.phase == TimerPhase.work) {
          final newCycles = state.completedCycles + 1;
          if (newCycles >= state.totalCycles) {
            state = state.copyWith(
              phase: TimerPhase.longBreak,
              phaseElapsedSeconds: 0,
              completedCycles: newCycles,
              elapsedSeconds: newElapsed,
            );
          } else {
            state = state.copyWith(
              phase: TimerPhase.shortBreak,
              phaseElapsedSeconds: 0,
              completedCycles: newCycles,
              elapsedSeconds: newElapsed,
            );
          }
        } else if (state.phase == TimerPhase.longBreak &&
            state.completedCycles >= state.totalCycles) {
          // All cycles done
          state = state.copyWith(
            isRunning: false,
            phaseElapsedSeconds: state.currentPhaseTotalSeconds,
            elapsedSeconds: newElapsed,
          );
          _ticker?.cancel();
          WakelockPlus.disable();
          return;
        } else {
          // Short break (or unfinished long break) → back to work
          state = state.copyWith(
            phase: TimerPhase.work,
            phaseElapsedSeconds: 0,
            elapsedSeconds: newElapsed,
          );
        }
      }
    }
  }

  void _handlePomodoroPhaseComplete() {
    if (state.phase == TimerPhase.work) {
      final newCycles = state.completedCycles + 1;
      if (newCycles >= state.totalCycles) {
        // Long break
        state = state.copyWith(
          phase: TimerPhase.longBreak,
          phaseElapsedSeconds: 0,
          completedCycles: newCycles,
          elapsedSeconds: state.elapsedSeconds + 1,
        );
      } else {
        // Short break
        state = state.copyWith(
          phase: TimerPhase.shortBreak,
          phaseElapsedSeconds: 0,
          completedCycles: newCycles,
          elapsedSeconds: state.elapsedSeconds + 1,
        );
      }
      unawaited(_saveBgState());
    } else {
      // Break complete → back to work
      // If long break completed, could auto-complete session
      if (state.phase == TimerPhase.longBreak &&
          state.completedCycles >= state.totalCycles) {
        // All cycles done — auto-complete handled by screen
        state = state.copyWith(
          isRunning: false,
          phaseElapsedSeconds: state.currentPhaseTotalSeconds,
        );
        _ticker?.cancel();
        WakelockPlus.disable();
        unawaited(clearTimerBgState());
      } else {
        state = state.copyWith(phase: TimerPhase.work, phaseElapsedSeconds: 0);
        unawaited(_saveBgState());
      }
    }
  }
}
