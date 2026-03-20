// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_plan_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_UpdatePlanTaskRequest _$UpdatePlanTaskRequestFromJson(
  Map<String, dynamic> json,
) => _UpdatePlanTaskRequest(
  id: (json['id'] as num?)?.toInt(),
  name: json['name'] as String,
  sortOrder: (json['sort_order'] as num).toInt(),
  startTime: json['start_time'] as String?,
  endTime: json['end_time'] as String?,
);

Map<String, dynamic> _$UpdatePlanTaskRequestToJson(
  _UpdatePlanTaskRequest instance,
) => <String, dynamic>{
  'id': ?instance.id,
  'name': instance.name,
  'sort_order': instance.sortOrder,
  'start_time': ?instance.startTime,
  'end_time': ?instance.endTime,
};

_UpdatePlanRequest _$UpdatePlanRequestFromJson(Map<String, dynamic> json) =>
    _UpdatePlanRequest(
      name: json['name'] as String,
      schedule: PlanSchedule.fromJson(json['schedule'] as Map<String, dynamic>),
      startDate: json['start_date'] as String,
      endDate: json['end_date'] as String?,
      isActive: json['is_active'] as bool?,
      color: json['color'] as String?,
      tasks: (json['tasks'] as List<dynamic>)
          .map((e) => UpdatePlanTaskRequest.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$UpdatePlanRequestToJson(_UpdatePlanRequest instance) =>
    <String, dynamic>{
      'name': instance.name,
      'schedule': _scheduleToJson(instance.schedule),
      'start_date': instance.startDate,
      'end_date': ?instance.endDate,
      'is_active': ?instance.isActive,
      'color': ?instance.color,
      'tasks': instance.tasks.map((e) => e.toJson()).toList(),
    };
