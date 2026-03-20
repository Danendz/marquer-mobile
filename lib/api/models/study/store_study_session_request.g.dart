// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'store_study_session_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_StoreStudySessionRequest _$StoreStudySessionRequestFromJson(
  Map<String, dynamic> json,
) => _StoreStudySessionRequest(
  name: json['name'] as String,
  studySubjectId: (json['study_subject_id'] as num?)?.toInt(),
  timerMode: $enumDecode(_$TimerModeEnumMap, json['timer_mode']),
  plannedDurationSeconds: (json['planned_duration_seconds'] as num?)?.toInt(),
  pomodoroWorkMinutes: (json['pomodoro_work_minutes'] as num?)?.toInt(),
  pomodoroShortBreakMinutes: (json['pomodoro_short_break_minutes'] as num?)
      ?.toInt(),
  pomodoroLongBreakMinutes: (json['pomodoro_long_break_minutes'] as num?)
      ?.toInt(),
  pomodoroCycles: (json['pomodoro_cycles'] as num?)?.toInt(),
);

Map<String, dynamic> _$StoreStudySessionRequestToJson(
  _StoreStudySessionRequest instance,
) => <String, dynamic>{
  'name': instance.name,
  'study_subject_id': ?instance.studySubjectId,
  'timer_mode': _$TimerModeEnumMap[instance.timerMode]!,
  'planned_duration_seconds': ?instance.plannedDurationSeconds,
  'pomodoro_work_minutes': ?instance.pomodoroWorkMinutes,
  'pomodoro_short_break_minutes': ?instance.pomodoroShortBreakMinutes,
  'pomodoro_long_break_minutes': ?instance.pomodoroLongBreakMinutes,
  'pomodoro_cycles': ?instance.pomodoroCycles,
};

const _$TimerModeEnumMap = {
  TimerMode.countUp: 'count_up',
  TimerMode.countDown: 'count_down',
  TimerMode.pomodoro: 'pomodoro',
};
