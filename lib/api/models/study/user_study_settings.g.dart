// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_study_settings.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_UserStudySettings _$UserStudySettingsFromJson(Map<String, dynamic> json) =>
    _UserStudySettings(
      defaultWorkMinutes: (json['default_work_minutes'] as num?)?.toInt() ?? 25,
      defaultShortBreakMinutes:
          (json['default_short_break_minutes'] as num?)?.toInt() ?? 5,
      defaultLongBreakMinutes:
          (json['default_long_break_minutes'] as num?)?.toInt() ?? 15,
      defaultCycles: (json['default_cycles'] as num?)?.toInt() ?? 4,
    );

Map<String, dynamic> _$UserStudySettingsToJson(_UserStudySettings instance) =>
    <String, dynamic>{
      'default_work_minutes': instance.defaultWorkMinutes,
      'default_short_break_minutes': instance.defaultShortBreakMinutes,
      'default_long_break_minutes': instance.defaultLongBreakMinutes,
      'default_cycles': instance.defaultCycles,
    };
