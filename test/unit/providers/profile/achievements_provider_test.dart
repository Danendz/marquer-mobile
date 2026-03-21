import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mocktail/mocktail.dart';
import 'package:marquer/api/models/api_response.dart';
import 'package:marquer/api/models/profile/achievement.dart';
import 'package:marquer/providers/profile/achievements_provider.dart';

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

  void stubGetAchievements(List<Map<String, dynamic>> achievements) {
    when(
      () => mockApi.get<List<Achievement>>(
        '/achievements',
        fromJsonT: any(named: 'fromJsonT'),
      ),
    ).thenAnswer((inv) async {
      final fromJsonT = inv.namedArguments[#fromJsonT]
          as List<Achievement> Function(Object?);
      return ApiResponse<List<Achievement>>(
        status: 200,
        success: true,
        message: 'OK',
        data: fromJsonT(achievements),
      );
    });
  }

  group('achievementsProvider', () {
    test('build fetches achievements', () async {
      stubGetAchievements([
        {
          'id': 1,
          'key': 'first_note',
          'name': 'First Note',
          'description': 'Create your first note',
          'icon': 'note_add',
          'category': 'milestone',
          'target_type': 'note_count',
          'target_value': 1,
          'unlocked': true,
          'unlocked_at': '2026-03-20T10:00:00Z',
        },
        {
          'id': 2,
          'key': 'note_collector',
          'name': 'Note Collector',
          'description': 'Create 10 notes',
          'icon': 'library_books',
          'category': 'milestone',
          'target_type': 'note_count',
          'target_value': 10,
          'unlocked': false,
          'unlocked_at': null,
        },
      ]);

      final container = createTestContainer();
      final achievements = await container.read(achievementsProvider.future);

      expect(achievements, hasLength(2));
      expect(achievements[0].unlocked, true);
      expect(achievements[1].unlocked, false);
    });

    test('refresh reloads from API', () async {
      stubGetAchievements([
        {
          'id': 1,
          'key': 'first_note',
          'name': 'First Note',
          'description': 'desc',
          'icon': 'note_add',
          'category': 'milestone',
          'target_type': 'note_count',
          'target_value': 1,
          'unlocked': false,
          'unlocked_at': null,
        },
      ]);

      final container = createTestContainer();
      await container.read(achievementsProvider.future);

      // Now stub a different response for refresh
      stubGetAchievements([
        {
          'id': 1,
          'key': 'first_note',
          'name': 'First Note',
          'description': 'desc',
          'icon': 'note_add',
          'category': 'milestone',
          'target_type': 'note_count',
          'target_value': 1,
          'unlocked': true,
          'unlocked_at': '2026-03-21T10:00:00Z',
        },
      ]);

      await container.read(achievementsProvider.notifier).refresh();

      final achievements = container.read(achievementsProvider).value!;
      expect(achievements[0].unlocked, true);
    });
  });
}
