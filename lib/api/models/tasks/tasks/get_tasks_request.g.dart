// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_tasks_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_GetTasksRequest _$GetTasksRequestFromJson(Map<String, dynamic> json) =>
    _GetTasksRequest(
      taskCategoryId: (json['task_category_id'] as num?)?.toInt(),
      taskFolderId: (json['task_folder_id'] as num?)?.toInt(),
      status: $enumDecodeNullable(_$TaskStatusEnumMap, json['status']),
      date: json['date'] as String?,
    );

Map<String, dynamic> _$GetTasksRequestToJson(_GetTasksRequest instance) =>
    <String, dynamic>{
      'task_category_id': ?instance.taskCategoryId,
      'task_folder_id': ?instance.taskFolderId,
      'status': ?_$TaskStatusEnumMap[instance.status],
      'date': ?instance.date,
    };

const _$TaskStatusEnumMap = {
  TaskStatus.draft: 'draft',
  TaskStatus.progress: 'progress',
  TaskStatus.done: 'done',
  TaskStatus.cancelled: 'cancelled',
};
