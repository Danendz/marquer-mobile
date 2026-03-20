// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_task_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_CreateTaskRequest _$CreateTaskRequestFromJson(Map<String, dynamic> json) =>
    _CreateTaskRequest(
      name: json['name'] as String,
      date: json['date'] as String?,
      startTime: json['start_time'] as String?,
      endTime: json['end_time'] as String?,
      taskCategoryId: (json['task_category_id'] as num?)?.toInt(),
      color: json['color'] as String?,
    );

Map<String, dynamic> _$CreateTaskRequestToJson(_CreateTaskRequest instance) =>
    <String, dynamic>{
      'name': instance.name,
      'date': ?instance.date,
      'start_time': ?instance.startTime,
      'end_time': ?instance.endTime,
      'task_category_id': ?instance.taskCategoryId,
      'color': ?instance.color,
    };
