import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:marquer/api/models/profile/user_settings.dart';
import 'package:marquer/api/services/profile_service.dart';
import 'package:marquer/providers/optimistic_mutation.dart';
import 'package:shared_preferences/shared_preferences.dart';

final settingsProvider =
    AsyncNotifierProvider<SettingsNotifier, UserSettings>(SettingsNotifier.new);

class SettingsNotifier extends AsyncNotifier<UserSettings>
    with OptimisticMutation {
  final _service = ProfileService();

  @override
  Future<UserSettings> build() async {
    final settings = await _service.getSettings();
    _cacheLocally(settings);
    return settings;
  }

  Future<void> updateTheme(String theme) async {
    final current = currentValue;
    if (current == null) return;

    state = AsyncData(current.copyWith(theme: theme));
    _cacheLocally(current.copyWith(theme: theme));

    await mutate(
      action: () => _service.upsertSettings({'theme': theme}),
      errorMessage: 'Unable to update theme',
      rollback: () => current,
      onSuccess: (_, updated) => updated,
    );
  }

  Future<void> updateLanguage(String language) async {
    final current = currentValue;
    if (current == null) return;

    state = AsyncData(current.copyWith(language: language));
    _cacheLocally(current.copyWith(language: language));

    await mutate(
      action: () => _service.upsertSettings({'language': language}),
      errorMessage: 'Unable to update language',
      rollback: () => current,
      onSuccess: (_, updated) => updated,
    );
  }

  Future<void> updateNotifications(Map<String, bool> prefs) async {
    final current = currentValue;
    if (current == null) return;

    await mutate(
      action: () => _service.upsertSettings(prefs),
      errorMessage: 'Unable to update notifications',
      rollback: () => current,
      onSuccess: (_, updated) => updated,
    );
  }

  void _cacheLocally(UserSettings settings) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('theme', settings.theme);
    await prefs.setString('language', settings.language);
  }
}
