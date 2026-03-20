// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'complete_study_session_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_CompleteStudySessionRequest _$CompleteStudySessionRequestFromJson(
  Map<String, dynamic> json,
) => _CompleteStudySessionRequest(
  actualDurationSeconds: (json['actual_duration_seconds'] as num).toInt(),
  pomodoroCompletedCycles: (json['pomodoro_completed_cycles'] as num?)?.toInt(),
);

Map<String, dynamic> _$CompleteStudySessionRequestToJson(
  _CompleteStudySessionRequest instance,
) => <String, dynamic>{
  'actual_duration_seconds': instance.actualDurationSeconds,
  'pomodoro_completed_cycles': ?instance.pomodoroCompletedCycles,
};
