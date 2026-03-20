// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'check_latest_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_CheckLatestResponse _$CheckLatestResponseFromJson(Map<String, dynamic> json) =>
    _CheckLatestResponse(
      version: json['version'] as String,
      versionFull: json['version_full'] as String?,
      downloadUrl: json['download_url'] as String,
      changelog: json['changelog'] as String?,
    );

Map<String, dynamic> _$CheckLatestResponseToJson(
  _CheckLatestResponse instance,
) => <String, dynamic>{
  'version': instance.version,
  'version_full': instance.versionFull,
  'download_url': instance.downloadUrl,
  'changelog': instance.changelog,
};
