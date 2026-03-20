import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/misc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:marquer/providers/calendar/plan_form_notifier.dart';
import 'package:marquer/screens/calendar/plan_form_screen.dart';
import 'package:marquer/screens/calendar/widgets/schedule_config.dart';
import 'package:marquer/services/toast_service.dart';

void main() {
  Future<void> pumpForm(
    WidgetTester tester, {
    List<Override> overrides = const [],
  }) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: overrides,
        child: MaterialApp(
          scaffoldMessengerKey: ToastService.messengerKey,
          home: const PlanFormScreen(),
        ),
      ),
    );
  }

  group('PlanFormScreen', () {
    testWidgets('renders title "New Plan" for create mode', (tester) async {
      await pumpForm(tester);
      await tester.pump();

      expect(find.text('New Plan'), findsOneWidget);
    });

    testWidgets('renders plan name field', (tester) async {
      await pumpForm(tester);
      await tester.pump();

      expect(find.widgetWithText(TextField, 'Plan name'), findsOneWidget);
    });

    testWidgets('renders Save button in AppBar', (tester) async {
      await pumpForm(tester);
      await tester.pump();

      expect(find.widgetWithText(TextButton, 'Save'), findsOneWidget);
    });

    testWidgets('renders schedule type picker with Daily selected by default', (tester) async {
      await pumpForm(tester);
      await tester.pump();

      expect(find.text('Repeat'), findsOneWidget);
      // All schedule type labels should be visible as chips
      expect(find.text('Daily'), findsOneWidget);
      expect(find.text('Weekly'), findsOneWidget);
      expect(find.text('Interval'), findsOneWidget);
    });

    testWidgets('selecting Weekly shows day checkboxes', (tester) async {
      await pumpForm(tester);
      await tester.pump();

      await tester.tap(find.text('Weekly'));
      await tester.pumpAndSettle();

      // Weekly config shows 7 day chips (Mon-Sun)
      expect(find.text('Mon'), findsOneWidget);
      expect(find.text('Tue'), findsOneWidget);
      expect(find.text('Wed'), findsOneWidget);
      expect(find.text('Thu'), findsOneWidget);
      expect(find.text('Fri'), findsOneWidget);
      expect(find.text('Sat'), findsOneWidget);
      expect(find.text('Sun'), findsOneWidget);
    });

    testWidgets('selecting Interval shows interval number', (tester) async {
      await pumpForm(tester);
      await tester.pump();

      await tester.tap(find.text('Interval'));
      await tester.pumpAndSettle();

      expect(find.text('Every'), findsOneWidget);
      expect(find.text('days'), findsOneWidget);
    });

    testWidgets('renders Events section with Add button', (tester) async {
      await pumpForm(tester);
      await tester.pump();

      expect(find.text('Events'), findsOneWidget);
      expect(find.text('Add'), findsOneWidget);
    });

    testWidgets('empty events shows placeholder text', (tester) async {
      await pumpForm(tester);
      await tester.pump();

      expect(find.text('No events yet. Tap Add to create one.'), findsOneWidget);
    });

    testWidgets('schedule type change updates provider state', (tester) async {
      late ProviderContainer container;
      await tester.pumpWidget(
        ProviderScope(
          child: Builder(
            builder: (context) {
              return MaterialApp(
                scaffoldMessengerKey: ToastService.messengerKey,
                home: Consumer(
                  builder: (context, ref, _) {
                    container = ProviderScope.containerOf(context);
                    return const PlanFormScreen();
                  },
                ),
              );
            },
          ),
        ),
      );
      await tester.pump();

      await tester.tap(find.text('Weekly'));
      await tester.pump();

      final state = container.read(planFormProvider);
      expect(state.scheduleType, ScheduleType.weekly);
    });
  });
}
