import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:marquer/api/models/study/timer_mode.dart';

part 'store_study_session_request.freezed.dart';
part 'store_study_session_request.g.dart';

@freezed
abstract class StoreStudySessionRequest with _$StoreStudySessionRequest {
  @JsonSerializable(includeIfNull: false)
  const factory StoreStudySessionRequest({
    required String name,
    @JsonKey(name: 'study_subject_id') int? studySubjectId,
    @JsonKey(name: 'timer_mode') required TimerMode timerMode,
    @JsonKey(name: 'planned_duration_seconds') int? plannedDurationSeconds,
    @JsonKey(name: 'pomodoro_work_minutes') int? pomodoroWorkMinutes,
    @JsonKey(name: 'pomodoro_short_break_minutes') int? pomodoroShortBreakMinutes,
    @JsonKey(name: 'pomodoro_long_break_minutes') int? pomodoroLongBreakMinutes,
    @JsonKey(name: 'pomodoro_cycles') int? pomodoroCycles,
  }) = _StoreStudySessionRequest;

  factory StoreStudySessionRequest.fromJson(Map<String, dynamic> json) =>
      _$StoreStudySessionRequestFromJson(json);
}
