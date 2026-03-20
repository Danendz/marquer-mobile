// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_countdown_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_CreateCountdownRequest _$CreateCountdownRequestFromJson(
  Map<String, dynamic> json,
) => _CreateCountdownRequest(
  name: json['name'] as String,
  targetDate: json['target_date'] as String,
  bgImage: json['bg_image'] as String,
);

Map<String, dynamic> _$CreateCountdownRequestToJson(
  _CreateCountdownRequest instance,
) => <String, dynamic>{
  'name': instance.name,
  'target_date': instance.targetDate,
  'bg_image': instance.bgImage,
};
