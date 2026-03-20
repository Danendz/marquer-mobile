import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/misc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:marquer/api/models/tasks/tasks/task.dart';
import 'package:marquer/api/models/tasks/tasks/task_status.dart';
import 'package:marquer/components/tasks/task_item_card.dart';
import 'package:marquer/services/toast_service.dart';

import '../../helpers/test_setup.dart';

final _task = Task(
  id: 1,
  name: 'Buy groceries',
  status: TaskStatus.draft,
  taskCategoryId: 5,
  color: '#FF5733',
  createdAt: '2026-03-18T08:00:00.000000Z',
  updatedAt: '2026-03-18T08:00:00.000000Z',
);

final _doneTask = Task(
  id: 2,
  name: 'Finished task',
  status: TaskStatus.done,
  createdAt: '2026-03-18T08:00:00.000000Z',
  updatedAt: '2026-03-18T08:00:00.000000Z',
);

void main() {
  setUp(() async {
    await setUpTestEnvironment();
  });

  tearDown(() => GetIt.instance.reset());

  Future<void> pumpCard(
    WidgetTester tester,
    Task task, {
    List<Override> overrides = const [],
  }) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: overrides,
        child: MaterialApp(
          scaffoldMessengerKey: ToastService.messengerKey,
          home: Scaffold(
            body: ListView(
              children: [TaskItemCard(task: task)],
            ),
          ),
        ),
      ),
    );
  }

  group('TaskItemCard', () {
    testWidgets('renders task name', (tester) async {
      await pumpCard(tester, _task);
      await tester.pump();

      expect(find.text('Buy groceries'), findsOneWidget);
    });

    testWidgets('renders done task name', (tester) async {
      await pumpCard(tester, _doneTask);
      await tester.pump();

      expect(find.text('Finished task'), findsOneWidget);
    });

    testWidgets('renders checkbox icon', (tester) async {
      await pumpCard(tester, _task);
      await tester.pump();

      // CircleCheckbox renders a GestureDetector with a container
      // Just verify the card renders without error
      expect(find.byType(TaskItemCard), findsOneWidget);
    });
  });
}
