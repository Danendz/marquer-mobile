// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'list_note.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ListNote _$ListNoteFromJson(Map<String, dynamic> json) => _ListNote(
  id: (json['id'] as num).toInt(),
  title: json['title'] as String,
  createdAt: json['created_at'] as String,
  updatedAt: json['updated_at'] as String,
);

Map<String, dynamic> _$ListNoteToJson(_ListNote instance) => <String, dynamic>{
  'id': instance.id,
  'title': instance.title,
  'created_at': instance.createdAt,
  'updated_at': instance.updatedAt,
};
