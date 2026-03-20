// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'plan_for_date.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_PlanTaskForDate _$PlanTaskForDateFromJson(Map<String, dynamic> json) =>
    _PlanTaskForDate(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
      sortOrder: (json['sort_order'] as num).toInt(),
      startTime: json['start_time'] as String?,
      endTime: json['end_time'] as String?,
      isCompleted: json['is_completed'] as bool,
    );

Map<String, dynamic> _$PlanTaskForDateToJson(_PlanTaskForDate instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'sort_order': instance.sortOrder,
      'start_time': instance.startTime,
      'end_time': instance.endTime,
      'is_completed': instance.isCompleted,
    };

_PlanForDate _$PlanForDateFromJson(Map<String, dynamic> json) => _PlanForDate(
  id: (json['id'] as num).toInt(),
  name: json['name'] as String,
  color: json['color'] as String?,
  tasks: (json['tasks'] as List<dynamic>)
      .map((e) => PlanTaskForDate.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$PlanForDateToJson(_PlanForDate instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'color': instance.color,
      'tasks': instance.tasks.map((e) => e.toJson()).toList(),
    };
