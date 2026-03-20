import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:marquer/api/models/calendar/plan_for_date.dart';
import 'package:marquer/components/calendar/plan_task_tile.dart';
import 'package:marquer/services/toast_service.dart';

import '../../helpers/test_setup.dart';

const _task = PlanTaskForDate(
  id: 1,
  name: 'Morning exercise',
  sortOrder: 0,
  startTime: '07:00',
  endTime: '07:30',
  isCompleted: false,
);

const _completedTask = PlanTaskForDate(
  id: 2,
  name: 'Read chapter 5',
  sortOrder: 1,
  isCompleted: true,
);

void main() {
  setUp(() async {
    await setUpTestEnvironment();
  });

  tearDown(() => GetIt.instance.reset());

  Future<void> pumpTile(
    WidgetTester tester,
    PlanTaskForDate task, {
    String? planColor,
  }) async {
    await tester.pumpWidget(
      ProviderScope(
        child: MaterialApp(
          scaffoldMessengerKey: ToastService.messengerKey,
          home: Scaffold(
            body: ListView(
              children: [PlanTaskTile(planId: 1, task: task, planColor: planColor)],
            ),
          ),
        ),
      ),
    );
  }

  group('PlanTaskTile', () {
    testWidgets('renders task name', (tester) async {
      await pumpTile(tester, _task);
      await tester.pump();

      expect(find.text('Morning exercise'), findsOneWidget);
    });

    testWidgets('renders time range when startTime is set', (tester) async {
      await pumpTile(tester, _task);
      await tester.pump();

      // formatTimeRange produces something like "07:00 - 07:30"
      expect(find.byIcon(Icons.access_time), findsOneWidget);
    });

    testWidgets('completed task has strikethrough', (tester) async {
      await pumpTile(tester, _completedTask);
      await tester.pump();

      final textWidget = tester.widget<Text>(
        find.text('Read chapter 5'),
      );
      expect(textWidget.style?.decoration, TextDecoration.lineThrough);
    });

    testWidgets('renders without time section when startTime is null', (tester) async {
      const noTimeTask = PlanTaskForDate(
        id: 3,
        name: 'No time task',
        sortOrder: 0,
        isCompleted: false,
      );
      await pumpTile(tester, noTimeTask);
      await tester.pump();

      expect(find.text('No time task'), findsOneWidget);
      expect(find.byIcon(Icons.access_time), findsNothing);
    });
  });
}
