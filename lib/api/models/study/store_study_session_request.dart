import 'package:marquer/api/models/study/timer_mode.dart';

class StoreStudySessionRequest {
  final String name;
  final int? studySubjectId;
  final TimerMode timerMode;
  final int? plannedDurationSeconds;
  final int? pomodoroWorkMinutes;
  final int? pomodoroShortBreakMinutes;
  final int? pomodoroLongBreakMinutes;
  final int? pomodoroCycles;

  StoreStudySessionRequest({
    required this.name,
    this.studySubjectId,
    required this.timerMode,
    this.plannedDurationSeconds,
    this.pomodoroWorkMinutes,
    this.pomodoroShortBreakMinutes,
    this.pomodoroLongBreakMinutes,
    this.pomodoroCycles,
  });

  Map<String, dynamic> toJson() {
    final m = <String, dynamic>{'name': name, 'timer_mode': timerMode.value};
    if (studySubjectId != null) m['study_subject_id'] = studySubjectId;
    if (plannedDurationSeconds != null) {
      m['planned_duration_seconds'] = plannedDurationSeconds;
    }
    if (pomodoroWorkMinutes != null) {
      m['pomodoro_work_minutes'] = pomodoroWorkMinutes;
    }
    if (pomodoroShortBreakMinutes != null) {
      m['pomodoro_short_break_minutes'] = pomodoroShortBreakMinutes;
    }
    if (pomodoroLongBreakMinutes != null) {
      m['pomodoro_long_break_minutes'] = pomodoroLongBreakMinutes;
    }
    if (pomodoroCycles != null) m['pomodoro_cycles'] = pomodoroCycles;
    return m;
  }
}
