import 'package:flutter/material.dart';
import 'package:flutter_riverpod/misc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:marquer/api/models/profile/user_settings.dart';
import 'package:marquer/providers/profile/settings_provider.dart';
import 'package:marquer/providers/profile/theme_provider.dart';
import 'package:marquer/screens/me/settings_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../helpers/mock_router.dart';
import '../../helpers/test_setup.dart';

class _LoadedSettingsNotifier extends SettingsNotifier {
  @override
  Future<UserSettings> build() async => const UserSettings();
}

class _DarkSettingsNotifier extends SettingsNotifier {
  @override
  Future<UserSettings> build() async =>
      const UserSettings(theme: 'dark');
}

class _NotificationsOffSettingsNotifier extends SettingsNotifier {
  @override
  Future<UserSettings> build() async =>
      const UserSettings(notificationsEnabled: false);
}

void main() {
  setUp(() async {
    SharedPreferences.setMockInitialValues({});
    await setUpTestEnvironment();
  });

  tearDown(() => GetIt.instance.reset());

  List<Override> overrides({SettingsNotifier? settingsNotifier}) => [
        settingsProvider
            .overrideWith(() => settingsNotifier ?? _LoadedSettingsNotifier()),
        themeProvider.overrideWith(() => ThemeNotifier()),
      ];

  group('SettingsScreen', () {
    testWidgets('renders Settings app bar', (tester) async {
      await pumpWithRouter(tester, const SettingsScreen(),
          overrides: overrides());
      await tester.pumpAndSettle();

      expect(find.text('Settings'), findsOneWidget);
    });

    testWidgets('shows theme switch (light by default)', (tester) async {
      await pumpWithRouter(tester, const SettingsScreen(),
          overrides: overrides());
      await tester.pumpAndSettle();

      expect(find.text('Theme'), findsOneWidget);
      expect(find.text('Light'), findsOneWidget);
      // The theme Switch is a direct child of ListTile, not a SwitchListTile
      // Find the first Switch in the widget tree (theme toggle)
      final switches = tester.widgetList<Switch>(find.byType(Switch));
      expect(switches.first.value, false);
    });

    testWidgets('shows dark theme switch when dark', (tester) async {
      await pumpWithRouter(tester, const SettingsScreen(),
          overrides: overrides(settingsNotifier: _DarkSettingsNotifier()));
      await tester.pumpAndSettle();

      expect(find.text('Dark'), findsOneWidget);
      final switches = tester.widgetList<Switch>(find.byType(Switch));
      expect(switches.first.value, true);
    });

    testWidgets('shows language dropdown with English', (tester) async {
      await pumpWithRouter(tester, const SettingsScreen(),
          overrides: overrides());
      await tester.pumpAndSettle();

      expect(find.text('Language'), findsOneWidget);
      expect(find.text('English'), findsAtLeast(1));
    });

    testWidgets('shows notification switches', (tester) async {
      await pumpWithRouter(tester, const SettingsScreen(),
          overrides: overrides());
      await tester.pumpAndSettle();

      expect(find.text('Notifications'), findsAtLeast(1));
      expect(find.text('Study reminders'), findsOneWidget);
      expect(find.text('Task reminders'), findsOneWidget);
    });

    testWidgets('sub-switches disabled when notifications off',
        (tester) async {
      await pumpWithRouter(tester, const SettingsScreen(),
          overrides: overrides(
              settingsNotifier: _NotificationsOffSettingsNotifier()));
      await tester.pumpAndSettle();

      // Find the study reminders SwitchListTile
      final studySwitchTile = tester.widgetList<SwitchListTile>(
        find.byType(SwitchListTile),
      );
      // The 2nd and 3rd SwitchListTiles should have onChanged == null
      final studySwitch = studySwitchTile.elementAt(1);
      final taskSwitch = studySwitchTile.elementAt(2);
      expect(studySwitch.onChanged, isNull);
      expect(taskSwitch.onChanged, isNull);
    });
  });
}
