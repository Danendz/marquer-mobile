import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:marquer/api/models/calendar/week_data.dart';
import 'package:marquer/api/models/tasks/tasks/task.dart';
import 'package:marquer/api/models/tasks/tasks/update_task_request.dart';
import 'package:marquer/components/calendar/add_event_sheet.dart';
import 'package:marquer/components/calendar/week_view/week_event.dart';
import 'package:marquer/components/shared/task_edit_sheet.dart';
import 'package:marquer/providers/calendar/calendar_selected_date_provider.dart';
import 'package:marquer/providers/calendar/week_data_provider.dart';
import 'package:marquer/utils/action_sheet.dart';
import 'package:marquer/utils/format.dart';

const double _kPixelsPerHour = 60.0;
const double _kPixelsPerMinute = _kPixelsPerHour / 60;
const double _kTimeGutter = 44.0;
const double _kDayCount = 7;

class WeekView extends ConsumerStatefulWidget {
  const WeekView({super.key});

  @override
  ConsumerState<WeekView> createState() => _WeekViewState();
}

class _WeekViewState extends ConsumerState<WeekView> {
  late final PageController _pageController;
  late DateTime _baseMonday;
  static const int _kInitialPage = 1000;
  double _scrollOffset =
      ((DateTime.now().hour * _kPixelsPerHour) - 80).clamp(0.0, double.infinity);

  @override
  void initState() {
    super.initState();
    final selected = ref.read(calendarSelectedDateProvider);
    _baseMonday = _mondayOf(selected);
    _pageController = PageController(initialPage: _kInitialPage);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  DateTime _mondayOf(DateTime d) => d.subtract(Duration(days: d.weekday - 1));

  DateTime _mondayForPage(int page) =>
      _baseMonday.add(Duration(days: (page - _kInitialPage) * 7));

  void _onPageChanged(int page) {
    final monday = _mondayForPage(page);
    final selected = ref.read(calendarSelectedDateProvider);
    // Keep same weekday in the new week
    final weekday = selected.weekday; // 1=Mon..7=Sun
    final newDate = monday.add(Duration(days: weekday - 1));
    ref.read(calendarSelectedDateProvider.notifier).select(newDate);
  }

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      controller: _pageController,
      onPageChanged: _onPageChanged,
      itemBuilder: (context, page) {
        final monday = _mondayForPage(page);
        return _WeekPage(
          monday: monday,
          initialScrollOffset: _scrollOffset,
          onScrollChanged: (offset) => _scrollOffset = offset,
        );
      },
    );
  }
}

class _WeekPage extends ConsumerStatefulWidget {
  final DateTime monday;
  final double initialScrollOffset;
  final void Function(double)? onScrollChanged;

  const _WeekPage({
    required this.monday,
    required this.initialScrollOffset,
    this.onScrollChanged,
  });

  @override
  ConsumerState<_WeekPage> createState() => _WeekPageState();
}

class _WeekPageState extends ConsumerState<_WeekPage> {
  late final ScrollController _scrollController;

  List<DateTime> get _days => List.generate(7, (i) => widget.monday.add(Duration(days: i)));

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController(initialScrollOffset: widget.initialScrollOffset);
    _scrollController.addListener(() => widget.onScrollChanged?.call(_scrollController.offset));
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final mondayStr = formatDate(widget.monday);
    final weekAsync = ref.watch(weekDataProvider(mondayStr));
    final selected = ref.watch(calendarSelectedDateProvider);
    final today = DateTime.now();
    final todayStr = formatDate(today);
    final colorScheme = Theme.of(context).colorScheme;

    final days = _days;

    return Column(
      children: [
        _DayHeaders(days: days, selected: selected, today: todayStr, colorScheme: colorScheme),
        weekAsync.when(
          loading: () => const Expanded(child: Center(child: CircularProgressIndicator())),
          error: (e, _) => const Expanded(child: Center(child: Text('Failed to load'))),
          data: (data) => _WeekBody(
            days: days,
            data: data,
            scrollController: _scrollController,
            colorScheme: colorScheme,
            mondayStr: mondayStr,
          ),
        ),
      ],
    );
  }
}

class _DayHeaders extends ConsumerWidget {
  final List<DateTime> days;
  final DateTime selected;
  final String today;
  final ColorScheme colorScheme;

  const _DayHeaders({
    required this.days,
    required this.selected,
    required this.today,
    required this.colorScheme,
  });

