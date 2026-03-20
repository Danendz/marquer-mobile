// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_plan_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_CreatePlanTaskRequest _$CreatePlanTaskRequestFromJson(
  Map<String, dynamic> json,
) => _CreatePlanTaskRequest(
  name: json['name'] as String,
  sortOrder: (json['sort_order'] as num).toInt(),
  startTime: json['start_time'] as String?,
  endTime: json['end_time'] as String?,
);

Map<String, dynamic> _$CreatePlanTaskRequestToJson(
  _CreatePlanTaskRequest instance,
) => <String, dynamic>{
  'name': instance.name,
  'sort_order': instance.sortOrder,
  'start_time': ?instance.startTime,
  'end_time': ?instance.endTime,
};

_CreatePlanRequest _$CreatePlanRequestFromJson(Map<String, dynamic> json) =>
    _CreatePlanRequest(
      name: json['name'] as String,
      schedule: PlanSchedule.fromJson(json['schedule'] as Map<String, dynamic>),
      startDate: json['start_date'] as String,
      endDate: json['end_date'] as String?,
      color: json['color'] as String?,
      tasks: (json['tasks'] as List<dynamic>)
          .map((e) => CreatePlanTaskRequest.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$CreatePlanRequestToJson(_CreatePlanRequest instance) =>
    <String, dynamic>{
      'name': instance.name,
      'schedule': _scheduleToJson(instance.schedule),
      'start_date': instance.startDate,
      'end_date': ?instance.endDate,
      'color': ?instance.color,
      'tasks': instance.tasks.map((e) => e.toJson()).toList(),
    };
