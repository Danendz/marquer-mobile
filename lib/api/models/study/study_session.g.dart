// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'study_session.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_StudySession _$StudySessionFromJson(Map<String, dynamic> json) =>
    _StudySession(
      id: (json['id'] as num).toInt(),
      userId: (json['user_id'] as num).toInt(),
      studySubjectId: (json['study_subject_id'] as num?)?.toInt(),
      name: json['name'] as String,
      timerMode: $enumDecode(_$TimerModeEnumMap, json['timer_mode']),
      status: $enumDecode(_$StudySessionStatusEnumMap, json['status']),
      plannedDurationSeconds: (json['planned_duration_seconds'] as num?)
          ?.toInt(),
      actualDurationSeconds:
          (json['actual_duration_seconds'] as num?)?.toInt() ?? 0,
      startedAt: json['started_at'] as String,
      endedAt: json['ended_at'] as String?,
      pomodoroWorkMinutes: (json['pomodoro_work_minutes'] as num?)?.toInt(),
      pomodoroShortBreakMinutes: (json['pomodoro_short_break_minutes'] as num?)
          ?.toInt(),
      pomodoroLongBreakMinutes: (json['pomodoro_long_break_minutes'] as num?)
          ?.toInt(),
      pomodoroCycles: (json['pomodoro_cycles'] as num?)?.toInt(),
      pomodoroCompletedCycles:
          (json['pomodoro_completed_cycles'] as num?)?.toInt() ?? 0,
      subject: json['subject'] == null
          ? null
          : StudySubject.fromJson(json['subject'] as Map<String, dynamic>),
      createdAt: json['created_at'] as String,
      updatedAt: json['updated_at'] as String,
    );

Map<String, dynamic> _$StudySessionToJson(_StudySession instance) =>
    <String, dynamic>{
      'id': instance.id,
      'user_id': instance.userId,
      'study_subject_id': instance.studySubjectId,
      'name': instance.name,
      'timer_mode': _$TimerModeEnumMap[instance.timerMode]!,
      'status': _$StudySessionStatusEnumMap[instance.status]!,
      'planned_duration_seconds': instance.plannedDurationSeconds,
      'actual_duration_seconds': instance.actualDurationSeconds,
      'started_at': instance.startedAt,
      'ended_at': instance.endedAt,
      'pomodoro_work_minutes': instance.pomodoroWorkMinutes,
      'pomodoro_short_break_minutes': instance.pomodoroShortBreakMinutes,
      'pomodoro_long_break_minutes': instance.pomodoroLongBreakMinutes,
      'pomodoro_cycles': instance.pomodoroCycles,
      'pomodoro_completed_cycles': instance.pomodoroCompletedCycles,
      'subject': instance.subject?.toJson(),
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
    };

const _$TimerModeEnumMap = {
  TimerMode.countUp: 'count_up',
  TimerMode.countDown: 'count_down',
  TimerMode.pomodoro: 'pomodoro',
};

const _$StudySessionStatusEnumMap = {
  StudySessionStatus.active: 'active',
  StudySessionStatus.paused: 'paused',
  StudySessionStatus.completed: 'completed',
  StudySessionStatus.cancelled: 'cancelled',
};
