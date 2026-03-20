import 'package:flutter_test/flutter_test.dart';
import 'package:marquer/api/models/calendar/plan.dart';
import 'package:marquer/api/models/calendar/plan_schedule.dart';
import 'package:marquer/api/models/calendar/plan_task.dart';
import 'package:marquer/providers/calendar/plan_form_notifier.dart';
import 'package:marquer/screens/calendar/widgets/plan_event_list.dart';
import 'package:marquer/screens/calendar/widgets/schedule_config.dart';

import '../../../helpers/riverpod_helpers.dart';

void main() {
  group('PlanFormNotifier', () {
    test('initial state has daily schedule and no tasks', () {
      final container = createTestContainer();
      final state = container.read(planFormProvider);

      expect(state.name, '');
      expect(state.scheduleType, ScheduleType.daily);
      expect(state.tasks, isEmpty);
      expect(state.hasEndDate, false);
      expect(state.color, isNull);
    });

    test('setScheduleType updates type', () {
      final container = createTestContainer();
      container.read(planFormProvider.notifier).setScheduleType(ScheduleType.weekly);

      expect(container.read(planFormProvider).scheduleType, ScheduleType.weekly);
    });

    test('setWeeklyDays updates days list', () {
      final container = createTestContainer();
      container.read(planFormProvider.notifier).setWeeklyDays([0, 2, 4]);

      expect(container.read(planFormProvider).weeklyDays, [0, 2, 4]);
    });

    test('setIntervalEvery updates interval', () {
      final container = createTestContainer();
      container.read(planFormProvider.notifier).setIntervalEvery(3);

      expect(container.read(planFormProvider).intervalEvery, 3);
    });

    test('addTask appends to task list', () {
      final container = createTestContainer();
      final notifier = container.read(planFormProvider.notifier);

      notifier.addTask(PlanTaskItem(name: 'Task 1', sortOrder: 0));
      notifier.addTask(PlanTaskItem(name: 'Task 2', sortOrder: 1));

      final tasks = container.read(planFormProvider).tasks;
      expect(tasks, hasLength(2));
      expect(tasks[0].name, 'Task 1');
      expect(tasks[1].name, 'Task 2');
    });

    test('removeTask removes by index', () {
      final container = createTestContainer();
      final notifier = container.read(planFormProvider.notifier);

      notifier.addTask(PlanTaskItem(name: 'A', sortOrder: 0));
      notifier.addTask(PlanTaskItem(name: 'B', sortOrder: 1));
      notifier.addTask(PlanTaskItem(name: 'C', sortOrder: 2));
      notifier.removeTask(1);

      final tasks = container.read(planFormProvider).tasks;
      expect(tasks, hasLength(2));
      expect(tasks[0].name, 'A');
      expect(tasks[1].name, 'C');
    });

    test('updateTask replaces at index', () {
      final container = createTestContainer();
      final notifier = container.read(planFormProvider.notifier);

      notifier.addTask(PlanTaskItem(name: 'Old', sortOrder: 0));
      notifier.updateTask(0, PlanTaskItem(name: 'New', sortOrder: 0, startTime: '09:00'));

      final task = container.read(planFormProvider).tasks[0];
      expect(task.name, 'New');
      expect(task.startTime, '09:00');
    });

    test('setStartDate clears endDate if it precedes new start', () {
      final container = createTestContainer();
      final notifier = container.read(planFormProvider.notifier);

      final start = DateTime(2026, 3, 10);
      final end = DateTime(2026, 3, 15);
      notifier.setStartDate(start);
      notifier.setEndDate(end);
      notifier.setHasEndDate(true);

      // Move start past end
      notifier.setStartDate(DateTime(2026, 3, 20));

      final state = container.read(planFormProvider);
      expect(state.endDate, isNull);
      expect(state.hasEndDate, false);
    });

    test('setHasEndDate(false) clears endDate', () {
      final container = createTestContainer();
      final notifier = container.read(planFormProvider.notifier);

      notifier.setEndDate(DateTime(2026, 5, 1));
      notifier.setHasEndDate(true);
      expect(container.read(planFormProvider).hasEndDate, true);

      notifier.setHasEndDate(false);
      final state = container.read(planFormProvider);
      expect(state.hasEndDate, false);
      expect(state.endDate, isNull);
    });

    test('validate returns error for empty name', () {
      final container = createTestContainer();
      container.read(planFormProvider.notifier).addTask(
        PlanTaskItem(name: 'Task', sortOrder: 0),
      );

      expect(container.read(planFormProvider).validate(), 'Plan name is required');
    });

    test('validate returns error for no tasks', () {
      final container = createTestContainer();
      container.read(planFormProvider.notifier).setName('Plan A');

      expect(container.read(planFormProvider).validate(), 'At least one event is required');
    });

    test('validate returns null when valid', () {
      final container = createTestContainer();
      final notifier = container.read(planFormProvider.notifier);

      notifier.setName('Plan A');
      notifier.addTask(PlanTaskItem(name: 'Task 1', sortOrder: 0));

      expect(container.read(planFormProvider).validate(), isNull);
    });

    test('validTasks excludes empty names and sorts by startTime', () {
      final container = createTestContainer();
      final notifier = container.read(planFormProvider.notifier);

      notifier.addTask(PlanTaskItem(name: 'Late', sortOrder: 0, startTime: '14:00'));
      notifier.addTask(PlanTaskItem(name: '', sortOrder: 1)); // excluded
      notifier.addTask(PlanTaskItem(name: 'Early', sortOrder: 2, startTime: '09:00'));
      notifier.addTask(PlanTaskItem(name: 'No time', sortOrder: 3));

      final valid = container.read(planFormProvider).validTasks;
      expect(valid, hasLength(3));
      expect(valid[0].name, 'No time'); // no startTime comes first
      expect(valid[1].name, 'Early');
      expect(valid[2].name, 'Late');
    });

    test('buildSchedule returns correct schedule for each type', () {
      final container = createTestContainer();
      final notifier = container.read(planFormProvider.notifier);

      // Daily
      expect(container.read(planFormProvider).buildSchedule(), isA<DailySchedule>());

      // Weekly
      notifier.setScheduleType(ScheduleType.weekly);
      notifier.setWeeklyDays([0, 4]);
      final weekly = container.read(planFormProvider).buildSchedule() as WeeklySchedule;
      expect(weekly.days, [0, 4]);

      // Interval
      notifier.setScheduleType(ScheduleType.interval);
      notifier.setIntervalEvery(3);
      final interval = container.read(planFormProvider).buildSchedule() as IntervalSchedule;
      expect(interval.every, 3);
    });

    test('loadFromPlan populates state from existing plan', () {
      final container = createTestContainer();
      final notifier = container.read(planFormProvider.notifier);

      final plan = Plan(
        id: 1,
        name: 'Existing Plan',
        schedule: const WeeklySchedule(days: [0, 2, 4]),
        startDate: '2026-03-01',
        endDate: '2026-06-01',
        isActive: true,
        color: '#FF0000',
        tasks: const [
          PlanTask(id: 10, name: 'Task A', sortOrder: 0, startTime: '09:00'),
          PlanTask(id: 11, name: 'Task B', sortOrder: 1),
        ],
        createdAt: '2026-03-01T00:00:00Z',
        updatedAt: '2026-03-01T00:00:00Z',
      );

      notifier.loadFromPlan(plan);
      final state = container.read(planFormProvider);

      expect(state.name, 'Existing Plan');
      expect(state.scheduleType, ScheduleType.weekly);
      expect(state.weeklyDays, [0, 2, 4]);
      expect(state.startDate, DateTime(2026, 3, 1));
      expect(state.endDate, DateTime(2026, 6, 1));
      expect(state.hasEndDate, true);
      expect(state.color, '#FF0000');
      expect(state.tasks, hasLength(2));
      expect(state.tasks[0].name, 'Task A');
      expect(state.tasks[0].id, 10);
      expect(state.tasks[1].startTime, isNull);
    });
  });
}
