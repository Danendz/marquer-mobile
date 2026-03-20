// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'upsert_task_category_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_UpsertTaskCategoryRequest _$UpsertTaskCategoryRequestFromJson(
  Map<String, dynamic> json,
) => _UpsertTaskCategoryRequest(
  name: json['name'] as String,
  taskFolderId: (json['task_folder_id'] as num).toInt(),
  color: json['color'] as String?,
);

Map<String, dynamic> _$UpsertTaskCategoryRequestToJson(
  _UpsertTaskCategoryRequest instance,
) => <String, dynamic>{
  'name': instance.name,
  'task_folder_id': instance.taskFolderId,
  'color': ?instance.color,
};
