import 'package:marquer/api/models/study/study_session_status.dart';
import 'package:marquer/api/models/study/study_subject.dart';
import 'package:marquer/api/models/study/timer_mode.dart';

class StudySession {
  final int id;
  final int userId;
  final int? studySubjectId;
  final String name;
  final TimerMode timerMode;
  final StudySessionStatus status;
  final int? plannedDurationSeconds;
  final int actualDurationSeconds;
  final String startedAt;
  final String? endedAt;
  final int? pomodoroWorkMinutes;
  final int? pomodoroShortBreakMinutes;
  final int? pomodoroLongBreakMinutes;
  final int? pomodoroCycles;
  final int pomodoroCompletedCycles;
  final StudySubject? subject;
  final String createdAt;
  final String updatedAt;

  StudySession({
    required this.id,
    required this.userId,
    this.studySubjectId,
    required this.name,
    required this.timerMode,
    required this.status,
    this.plannedDurationSeconds,
    required this.actualDurationSeconds,
    required this.startedAt,
    this.endedAt,
    this.pomodoroWorkMinutes,
    this.pomodoroShortBreakMinutes,
    this.pomodoroLongBreakMinutes,
    this.pomodoroCycles,
    required this.pomodoroCompletedCycles,
    this.subject,
    required this.createdAt,
    required this.updatedAt,
  });

  factory StudySession.fromJson(Map<String, dynamic> json) => StudySession(
    id: json['id'] as int,
    userId: json['user_id'] as int,
    studySubjectId: json['study_subject_id'] as int?,
    name: json['name'] as String,
    timerMode: TimerMode.fromString(json['timer_mode'] as String),
    status: StudySessionStatus.fromString(json['status'] as String),
    plannedDurationSeconds: json['planned_duration_seconds'] as int?,
    actualDurationSeconds: json['actual_duration_seconds'] as int? ?? 0,
    startedAt: json['started_at'] as String,
    endedAt: json['ended_at'] as String?,
    pomodoroWorkMinutes: json['pomodoro_work_minutes'] as int?,
    pomodoroShortBreakMinutes: json['pomodoro_short_break_minutes'] as int?,
    pomodoroLongBreakMinutes: json['pomodoro_long_break_minutes'] as int?,
    pomodoroCycles: json['pomodoro_cycles'] as int?,
    pomodoroCompletedCycles: json['pomodoro_completed_cycles'] as int? ?? 0,
    subject:
        json['subject'] != null
            ? StudySubject.fromJson(json['subject'] as Map<String, dynamic>)
            : null,
    createdAt: json['created_at'] as String,
    updatedAt: json['updated_at'] as String,
  );

  StudySession copyWith({
    StudySessionStatus? status,
    int? actualDurationSeconds,
    int? pomodoroCompletedCycles,
    String? endedAt,
  }) => StudySession(
    id: id,
    userId: userId,
    studySubjectId: studySubjectId,
    name: name,
    timerMode: timerMode,
    status: status ?? this.status,
    plannedDurationSeconds: plannedDurationSeconds,
    actualDurationSeconds: actualDurationSeconds ?? this.actualDurationSeconds,
    startedAt: startedAt,
    endedAt: endedAt ?? this.endedAt,
    pomodoroWorkMinutes: pomodoroWorkMinutes,
    pomodoroShortBreakMinutes: pomodoroShortBreakMinutes,
    pomodoroLongBreakMinutes: pomodoroLongBreakMinutes,
    pomodoroCycles: pomodoroCycles,
    pomodoroCompletedCycles:
        pomodoroCompletedCycles ?? this.pomodoroCompletedCycles,
    subject: subject,
    createdAt: createdAt,
    updatedAt: updatedAt,
  );
}
