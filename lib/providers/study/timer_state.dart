import 'package:marquer/api/models/study/study_session.dart';
import 'package:marquer/api/models/study/timer_mode.dart';

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
  final bool stopRequested;

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
    this.stopRequested = false,
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
    bool? stopRequested,
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
    stopRequested: stopRequested ?? this.stopRequested,
  );
}
