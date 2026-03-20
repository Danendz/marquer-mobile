// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task_folder.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_TaskFolder _$TaskFolderFromJson(Map<String, dynamic> json) => _TaskFolder(
  id: (json['id'] as num).toInt(),
  name: json['name'] as String,
  categories:
      (json['categories'] as List<dynamic>?)
          ?.map((e) => TaskCategory.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
  createdAt: json['created_at'] as String?,
  updatedAt: json['updated_at'] as String?,
);

Map<String, dynamic> _$TaskFolderToJson(_TaskFolder instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'categories': instance.categories.map((e) => e.toJson()).toList(),
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
    };
