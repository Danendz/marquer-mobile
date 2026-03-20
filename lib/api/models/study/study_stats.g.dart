// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'study_stats.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_StudyStats _$StudyStatsFromJson(Map<String, dynamic> json) => _StudyStats(
  todayTotalSeconds: (json['today_total_seconds'] as num?)?.toInt() ?? 0,
  sessions: (json['sessions'] as List<dynamic>)
      .map((e) => StudySession.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$StudyStatsToJson(_StudyStats instance) =>
    <String, dynamic>{
      'today_total_seconds': instance.todayTotalSeconds,
      'sessions': instance.sessions.map((e) => e.toJson()).toList(),
    };
