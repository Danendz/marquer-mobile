// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'study_subject.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_StudySubject _$StudySubjectFromJson(Map<String, dynamic> json) =>
    _StudySubject(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
      color: json['color'] as String,
      isSystem: json['is_system'] as bool,
      createdAt: json['created_at'] as String,
    );

Map<String, dynamic> _$StudySubjectToJson(_StudySubject instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'color': instance.color,
      'is_system': instance.isSystem,
      'created_at': instance.createdAt,
    };
