// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'week_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_WeekPlanTask _$WeekPlanTaskFromJson(Map<String, dynamic> json) =>
    _WeekPlanTask(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
      sortOrder: (json['sort_order'] as num).toInt(),
      startTime: json['start_time'] as String?,
      endTime: json['end_time'] as String?,
      isCompleted: json['is_completed'] as bool,
      planId: (json['plan_id'] as num).toInt(),
      planName: json['plan_name'] as String,
      planColor: json['plan_color'] as String?,
    );

Map<String, dynamic> _$WeekPlanTaskToJson(_WeekPlanTask instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'sort_order': instance.sortOrder,
      'start_time': instance.startTime,
      'end_time': instance.endTime,
      'is_completed': instance.isCompleted,
      'plan_id': instance.planId,
      'plan_name': instance.planName,
      'plan_color': instance.planColor,
    };
