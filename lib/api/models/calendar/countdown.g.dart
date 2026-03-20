// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'countdown.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Countdown _$CountdownFromJson(Map<String, dynamic> json) => _Countdown(
  id: (json['id'] as num).toInt(),
  name: json['name'] as String,
  targetDate: json['target_date'] as String,
  bgImage: json['bg_image'] as String,
  isPinned: json['is_pinned'] as bool,
  createdAt: json['created_at'] as String,
  updatedAt: json['updated_at'] as String,
);

Map<String, dynamic> _$CountdownToJson(_Countdown instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'target_date': instance.targetDate,
      'bg_image': instance.bgImage,
      'is_pinned': instance.isPinned,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
    };
