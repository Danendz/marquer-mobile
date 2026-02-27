import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:marquer/api/models/study/complete_study_session_request.dart';
import 'package:marquer/api/models/study/study_session.dart';
import 'package:marquer/api/models/study/timer_mode.dart';
import 'package:marquer/api/services/study_service.dart';
import 'package:marquer/providers/study/study_sessions_provider.dart';
import 'package:marquer/providers/study/study_stats_provider.dart';
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

  @override
  TimerState build() => TimerState(mode: TimerMode.countUp);

  void loadFromSession(StudySession session) {
    _ticker?.cancel();
    state = TimerState(
      isRunning: session.status.name == 'active',
      phase: TimerPhase.work,
      elapsedSeconds: session.actualDurationSeconds,
      phaseElapsedSeconds: 0,
      mode: session.timerMode,
      completedCycles: session.pomodoroCompletedCycles,
      totalCycles: session.pomodoroCycles ?? 4,
      serverSession: session,
      workMinutes: session.pomodoroWorkMinutes ?? 25,
      shortBreakMinutes: session.pomodoroShortBreakMinutes ?? 5,
      longBreakMinutes: session.pomodoroLongBreakMinutes ?? 15,
      targetSeconds: session.plannedDurationSeconds,
    );
    if (session.status.name == 'active') _startTicker();
  }

  Future<void> start(StudySession session) async {
    _ticker?.cancel();
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
  }

  Future<void> pause() async {
    _ticker?.cancel();
    state = state.copyWith(isRunning: false);
    WakelockPlus.disable();
    if (state.serverSession != null) {
      try {
        await _service.updateSession(state.serverSession!.id, {
          'status': 'paused',
          'actual_duration_seconds': state.elapsedSeconds,
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

  void _startTicker() {
    _ticker = Timer.periodic(const Duration(seconds: 1), (_) => _tick());
  }

  void _tick() {
    if (!state.isRunning) return;

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
      } else {
        state = state.copyWith(phase: TimerPhase.work, phaseElapsedSeconds: 0);
      }
    }
  }
}
