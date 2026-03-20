import 'package:flutter_test/flutter_test.dart';
import 'package:marquer/api/models/calendar/calendar_overview.dart';
import 'package:marquer/api/models/calendar/countdown.dart';
import 'package:marquer/api/models/calendar/plan.dart';
import 'package:marquer/api/models/calendar/plan_for_date.dart';
import 'package:marquer/api/models/calendar/plan_schedule.dart';
import 'package:marquer/api/models/calendar/plan_task.dart';

void main() {
  group('Countdown', () {
    test('round-trip fromJson/toJson', () {
      final json = {
        'id': 1, 'name': 'Birthday', 'target_date': '2026-12-25',
        'bg_image': 'xmas.jpg', 'is_pinned': true,
        'created_at': 'c', 'updated_at': 'u',
      };
      final obj = Countdown.fromJson(json);
      expect(obj.name, 'Birthday');
      expect(obj.isPinned, true);
      expect(Countdown.fromJson(obj.toJson()), obj);
    });

    test('copyWith changes one field', () {
      final c = Countdown(id: 1, name: 'A', targetDate: 'd', bgImage: 'b', isPinned: false, createdAt: 'c', updatedAt: 'u');
      expect(c.copyWith(isPinned: true).isPinned, true);
      expect(c.copyWith(isPinned: true).name, 'A');
    });
  });

  group('PlanTask', () {
    test('round-trip', () {
      final json = {'id': 1, 'name': 'Read', 'sort_order': 0, 'start_time': '09:00', 'end_time': null};
      final task = PlanTask.fromJson(json);
      expect(task.sortOrder, 0);
      expect(task.startTime, '09:00');
      expect(PlanTask.fromJson(task.toJson()), task);
    });
  });

  group('PlanSchedule', () {
    test('daily', () {
      final json = {'type': 'daily'};
      final s = PlanSchedule.fromJson(json);
      expect(s, isA<DailySchedule>());
      expect(s.toJson(), {'type': 'daily'});
    });

    test('weekly', () {
      final s = PlanSchedule.fromJson({'type': 'weekly', 'days': [0, 2, 4]});
      expect(s, isA<WeeklySchedule>());
      expect((s as WeeklySchedule).days, [0, 2, 4]);
      expect(s.toJson(), {'type': 'weekly', 'days': [0, 2, 4]});
    });

    test('interval', () {
      final s = PlanSchedule.fromJson({'type': 'interval', 'every': 3});
      expect(s, isA<IntervalSchedule>());
      expect(s.toJson(), {'type': 'interval', 'every': 3});
    });

    test('monthly_dates', () {
      final s = PlanSchedule.fromJson({'type': 'monthly_dates', 'days': [1, 15]});
      expect(s, isA<MonthlyDatesSchedule>());
      expect(s.toJson(), {'type': 'monthly_dates', 'days': [1, 15]});
    });

    test('monthly_weekday', () {
      final s = PlanSchedule.fromJson({'type': 'monthly_weekday', 'week': -1, 'weekday': 4});
      expect(s, isA<MonthlyWeekdaySchedule>());
      expect(s.toJson(), {'type': 'monthly_weekday', 'week': -1, 'weekday': 4});
    });
  });

  group('Plan', () {
    test('round-trip with schedule and tasks', () {
      final json = {
        'id': 1, 'name': 'Morning Routine',
        'schedule': {'type': 'daily'},
        'start_date': '2026-01-01', 'end_date': null,
        'is_active': true, 'color': '#00F',
        'tasks': [
          {'id': 1, 'name': 'Meditate', 'sort_order': 0},
        ],
        'created_at': 'c', 'updated_at': 'u',
      };
      final plan = Plan.fromJson(json);
      expect(plan.schedule, isA<DailySchedule>());
      expect(plan.tasks, hasLength(1));
      expect(Plan.fromJson(plan.toJson()), plan);
    });
  });

  group('PlanForDate', () {
    test('round-trip', () {
      final json = {
        'id': 1, 'name': 'Plan', 'color': null,
        'tasks': [
          {'id': 1, 'name': 'T', 'sort_order': 0, 'is_completed': false},
        ],
      };
      final obj = PlanForDate.fromJson(json);
      expect(obj.tasks[0].isCompleted, false);
      expect(PlanForDate.fromJson(obj.toJson()), obj);
    });
  });

  group('CalendarOverview', () {
    test('fromJson maps tasks/plan_tasks to sets', () {
      final json = {
        'tasks': ['2026-03-18', '2026-03-19'],
        'plan_tasks': ['2026-03-20'],
      };
      final obj = CalendarOverview.fromJson(json);
      expect(obj.datesWithIncomplete, {'2026-03-18', '2026-03-19'});
      expect(obj.datesWithPlans, {'2026-03-20'});
    });
  });
}
