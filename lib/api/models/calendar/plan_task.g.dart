// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'plan_task.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_PlanTask _$PlanTaskFromJson(Map<String, dynamic> json) => _PlanTask(
  id: (json['id'] as num).toInt(),
  name: json['name'] as String,
  sortOrder: (json['sort_order'] as num).toInt(),
  startTime: json['start_time'] as String?,
  endTime: json['end_time'] as String?,
);

Map<String, dynamic> _$PlanTaskToJson(_PlanTask instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'sort_order': instance.sortOrder,
  'start_time': instance.startTime,
  'end_time': instance.endTime,
};
