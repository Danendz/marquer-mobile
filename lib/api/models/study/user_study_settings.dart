import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_study_settings.freezed.dart';
part 'user_study_settings.g.dart';

@freezed
abstract class UserStudySettings with _$UserStudySettings {
  const factory UserStudySettings({
    @JsonKey(name: 'default_work_minutes') @Default(25) int defaultWorkMinutes,
    @JsonKey(name: 'default_short_break_minutes') @Default(5) int defaultShortBreakMinutes,
    @JsonKey(name: 'default_long_break_minutes') @Default(15) int defaultLongBreakMinutes,
    @JsonKey(name: 'default_cycles') @Default(4) int defaultCycles,
  }) = _UserStudySettings;

  factory UserStudySettings.fromJson(Map<String, dynamic> json) =>
      _$UserStudySettingsFromJson(json);
}
