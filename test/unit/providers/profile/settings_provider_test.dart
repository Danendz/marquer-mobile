import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:marquer/api/models/api_response.dart';
import 'package:marquer/api/models/profile/user_settings.dart';
import 'package:marquer/providers/profile/settings_provider.dart';

import '../../../helpers/mock_api_service.dart';
import '../../../helpers/riverpod_helpers.dart';
import '../../../helpers/test_setup.dart';

void main() {
  late MockApiService mockApi;

  setUp(() async {
    SharedPreferences.setMockInitialValues({});
    final env = await setUpTestEnvironment();
    mockApi = env.api;
  });

  tearDown(() => GetIt.instance.reset());

  void stubGetSettings(Map<String, dynamic> json) {
    when(
      () => mockApi.get<UserSettings>(
        '/settings',
        fromJsonT: any(named: 'fromJsonT'),
      ),
    ).thenAnswer((inv) async {
      final fromJsonT =
          inv.namedArguments[#fromJsonT] as UserSettings Function(Object?);
      return ApiResponse<UserSettings>(
        status: 200,
        success: true,
        message: 'OK',
        data: fromJsonT(json),
      );
    });
  }

  void stubUpsertSettings(Map<String, dynamic> responseJson) {
    when(
      () => mockApi.put<UserSettings>(
        '/settings',
        body: any(named: 'body'),
        fromJsonT: any(named: 'fromJsonT'),
      ),
    ).thenAnswer((inv) async {
      final fromJsonT =
          inv.namedArguments[#fromJsonT] as UserSettings Function(Object?);
      return ApiResponse<UserSettings>(
        status: 200,
        success: true,
        message: 'OK',
        data: fromJsonT(responseJson),
      );
    });
  }

  group('settingsProvider', () {
    test('build fetches settings from API', () async {
      stubGetSettings({
        'theme': 'light',
        'language': 'en',
        'notifications_enabled': true,
        'notification_study_reminders': true,
        'notification_task_reminders': true,
        'lab_features': <String, dynamic>{},
      });

      final container = createTestContainer();
      final settings = await container.read(settingsProvider.future);

      expect(settings.theme, 'light');
      expect(settings.language, 'en');
      expect(settings.notificationsEnabled, true);
    });

    test('updateTheme sets optimistic state and calls API', () async {
      stubGetSettings({'theme': 'light', 'language': 'en'});
      stubUpsertSettings({'theme': 'dark', 'language': 'en'});

      final container = createTestContainer();
      await container.read(settingsProvider.future);

      await container.read(settingsProvider.notifier).updateTheme('dark');

      final updated = container.read(settingsProvider).value!;
      expect(updated.theme, 'dark');
    });

    test('updateTheme caches to SharedPreferences', () async {
      stubGetSettings({'theme': 'light', 'language': 'en'});
      stubUpsertSettings({'theme': 'dark', 'language': 'en'});

      final container = createTestContainer();
      await container.read(settingsProvider.future);
      await container.read(settingsProvider.notifier).updateTheme('dark');

      // Give async SharedPreferences write time to complete
      await Future<void>.delayed(const Duration(milliseconds: 50));

      final prefs = await SharedPreferences.getInstance();
      expect(prefs.getString('theme'), 'dark');
    });

    test('updateLanguage sets optimistic state and calls API', () async {
      stubGetSettings({'theme': 'light', 'language': 'en'});
      stubUpsertSettings({'theme': 'light', 'language': 'fr'});

      final container = createTestContainer();
      await container.read(settingsProvider.future);

      await container.read(settingsProvider.notifier).updateLanguage('fr');

      final updated = container.read(settingsProvider).value!;
      expect(updated.language, 'fr');
    });

    test('updateNotifications calls API with map', () async {
      stubGetSettings({
        'theme': 'light',
        'language': 'en',
        'notifications_enabled': true,
      });
      stubUpsertSettings({
        'theme': 'light',
        'language': 'en',
        'notifications_enabled': false,
      });

      final container = createTestContainer();
      await container.read(settingsProvider.future);

      await container
          .read(settingsProvider.notifier)
          .updateNotifications({'notifications_enabled': false});

      final updated = container.read(settingsProvider).value!;
      expect(updated.notificationsEnabled, false);
    });
  });
}
