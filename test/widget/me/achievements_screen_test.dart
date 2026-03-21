import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:marquer/api/models/profile/achievement.dart';
import 'package:marquer/providers/profile/achievements_provider.dart';
import 'package:marquer/screens/me/achievements_screen.dart';

import '../../helpers/mock_router.dart';
import '../../helpers/test_setup.dart';

class _LoadedAchievementsNotifier extends AchievementsNotifier {
  @override
  Future<List<Achievement>> build() async => const [
        Achievement(
          id: 1,
          key: 'first_note',
          name: 'First Note',
          description: 'Create your first note',
          icon: 'note_add',
          category: 'milestone',
          targetType: 'note_count',
          targetValue: 1,
          unlocked: true,
          unlockedAt: '2026-03-20T10:00:00Z',
        ),
        Achievement(
          id: 2,
          key: 'note_collector',
          name: 'Note Collector',
          description: 'Create 10 notes',
          icon: 'library_books',
          category: 'milestone',
          targetType: 'note_count',
          targetValue: 10,
          unlocked: false,
        ),
      ];
}

class _EmptyAchievementsNotifier extends AchievementsNotifier {
  @override
  Future<List<Achievement>> build() async => [];
}

void main() {
  setUp(() async {
    await setUpTestEnvironment();
  });

  tearDown(() => GetIt.instance.reset());

  group('AchievementsScreen', () {
    testWidgets('renders Achievements app bar', (tester) async {
      await pumpWithRouter(tester, const AchievementsScreen(), overrides: [
        achievementsProvider
            .overrideWith(() => _LoadedAchievementsNotifier()),
      ]);
      await tester.pumpAndSettle();

      expect(find.text('Achievements'), findsOneWidget);
    });

    testWidgets('shows achievement names in grid', (tester) async {
      await pumpWithRouter(tester, const AchievementsScreen(), overrides: [
        achievementsProvider
            .overrideWith(() => _LoadedAchievementsNotifier()),
      ]);
      await tester.pumpAndSettle();

      expect(find.text('First Note'), findsOneWidget);
      expect(find.text('Note Collector'), findsOneWidget);
    });

    testWidgets('unlocked shows formatted date', (tester) async {
      await pumpWithRouter(tester, const AchievementsScreen(), overrides: [
        achievementsProvider
            .overrideWith(() => _LoadedAchievementsNotifier()),
      ]);
      await tester.pumpAndSettle();

      // Format: d/m/yyyy
      expect(find.text('20/3/2026'), findsOneWidget);
    });

    testWidgets('shows descriptions', (tester) async {
      await pumpWithRouter(tester, const AchievementsScreen(), overrides: [
        achievementsProvider
            .overrideWith(() => _LoadedAchievementsNotifier()),
      ]);
      await tester.pumpAndSettle();

      expect(find.text('Create your first note'), findsOneWidget);
      expect(find.text('Create 10 notes'), findsOneWidget);
    });

    testWidgets('empty list renders grid with no items', (tester) async {
      await pumpWithRouter(tester, const AchievementsScreen(), overrides: [
        achievementsProvider
            .overrideWith(() => _EmptyAchievementsNotifier()),
      ]);
      await tester.pumpAndSettle();

      expect(find.byType(GridView), findsOneWidget);
      expect(find.byType(Card), findsNothing);
    });
  });
}
