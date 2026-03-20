import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:marquer/api/models/calendar/plan_for_date.dart';
import 'package:marquer/components/calendar/day_plan_list.dart';
import 'package:marquer/providers/calendar/day_plans_provider.dart';
import 'package:marquer/services/toast_service.dart';

import '../../helpers/test_setup.dart';

void main() {
  setUp(() async {
    await setUpTestEnvironment();
  });

  tearDown(() => GetIt.instance.reset());

  group('DayPlanList', () {
    testWidgets('shows nothing when plans are empty', (tester) async {
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            dayPlansProvider.overrideWith(() => _EmptyDayPlansNotifier()),
          ],
          child: MaterialApp(
            scaffoldMessengerKey: ToastService.messengerKey,
            home: const Scaffold(body: DayPlanList()),
          ),
        ),
      );
      await tester.pumpAndSettle();

      // Empty plans → SizedBox.shrink → no visible content
      expect(find.byType(DayPlanList), findsOneWidget);
      expect(find.text('Morning exercise'), findsNothing);
    });

    testWidgets('renders plan name and tasks when loaded', (tester) async {
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            dayPlansProvider.overrideWith(() => _LoadedDayPlansNotifier()),
          ],
          child: MaterialApp(
            scaffoldMessengerKey: ToastService.messengerKey,
            home: const Scaffold(body: DayPlanList()),
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('Morning Routine'), findsOneWidget);
      expect(find.text('Exercise'), findsOneWidget);
      expect(find.text('Meditation'), findsOneWidget);
    });
  });
}

class _EmptyDayPlansNotifier extends DayPlansNotifier {
  @override
  Future<List<PlanForDate>> build() async => [];
}

class _LoadedDayPlansNotifier extends DayPlansNotifier {
  @override
  Future<List<PlanForDate>> build() async => [
        const PlanForDate(
          id: 1,
          name: 'Morning Routine',
          color: '#4CAF50',
          tasks: [
            PlanTaskForDate(id: 10, name: 'Exercise', sortOrder: 0, isCompleted: false),
            PlanTaskForDate(id: 11, name: 'Meditation', sortOrder: 1, isCompleted: true),
          ],
        ),
      ];
}
