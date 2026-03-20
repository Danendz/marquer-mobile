// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Task _$TaskFromJson(Map<String, dynamic> json) => _Task(
  id: (json['id'] as num).toInt(),
  name: json['name'] as String,
  status: $enumDecode(_$TaskStatusEnumMap, json['status']),
  date: json['date'] as String?,
  startTime: json['start_time'] as String?,
  endTime: json['end_time'] as String?,
  taskCategoryId: (json['task_category_id'] as num?)?.toInt(),
  color: json['color'] as String?,
  createdAt: json['created_at'] as String,
  updatedAt: json['updated_at'] as String,
);

Map<String, dynamic> _$TaskToJson(_Task instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'status': _$TaskStatusEnumMap[instance.status]!,
  'date': instance.date,
  'start_time': instance.startTime,
  'end_time': instance.endTime,
  'task_category_id': instance.taskCategoryId,
  'color': instance.color,
  'created_at': instance.createdAt,
  'updated_at': instance.updatedAt,
};

const _$TaskStatusEnumMap = {
  TaskStatus.draft: 'draft',
  TaskStatus.progress: 'progress',
  TaskStatus.done: 'done',
  TaskStatus.cancelled: 'cancelled',
};
