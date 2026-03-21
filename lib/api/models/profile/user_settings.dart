import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_settings.freezed.dart';
part 'user_settings.g.dart';

@freezed
abstract class UserSettings with _$UserSettings {
  const factory UserSettings({
    @Default('light') String theme,
    @Default('en') String language,
    @JsonKey(name: 'notifications_enabled') @Default(true) bool notificationsEnabled,
    @JsonKey(name: 'notification_study_reminders') @Default(true) bool notificationStudyReminders,
    @JsonKey(name: 'notification_task_reminders') @Default(true) bool notificationTaskReminders,
    @JsonKey(name: 'lab_features') @Default({}) Map<String, dynamic> labFeatures,
  }) = _UserSettings;

  factory UserSettings.fromJson(Map<String, dynamic> json) =>
      _$UserSettingsFromJson(json);
}