  static const _dayLabels = ['M', 'T', 'W', 'T', 'F', 'S', 'S'];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedStr = formatDate(selected);
    return Container(
      padding: const EdgeInsets.only(left: _kTimeGutter),
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: colorScheme.outlineVariant, width: 0.5)),
      ),
      child: Row(
        children: List.generate(7, (i) {
          final day = days[i];
          final dateStr = formatDate(day);
          final isToday = dateStr == today;
          final isSelected = dateStr == selectedStr;

          return Expanded(
            child: GestureDetector(
              onTap: () => ref.read(calendarSelectedDateProvider.notifier).select(day),
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Column(
                  children: [
                    Text(
                      _dayLabels[i],
                      style: TextStyle(
                        fontSize: 11,
                        color: colorScheme.onSurface.withValues(alpha: 0.6),
                      ),
                    ),
                    const SizedBox(height: 2),
                    Container(
                      width: 28,
                      height: 28,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: isToday
                            ? colorScheme.primary
                            : isSelected
                                ? colorScheme.primaryContainer
                                : Colors.transparent,
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        '${day.day}',
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: isToday
                              ? colorScheme.onPrimary
                              : isSelected
                                  ? colorScheme.onPrimaryContainer
                                  : colorScheme.onSurface,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}

class _WeekBody extends ConsumerWidget {
  final List<DateTime> days;
  final WeekData data;
  final ScrollController scrollController;
  final ColorScheme colorScheme;
  final String mondayStr;

  const _WeekBody({
    required this.days,
    required this.data,
    required this.scrollController,
    required this.colorScheme,
    required this.mondayStr,
  });

  List<WeekEvent> _eventsForDay(DateTime day, ColorScheme colors) {
    final dateStr = formatDate(day);
    final events = <WeekEvent>[];

    for (final task in data.tasks[dateStr] ?? []) {
      events.add(TaskEvent(task));
    }
    for (final pt in data.planTasks[dateStr] ?? []) {
      events.add(PlanTaskEvent(pt, dateStr));
    }
    for (final cd in data.countdowns) {
      if (cd.targetDate == dateStr) {
        events.add(CountdownEvent(cd, colors.primary));
      }
    }

    return events;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final allDayEventsByDay = <List<WeekEvent>>[];
    final timedEventsByDay = <List<WeekEvent>>[];
    for (var i = 0; i < 7; i++) {
      final events = _eventsForDay(days[i], colorScheme);
      allDayEventsByDay.add(events.where((e) => e.isAllDay).toList());
      timedEventsByDay.add(events.where((e) => !e.isAllDay).toList());
    }

    final hasAllDay = allDayEventsByDay.any((list) => list.isNotEmpty);

    return Expanded(
      child: Column(
        children: [
          if (hasAllDay)
            _AllDayRow(
              days: days,
              allDayEventsByDay: allDayEventsByDay,
              colorScheme: colorScheme,
              onEventTap: (event) => _handleTap(event, ref, context),
              onEventLongPress: (event) => _handleLongPress(event, ref, context),
            ),
          Expanded(
            child: SingleChildScrollView(
              controller: scrollController,
              child: SizedBox(
                height: 24 * _kPixelsPerHour,
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    final columnWidth = (constraints.maxWidth - _kTimeGutter) / _kDayCount;
                    return Stack(
                      children: [
                        // Time gutter labels — explicit position so the all-Positioned inner Stack
                        // doesn't get 0 intrinsic height and land in unexpected place
                        Positioned(
                          left: 0,
                          top: 0,
                          bottom: 0,
                          child: SizedBox(
                            width: _kTimeGutter,
                            child: _TimeGrid(colorScheme: colorScheme),
                          ),
                        ),
                        // Full-width hour lines
                        ...List.generate(24, (hour) {
                          return Positioned(
                            top: hour * _kPixelsPerHour,
                            left: _kTimeGutter,
                            right: 0,
                            child: Container(
                              height: 0.5,
                              color: colorScheme.outlineVariant,
                            ),
                          );
                        }),
                        // Vertical day dividers (between columns)
                        ...List.generate(6, (i) {
                          return Positioned(
                            top: 0,
                            bottom: 0,
                            left: _kTimeGutter + columnWidth * (i + 1),
                            child: Container(
                              width: 1,
                              color: colorScheme.outlineVariant,
                            ),
                          );
                        }),
                        // Event columns
                        Positioned(
                          left: _kTimeGutter,
                          top: 0,
                          right: 0,
                          bottom: 0,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: List.generate(7, (i) {
                              return _DayColumn(
                                width: columnWidth,
                                events: timedEventsByDay[i],
                                colorScheme: colorScheme,
                                onEventTap: (event) => _handleTap(event, ref, context),
                                onEventLongPress: (event) => _handleLongPress(event, ref, context),
                                onEmptyTap: (minutes) => _handleEmptyTap(i, minutes, ref, context),
                              );
                            }),
                          ),
                        ),
                        // Current time indicator
                        _CurrentTimeIndicator(colorScheme: colorScheme),
                      ],
                    );
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _handleTap(WeekEvent event, WidgetRef ref, BuildContext context) {
    switch (event) {
      case TaskEvent e:
        ref.read(weekDataProvider(mondayStr).notifier).toggleTask(e.task, e.task.date!);
      case PlanTaskEvent e:
        ref.read(weekDataProvider(mondayStr).notifier).togglePlanTask(e.planTask.id, e.planTask.planId, e.date);
      case CountdownEvent e:
        context.push('/countdown/detail', extra: e.countdown);
    }
  }

  Future<void> _handleLongPress(WeekEvent event, WidgetRef ref, BuildContext context) async {
    await HapticFeedback.mediumImpact();
    if (!context.mounted) return;
    switch (event) {
      case TaskEvent e:
        final result = await showAppActionSheet(context, [
          const AppAction(value: 'edit', icon: Icons.edit_outlined, label: 'Edit'),
          const AppAction(value: 'delete', icon: Icons.delete_outline, label: 'Delete', isDestructive: true),
        ]);
        if (!context.mounted) return;
        if (result == 'edit') _showEditSheet(context, ref, e.task);
        if (result == 'delete') {
          ref.read(weekDataProvider(mondayStr).notifier).deleteTask(e.task, e.task.date!);
        }
      case PlanTaskEvent _:
        return;
      case CountdownEvent e:
        context.push('/countdown/detail', extra: e.countdown);
    }
  }

  void _showEditSheet(BuildContext context, WidgetRef ref, Task task) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => TaskEditSheet(
        task: task,
        onSave: (name, startTime, endTime, clearStart, clearEnd) {
          final request = UpdateTaskRequest(
            name: name != task.name ? name : null,
            startTime: startTime,
            endTime: endTime,
            clearStartTime: clearStart,
            clearEndTime: clearEnd,
          );
          final optimistic = task.copyWith(name: name, startTime: startTime, endTime: endTime);
          ref.read(weekDataProvider(mondayStr).notifier).updateTask(task, task.date!, request, optimistic);
        },
      ),
    );
  }

  void _handleEmptyTap(int dayIndex, int minutes, WidgetRef ref, BuildContext context) {
    final snapped = (minutes ~/ 15) * 15;
    final startTime = TimeOfDay(hour: snapped ~/ 60, minute: snapped % 60);
    final endMinutes = snapped + 60;
    final endTime = TimeOfDay(hour: (endMinutes ~/ 60) % 24, minute: endMinutes % 60);
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => AddEventSheet(
        initialStartTime: startTime,
        initialEndTime: endTime,
        initialDate: formatDate(days[dayIndex]),
        weekDays: days,
        onSave: (name, start, end, date) =>
            ref.read(weekDataProvider(mondayStr).notifier).addTask(name, date, startTime: start, endTime: end),
      ),
    );
  }
}

class _AllDayRow extends StatelessWidget {
  final List<DateTime> days;
  final List<List<WeekEvent>> allDayEventsByDay;
  final ColorScheme colorScheme;
  final void Function(WeekEvent) onEventTap;
  final void Function(WeekEvent)? onEventLongPress;

  const _AllDayRow({
    required this.days,
    required this.allDayEventsByDay,
    required this.colorScheme,
    required this.onEventTap,
    this.onEventLongPress,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: colorScheme.outlineVariant, width: 0.5)),
      ),
      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: _kTimeGutter,
              child: Padding(
                padding: const EdgeInsets.only(top: 4),
                child: Text(
                  'All day',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 10,
                    color: colorScheme.onSurface.withValues(alpha: 0.5),
                  ),
                ),
              ),
            ),
            ...List.generate(7, (i) {
              final events = allDayEventsByDay[i];
              return Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(4),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: events.map((e) {
                      final isDone = e.isDone;
                      return GestureDetector(
                        onTap: () => onEventTap(e),
                        onLongPress: () => onEventLongPress?.call(e),
                        child: Container(
                          margin: const EdgeInsets.only(bottom: 3),
                          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
                          decoration: BoxDecoration(
                            color: e.color.withValues(alpha: isDone ? 0.12 : 0.2),
                            borderRadius: BorderRadius.circular(4),
                            border: Border(
                              left: BorderSide(color: e.color, width: 3),
                            ),
                          ),
                          child: Text(
                            e.name,
                            style: TextStyle(
                              fontSize: 10,
                              color: e.color,
                              decoration: isDone ? TextDecoration.lineThrough : null,
                            ),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}

class _TimeGrid extends StatelessWidget {
  final ColorScheme colorScheme;

  const _TimeGrid({required this.colorScheme});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: _kTimeGutter,
      child: Stack(
        children: List.generate(24, (hour) {
          return Positioned(
            top: (hour * _kPixelsPerHour - 7).clamp(0.0, double.infinity),
            left: 0,
            right: 4,
            child: Text(
              '${hour.toString().padLeft(2, '0')}:00',
              textAlign: TextAlign.right,
              style: TextStyle(
                fontSize: 9,
                color: colorScheme.onSurface.withValues(alpha: 0.4),
              ),
            ),
          );
        }),
      ),
    );
  }
}

class _DayColumn extends StatelessWidget {
  final double width;
  final List<WeekEvent> events;
  final ColorScheme colorScheme;
  final void Function(WeekEvent) onEventTap;
  final void Function(WeekEvent)? onEventLongPress;
  final void Function(int minutes)? onEmptyTap;

  const _DayColumn({
    required this.width,
    required this.events,
    required this.colorScheme,
    required this.onEventTap,
    this.onEventLongPress,
    this.onEmptyTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onLongPressStart: (details) {
        final minutes = (details.localPosition.dy / _kPixelsPerMinute).round();
        onEmptyTap?.call(minutes);
      },
      child: SizedBox(
        width: width,
        child: Stack(
          children: [
            // Events
            ..._layoutEvents(events, width).map((positioned) {
              final event = positioned.event;
              final top = event.startMinutes * _kPixelsPerMinute;
              final height = (event.durationMinutes * _kPixelsPerMinute).clamp(18.0, double.infinity);
              final isDone = event.isDone;

              return Positioned(
                top: top,
                left: positioned.left + 1,
                width: positioned.width - 2,
                height: height,
                child: GestureDetector(
                  onTap: () => onEventTap(event),
                  onLongPress: () => onEventLongPress?.call(event),
                  child: Container(
                    decoration: BoxDecoration(
                      color: event.color.withValues(alpha: isDone ? 0.12 : 0.2),
                      borderRadius: BorderRadius.circular(4),
                      border: Border(
                        left: BorderSide(color: event.color, width: 3),
                      ),
                    ),
                    padding: const EdgeInsets.only(left: 4, top: 2, right: 2),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (event.startTime != null)
                          Text(
                            event.timeRange,
                            style: TextStyle(
                              fontSize: 8,
                              color: event.color.withValues(alpha: 0.7),
                              decoration: isDone ? TextDecoration.lineThrough : null,
                            ),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          ),
                        Expanded(
                          child: Text(
                            event.name,
                            style: TextStyle(
                              fontSize: 10,
                              color: event.color,
                              decoration: isDone ? TextDecoration.lineThrough : null,
                            ),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 3,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }),
          ],
        ),
      ),
    );
  }

  List<_PositionedEvent> _layoutEvents(List<WeekEvent> events, double columnWidth) {
    if (events.isEmpty) return [];

    // Sort by start time
    final sorted = [...events]..sort((a, b) => a.startMinutes.compareTo(b.startMinutes));

    // Simple overlap detection: group overlapping events into columns
    final result = <_PositionedEvent>[];
    final columns = <List<WeekEvent>>[];

    for (final event in sorted) {
      // Find first column where it doesn't overlap
      int col = -1;
      for (int i = 0; i < columns.length; i++) {
        final last = columns[i].last;
        if (event.startMinutes >= last.startMinutes + last.durationMinutes) {
          col = i;
          break;
        }
      }

      if (col == -1) {
        col = columns.length;
        columns.add([]);
      }
      columns[col].add(event);

      // Count how many columns are "active" at this event's time
      // (simplified: use columns.length at placement time)
      final totalCols = columns.length;
      final w = columnWidth / totalCols;
      result.add(_PositionedEvent(event: event, left: col * w, width: w, colIndex: col));
    }

    // Re-layout with final column count
    final totalCols = columns.length;
    if (totalCols == 1) return result;

    // Reassign widths with final column count
    return result.map((p) {
      final w = columnWidth / totalCols;
      return _PositionedEvent(event: p.event, left: p.colIndex * w, width: w, colIndex: p.colIndex);
    }).toList();
  }
}

class _PositionedEvent {
  final WeekEvent event;
  final double left;
  final double width;
  final int colIndex;

  const _PositionedEvent({
    required this.event,
    required this.left,
    required this.width,
    required this.colIndex,
  });
}

class _CurrentTimeIndicator extends StatefulWidget {
  final ColorScheme colorScheme;

  const _CurrentTimeIndicator({required this.colorScheme});

  @override
  State<_CurrentTimeIndicator> createState() => _CurrentTimeIndicatorState();
}

class _CurrentTimeIndicatorState extends State<_CurrentTimeIndicator> {
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(minutes: 1), (_) => setState(() {}));
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final minutes = now.hour * 60 + now.minute;
    final top = minutes * _kPixelsPerMinute;

    return Positioned(
      top: top,
      left: _kTimeGutter - 4,
      right: 0,
      child: Row(
        children: [
          Container(
            width: 8,
            height: 8,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: widget.colorScheme.primary,
            ),
          ),
          Expanded(
            child: Container(height: 1.5, color: widget.colorScheme.primary),
          ),
        ],
      ),
    );
  }
}
