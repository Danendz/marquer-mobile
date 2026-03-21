import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mocktail/mocktail.dart';
import 'package:marquer/api/models/api_response.dart';
import 'package:marquer/api/models/profile/user_settings.dart';
import 'package:marquer/providers/profile/laboratory_provider.dart';

import '../../../helpers/mock_api_service.dart';
import '../../../helpers/riverpod_helpers.dart';
import '../../../helpers/test_setup.dart';

void main() {
  late MockApiService mockApi;

  setUp(() async {
    final env = await setUpTestEnvironment();
    mockApi = env.api;
  });

  tearDown(() => GetIt.instance.reset());

  void stubGetSettings(Map<String, dynamic> labFeatures) {
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
        data: fromJsonT({
          'theme': 'light',
          'language': 'en',
          'lab_features': labFeatures,
        }),
      );
    });
  }

  void stubUpsertSettings(Map<String, dynamic> labFeatures) {
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
        data: fromJsonT({
          'theme': 'light',
          'language': 'en',
          'lab_features': labFeatures,
        }),
      );
    });
  }

  group('laboratoryProvider', () {
    test('build loads labFeatures from settings', () async {
      stubGetSettings({'dark_mode': true, 'ai_assist': false});

      final container = createTestContainer();
      final features = await container.read(laboratoryProvider.future);

      expect(features, {'dark_mode': true, 'ai_assist': false});
    });

    test('toggle sets optimistic state and calls API', () async {
      stubGetSettings({'dark_mode': false});
      stubUpsertSettings({'dark_mode': true});

      final container = createTestContainer();
      await container.read(laboratoryProvider.future);

      await container
          .read(laboratoryProvider.notifier)
          .toggle('dark_mode', true);

      final features = container.read(laboratoryProvider).value!;
      expect(features['dark_mode'], true);
    });

    test('build with empty lab features', () async {
      stubGetSettings(<String, dynamic>{});

      final container = createTestContainer();
      final features = await container.read(laboratoryProvider.future);

      expect(features, isEmpty);
    });
  });
}
