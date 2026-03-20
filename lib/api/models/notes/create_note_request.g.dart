// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_note_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_CreateNoteRequest _$CreateNoteRequestFromJson(Map<String, dynamic> json) =>
    _CreateNoteRequest(
      title: json['title'] as String,
      content: json['content'] as String,
    );

Map<String, dynamic> _$CreateNoteRequestToJson(_CreateNoteRequest instance) =>
    <String, dynamic>{'title': instance.title, 'content': instance.content};
