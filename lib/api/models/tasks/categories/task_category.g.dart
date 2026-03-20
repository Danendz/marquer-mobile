// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task_category.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_TaskCategory _$TaskCategoryFromJson(Map<String, dynamic> json) =>
    _TaskCategory(
      id: (json['id'] as num?)?.toInt(),
      name: json['name'] as String,
      color: json['color'] as String,
      tasksCount: (json['tasks_count'] as num?)?.toInt() ?? 0,
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
    );

Map<String, dynamic> _$TaskCategoryToJson(_TaskCategory instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'color': instance.color,
      'tasks_count': instance.tasksCount,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
    };
