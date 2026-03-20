import 'package:flutter/material.dart';
import 'package:flutter_riverpod/misc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:marquer/api/models/calendar/calendar_overview.dart';
import 'package:marquer/api/models/calendar/countdown.dart';
import 'package:marquer/api/models/calendar/plan.dart';
import 'package:marquer/api/models/calendar/plan_for_date.dart';
import 'package:marquer/api/models/tasks/tasks/task.dart';
import 'package:marquer/providers/calendar/calendar_day_events_provider.dart';
import 'package:marquer/providers/calendar/calendar_overview_provider.dart';
import 'package:marquer/providers/calendar/countdowns_provider.dart';
import 'package:marquer/providers/calendar/day_plans_provider.dart';
import 'package:marquer/providers/calendar/plans_provider.dart';
import 'package:marquer/screens/calendar/calendar_screen.dart';

import '../../helpers/mock_router.dart';
import '../../helpers/test_setup.dart';

/// Notifier that returns an empty list of countdowns without hitting the API.
class _EmptyCountdownsNotifier extends CountdownsNotifier {
  @override
  Future<List<Countdown>> build() async => [];
}

/// Notifier that returns an empty list of plans without hitting the API.
class _EmptyPlansNotifier extends PlansNotifier {
  @override
  Future<List<Plan>> build() async => [];
}

/// Notifier that returns an empty calendar overview without hitting the API.
class _EmptyCalendarOverviewNotifier extends CalendarOverviewNotifier {
  @override
  Future<CalendarOverview> build() async => const CalendarOverview(
        datesWithIncomplete: {},
        datesWithPlans: {},
      );
}

/// Notifier that returns an empty list of day events without hitting the API.
class _EmptyDayEventsNotifier extends CalendarDayEventsNotifier {
  @override
  Future<List<Task>> build() async => [];
}

/// Notifier that returns an empty list of day plans without hitting the API.
class _EmptyDayPlansNotifier extends DayPlansNotifier {
  @override
  Future<List<PlanForDate>> build() async => [];
}

void main() {
  late List<Override> overrides;

  setUp(() async {
    await setUpTestEnvironment();
    overrides = [
      countdownsProvider.overrideWith(_EmptyCountdownsNotifier.new),
      plansProvider.overrideWith(_EmptyPlansNotifier.new),
      calendarOverviewProvider.overrideWith(_EmptyCalendarOverviewNotifier.new),
      calendarDayEventsProvider.overrideWith(_EmptyDayEventsNotifier.new),
      dayPlansProvider.overrideWith(_EmptyDayPlansNotifier.new),
    ];
  });

  tearDown(() async {
    await GetIt.instance.reset();
  });

  group('CalendarScreen', () {
    testWidgets('renders title and segmented button with three tabs',
        (tester) async {
      await pumpWithRouter(tester, const CalendarScreen(),
          overrides: overrides);
      await tester.pumpAndSettle();

      expect(find.text('Calendar'), findsOneWidget);
      expect(find.byIcon(Icons.calendar_month), findsOneWidget);
      expect(find.byIcon(Icons.timer_outlined), findsOneWidget);
      expect(find.byIcon(Icons.checklist_outlined), findsOneWidget);
    });

    testWidgets('no FAB on the calendar tab (default)', (tester) async {
      await pumpWithRouter(tester, const CalendarScreen(),
          overrides: overrides);
      await tester.pumpAndSettle();

      expect(find.byType(FloatingActionButton), findsNothing);
    });

    testWidgets('shows FAB after switching to the countdown tab',
        (tester) async {
      await pumpWithRouter(tester, const CalendarScreen(),
          overrides: overrides);
      await tester.pumpAndSettle();

      await tester.tap(find.byIcon(Icons.timer_outlined));
      await tester.pumpAndSettle();

      expect(find.byType(FloatingActionButton), findsOneWidget);
    });

    testWidgets('shows FAB after switching to the plans tab', (tester) async {
      await pumpWithRouter(tester, const CalendarScreen(),
          overrides: overrides);
      await tester.pumpAndSettle();

      await tester.tap(find.byIcon(Icons.checklist_outlined));
      await tester.pumpAndSettle();

      expect(find.byType(FloatingActionButton), findsOneWidget);
    });

    testWidgets('view mode toggle is visible only on the calendar tab',
        (tester) async {
      await pumpWithRouter(tester, const CalendarScreen(),
          overrides: overrides);
      await tester.pumpAndSettle();

      // Default view mode is month, so the toggle icon should be
      // view_week_outlined (offering to switch to week).
      expect(find.byIcon(Icons.view_week_outlined), findsOneWidget);

      // Switch to countdown tab.
      await tester.tap(find.byIcon(Icons.timer_outlined));
      await tester.pumpAndSettle();

      // The toggle icons should both be absent.
      expect(find.byIcon(Icons.view_week_outlined), findsNothing);
      expect(find.byIcon(Icons.calendar_view_month), findsNothing);
    });

    testWidgets('tapping the view mode toggle switches the icon',
        (tester) async {
      await pumpWithRouter(tester, const CalendarScreen(),
          overrides: overrides);
      await tester.pumpAndSettle();

      // Default is month view -> icon shows view_week_outlined.
      expect(find.byIcon(Icons.view_week_outlined), findsOneWidget);
      expect(find.byIcon(Icons.calendar_view_month), findsNothing);

      // Tap the toggle to switch to week view.
      await tester.tap(find.byIcon(Icons.view_week_outlined));
      await tester.pumpAndSettle();

      // Now the icon should be calendar_view_month (offering to switch back).
      expect(find.byIcon(Icons.calendar_view_month), findsOneWidget);
      expect(find.byIcon(Icons.view_week_outlined), findsNothing);
    });

    testWidgets('FAB disappears when switching back to the calendar tab',
        (tester) async {
      await pumpWithRouter(tester, const CalendarScreen(),
          overrides: overrides);
      await tester.pumpAndSettle();

      // Go to countdown tab (FAB appears).
      await tester.tap(find.byIcon(Icons.timer_outlined));
      await tester.pumpAndSettle();
      expect(find.byType(FloatingActionButton), findsOneWidget);

      // Go back to calendar tab (FAB disappears).
      await tester.tap(find.byIcon(Icons.calendar_month));
      await tester.pumpAndSettle();
      expect(find.byType(FloatingActionButton), findsNothing);
    });

    testWidgets('view mode toggle reappears when returning to calendar tab',
        (tester) async {
      await pumpWithRouter(tester, const CalendarScreen(),
          overrides: overrides);
      await tester.pumpAndSettle();

      // Toggle is visible on calendar tab.
      expect(find.byIcon(Icons.view_week_outlined), findsOneWidget);

      // Switch to plans tab.
      await tester.tap(find.byIcon(Icons.checklist_outlined));
      await tester.pumpAndSettle();
      expect(find.byIcon(Icons.view_week_outlined), findsNothing);

      // Switch back to calendar tab.
      await tester.tap(find.byIcon(Icons.calendar_month));
      await tester.pumpAndSettle();
      expect(find.byIcon(Icons.view_week_outlined), findsOneWidget);
    });
  });
}
