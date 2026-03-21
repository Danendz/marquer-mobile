import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:marquer/providers/profile/theme_provider.dart';

import '../../../helpers/riverpod_helpers.dart';

void main() {
  group('themeProvider', () {
    test('build returns ThemeMode.light by default', () {
      SharedPreferences.setMockInitialValues({});

      final container = createTestContainer();
      final theme = container.read(themeProvider);

      expect(theme, ThemeMode.light);
    });

    test('setTheme updates state synchronously', () {
      SharedPreferences.setMockInitialValues({});

      final container = createTestContainer();
      expect(container.read(themeProvider), ThemeMode.light);

      container.read(themeProvider.notifier).setTheme(ThemeMode.dark);

      expect(container.read(themeProvider), ThemeMode.dark);
    });
  });
}
