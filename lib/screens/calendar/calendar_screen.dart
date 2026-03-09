import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:marquer/components/calendar/day_event_list.dart';
import 'package:marquer/providers/calendar/calendar_focused_month_provider.dart';
import 'package:marquer/providers/calendar/calendar_overview_provider.dart';
import 'package:marquer/providers/calendar/calendar_selected_date_provider.dart';
import 'package:marquer/utils/colors.dart';

class CalendarScreen extends ConsumerStatefulWidget {
  const CalendarScreen({super.key});

  @override
  ConsumerState<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends ConsumerState<CalendarScreen> {
  bool _showCalendar = true;

  @override
  Widget build(BuildContext context) {
    final colors = getColors(context);
    final selectedDate = ref.watch(calendarSelectedDateProvider);
    final focusedMonth = ref.watch(calendarFocusedMonthProvider);
    final overviewAsync = ref.watch(calendarOverviewProvider);

    final datesWithIncomplete = overviewAsync.asData?.value.datesWithIncomplete ?? {};

    return Scaffold(
      appBar: AppBar(
        title: const Text('Calendar'),
        actions: [
          SegmentedButton<bool>(
            segments: const [
              ButtonSegment(value: true, icon: Icon(Icons.calendar_month)),
              ButtonSegment(value: false, icon: Icon(Icons.timer_outlined)),
            ],
            selected: {_showCalendar},
            onSelectionChanged: (val) => setState(() => _showCalendar = val.first),
            showSelectedIcon: false,
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: _showCalendar ? _buildCalendarView(colors, selectedDate, focusedMonth, datesWithIncomplete) : _buildCountdownView(),
    );
  }

  Widget _buildCalendarView(
    ColorScheme colors,
    DateTime selectedDate,
    DateTime focusedMonth,
    Set<String> datesWithIncomplete,
  ) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TableCalendar(
            firstDay: DateTime(2020),
            lastDay: DateTime(2100),
            focusedDay: focusedMonth,
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
                final key = '${day.year}-${day.month.toString().padLeft(2, '0')}-${day.day.toString().padLeft(2, '0')}';
                if (!datesWithIncomplete.contains(key)) return null;
                return Positioned(
                  bottom: 4,
                  child: Container(
                    width: 6,
                    height: 6,
                    decoration: const BoxDecoration(
                      color: Colors.red,
                      shape: BoxShape.circle,
                    ),
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
        ],
      ),
    );
  }

  Widget _buildCountdownView() {
    return const Center(child: Text('No countdowns yet'));
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
