// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_AuthResponse _$AuthResponseFromJson(Map<String, dynamic> json) =>
    _AuthResponse(
      token: json['token'] as String,
      tokenType: json['token_type'] as String,
      expiresIn: (json['expires_in'] as num).toInt(),
    );

Map<String, dynamic> _$AuthResponseToJson(_AuthResponse instance) =>
    <String, dynamic>{
      'token': instance.token,
      'token_type': instance.tokenType,
      'expires_in': instance.expiresIn,
    };
