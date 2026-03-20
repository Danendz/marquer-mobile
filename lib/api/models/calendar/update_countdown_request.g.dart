// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_countdown_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_UpdateCountdownRequest _$UpdateCountdownRequestFromJson(
  Map<String, dynamic> json,
) => _UpdateCountdownRequest(
  name: json['name'] as String?,
  targetDate: json['target_date'] as String?,
  isPinned: json['is_pinned'] as bool?,
  bgImage: json['bg_image'] as String?,
);

Map<String, dynamic> _$UpdateCountdownRequestToJson(
  _UpdateCountdownRequest instance,
) => <String, dynamic>{
  'name': ?instance.name,
  'target_date': ?instance.targetDate,
  'is_pinned': ?instance.isPinned,
  'bg_image': ?instance.bgImage,
};
