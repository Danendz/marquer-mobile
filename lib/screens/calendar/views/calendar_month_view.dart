import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:marquer/components/calendar/day_countdown_list.dart';
import 'package:marquer/components/calendar/day_event_list.dart';
import 'package:marquer/components/calendar/day_plan_list.dart';
import 'package:marquer/providers/calendar/calendar_focused_month_provider.dart';
import 'package:marquer/providers/calendar/calendar_overview_provider.dart';
import 'package:marquer/providers/calendar/calendar_selected_date_provider.dart';
import 'package:marquer/providers/calendar/countdowns_provider.dart';
import 'package:marquer/utils/colors.dart';
import 'package:marquer/utils/format.dart';

class CalendarMonthView extends ConsumerWidget {
  const CalendarMonthView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = getColors(context);
    final selectedDate = ref.watch(calendarSelectedDateProvider);
    final focusedMonth = ref.watch(calendarFocusedMonthProvider);
    final overviewAsync = ref.watch(calendarOverviewProvider);

    final datesWithIncomplete = overviewAsync.asData?.value.datesWithIncomplete ?? {};
    final datesWithPlans = overviewAsync.asData?.value.datesWithPlans ?? {};
    final countdownsAsync = ref.watch(countdownsProvider);
    final countdownDates = <String>{
      for (final c in countdownsAsync.asData?.value ?? []) c.targetDate,
    };

    return RefreshIndicator(
      onRefresh: () async {
        await Future.wait([
          ref.refresh(calendarOverviewProvider.future),
          ref.refresh(countdownsProvider.future),
        ]);
      },
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TableCalendar(
              firstDay: DateTime(2020),
              lastDay: DateTime(2100),
              focusedDay: focusedMonth,
              availableCalendarFormats: const {CalendarFormat.month: 'Month'},
              selectedDayPredicate: (day) => isSameDay(day, selectedDate),
              onDaySelected: (selected, focused) {
                ref.read(calendarSelectedDateProvider.notifier).select(selected);
                ref.read(calendarFocusedMonthProvider.notifier).set(focused);
              },
              onPageChanged: (focused) {
                ref.read(calendarFocusedMonthProvider.notifier).set(focused);
              },
              calendarBuilders: CalendarBuilders(
                markerBuilder: (context, day, _) {
                  final key = formatDate(day);
                  final hasTask = datesWithIncomplete.contains(key);
                  final hasCountdown = countdownDates.contains(key);
                  final hasPlan = datesWithPlans.contains(key);
                  if (!hasTask && !hasCountdown && !hasPlan) return null;
                  return Positioned(
                    bottom: 4,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        if (hasTask)
                          Container(
                            width: 6,
                            height: 6,
                            margin: const EdgeInsets.symmetric(horizontal: 1),
                            decoration: const BoxDecoration(
                              color: Colors.red,
                              shape: BoxShape.circle,
                            ),
                          ),
                        if (hasCountdown)
                          Container(
                            width: 6,
                            height: 6,
                            margin: const EdgeInsets.symmetric(horizontal: 1),
                            decoration: BoxDecoration(
                              color: colors.primary,
                              shape: BoxShape.circle,
                            ),
                          ),
                        if (hasPlan)
                          Container(
                            width: 6,
                            height: 6,
                            margin: const EdgeInsets.symmetric(horizontal: 1),
                            decoration: const BoxDecoration(
                              color: Colors.amber,
                              shape: BoxShape.circle,
                            ),
                          ),
                      ],
                    ),
                  );
                },
                todayBuilder: (context, day, focusedDay) => _DayCell(
                  day: day,
                  background: colors.primary.withValues(alpha: 0.15),
                  textColor: colors.primary,
                ),
                selectedBuilder: (context, day, focusedDay) => _DayCell(
                  day: day,
                  background: colors.primary,
                  textColor: colors.onPrimary,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Text(
                DateFormat('EEEE, MMMM d').format(selectedDate),
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
            const DayEventList(),
            const DayCountdownList(),
            const DayPlanList(),
          ],
        ),
      ),
    );
  }
}

class _DayCell extends StatelessWidget {
  final DateTime day;
  final Color background;
  final Color textColor;

  const _DayCell({required this.day, required this.background, required this.textColor});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 36,
        height: 36,
        decoration: BoxDecoration(shape: BoxShape.circle, color: background),
        child: Center(
          child: Text(
            '${day.day}',
            style: TextStyle(color: textColor, fontWeight: FontWeight.w600),
          ),
        ),
      ),
    );
  }
}
