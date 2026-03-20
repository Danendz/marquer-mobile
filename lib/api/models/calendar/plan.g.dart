// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'plan.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Plan _$PlanFromJson(Map<String, dynamic> json) => _Plan(
  id: (json['id'] as num).toInt(),
  name: json['name'] as String,
  schedule: PlanSchedule.fromJson(json['schedule'] as Map<String, dynamic>),
  startDate: json['start_date'] as String,
  endDate: json['end_date'] as String?,
  isActive: json['is_active'] as bool,
  color: json['color'] as String?,
  tasks: (json['tasks'] as List<dynamic>)
      .map((e) => PlanTask.fromJson(e as Map<String, dynamic>))
      .toList(),
  createdAt: json['created_at'] as String,
  updatedAt: json['updated_at'] as String,
);

Map<String, dynamic> _$PlanToJson(_Plan instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'schedule': _scheduleToJson(instance.schedule),
  'start_date': instance.startDate,
  'end_date': instance.endDate,
  'is_active': instance.isActive,
  'color': instance.color,
  'tasks': instance.tasks.map((e) => e.toJson()).toList(),
  'created_at': instance.createdAt,
  'updated_at': instance.updatedAt,
};
