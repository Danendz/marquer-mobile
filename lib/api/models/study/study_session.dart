import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:marquer/api/models/study/study_session_status.dart';
import 'package:marquer/api/models/study/study_subject.dart';
import 'package:marquer/api/models/study/timer_mode.dart';

part 'study_session.freezed.dart';
part 'study_session.g.dart';

@freezed
abstract class StudySession with _$StudySession {
  @JsonSerializable(explicitToJson: true)
  const factory StudySession({
    required int id,
    @JsonKey(name: 'user_id') required int userId,
    @JsonKey(name: 'study_subject_id') int? studySubjectId,
    required String name,
    @JsonKey(name: 'timer_mode') required TimerMode timerMode,
    required StudySessionStatus status,
    @JsonKey(name: 'planned_duration_seconds') int? plannedDurationSeconds,
    @JsonKey(name: 'actual_duration_seconds') @Default(0) int actualDurationSeconds,
    @JsonKey(name: 'started_at') required String startedAt,
    @JsonKey(name: 'ended_at') String? endedAt,
    @JsonKey(name: 'pomodoro_work_minutes') int? pomodoroWorkMinutes,
    @JsonKey(name: 'pomodoro_short_break_minutes') int? pomodoroShortBreakMinutes,
    @JsonKey(name: 'pomodoro_long_break_minutes') int? pomodoroLongBreakMinutes,
    @JsonKey(name: 'pomodoro_cycles') int? pomodoroCycles,
    @JsonKey(name: 'pomodoro_completed_cycles') @Default(0) int pomodoroCompletedCycles,
    StudySubject? subject,
    @JsonKey(name: 'created_at') required String createdAt,
    @JsonKey(name: 'updated_at') required String updatedAt,
  }) = _StudySession;

  factory StudySession.fromJson(Map<String, dynamic> json) =>
      _$StudySessionFromJson(json);
}
