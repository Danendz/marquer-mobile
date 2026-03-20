import 'package:freezed_annotation/freezed_annotation.dart';

part 'complete_study_session_request.freezed.dart';
part 'complete_study_session_request.g.dart';

@freezed
abstract class CompleteStudySessionRequest with _$CompleteStudySessionRequest {
  @JsonSerializable(includeIfNull: false)
  const factory CompleteStudySessionRequest({
    @JsonKey(name: 'actual_duration_seconds') required int actualDurationSeconds,
    @JsonKey(name: 'pomodoro_completed_cycles') int? pomodoroCompletedCycles,
  }) = _CompleteStudySessionRequest;

  factory CompleteStudySessionRequest.fromJson(Map<String, dynamic> json) =>
      _$CompleteStudySessionRequestFromJson(json);
}
