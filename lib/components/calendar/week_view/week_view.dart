import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:marquer/api/models/calendar/week_data.dart';
import 'package:marquer/api/models/tasks/tasks/task.dart';
import 'package:marquer/api/models/tasks/tasks/task_status.dart';
import 'package:marquer/api/models/tasks/tasks/update_task_request.dart';
import 'package:marquer/components/calendar/add_event_sheet.dart';
import 'package:marquer/components/calendar/calendar_settings_sheet.dart';
import 'package:marquer/components/calendar/week_view/week_event.dart';
import 'package:marquer/components/shared/task_edit_sheet.dart';
import 'package:marquer/providers/calendar/calendar_selected_date_provider.dart';
import 'package:marquer/providers/calendar/calendar_settings_provider.dart';
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
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: colorScheme.outlineVariant, width: 0.5)),
      ),
      child: Row(
        children: [
          SizedBox(
            width: _kTimeGutter,
            child: Center(
              child: IconButton(
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
                icon: Icon(Icons.settings_outlined, size: 22, color: colorScheme.onSurface.withValues(alpha: 0.4)),
                onPressed: () => showModalBottomSheet(
                  context: context,
                  backgroundColor: Theme.of(context).colorScheme.surface,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                  ),
                  builder: (_) => const CalendarSettingsSheet(),
                ),
              ),
            ),
          ),
          ...List.generate(7, (i) {
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
        ],
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
    for (final cd in data.countdowns[dateStr] ?? []) {
      events.add(CountdownEvent(cd, colors.primary));
    }

    // Sort: all-day first, then by startMinutes ascending
    events.sort((a, b) {
      if (a.isAllDay && b.isAllDay) return 0;
      if (a.isAllDay) return -1;
      if (b.isAllDay) return 1;
      return a.startMinutes.compareTo(b.startMinutes);
    });

    return events;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final hourInterval = ref.watch(calendarHourIntervalProvider);
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
                            child: _TimeGrid(colorScheme: colorScheme, hourInterval: hourInterval),
                          ),
                        ),
                        // Full-width hour lines
                        ...List.generate(24 ~/ hourInterval, (i) {
                          final hour = i * hourInterval;
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
        _showTaskDetailSheet(context, ref, e.task);
      case PlanTaskEvent _:
        return;
      case CountdownEvent e:
        context.push('/countdown/detail', extra: e.countdown);
    }
  }

  void _showTaskDetailSheet(BuildContext context, WidgetRef ref, Task task) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (ctx) => _TaskDetailSheet(
        task: task,
        mondayStr: mondayStr,
        onEdit: () => _showEditSheet(context, ref, task),
        onDelete: () => ref.read(weekDataProvider(mondayStr).notifier).deleteTask(task, task.date!),
        onToggle: () => ref.read(weekDataProvider(mondayStr).notifier).toggleTask(task, task.date!),
      ),
    );
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

class _TaskDetailSheet extends ConsumerWidget {
  final Task task;
  final String mondayStr;
  final VoidCallback onEdit;
  final VoidCallback onDelete;
  final VoidCallback onToggle;

  const _TaskDetailSheet({
    required this.task,
    required this.mondayStr,
    required this.onEdit,
    required this.onDelete,
    required this.onToggle,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorScheme = Theme.of(context).colorScheme;
    final isDone = task.status == TaskStatus.done;

    String? timeRange;
    if (task.startTime != null && task.endTime != null) {
      timeRange = '${task.startTime} – ${task.endTime}';
    }

    return Container(
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
      ),
      padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 8),
          Center(
            child: Container(
              width: 36,
              height: 4,
              decoration: BoxDecoration(
                color: colorScheme.onSurface.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    task.name,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                    onToggle();
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                    decoration: BoxDecoration(
                      color: isDone
                          ? colorScheme.primaryContainer
                          : colorScheme.surfaceContainerHighest,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          isDone ? Icons.check_circle : Icons.radio_button_unchecked,
                          size: 16,
                          color: isDone ? colorScheme.primary : colorScheme.onSurfaceVariant,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          isDone ? 'Done' : 'Not done',
                          style: TextStyle(
                            fontSize: 13,
                            color: isDone ? colorScheme.primary : colorScheme.onSurfaceVariant,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          if (timeRange != null) ...[
            const SizedBox(height: 12),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  Icon(Icons.access_time, size: 14, color: colorScheme.onSurfaceVariant),
                  const SizedBox(width: 6),
                  Text(
                    timeRange,
                    style: TextStyle(fontSize: 13, color: colorScheme.onSurfaceVariant),
                  ),
                ],
              ),
            ),
          ],
          const SizedBox(height: 16),
          const Divider(height: 1),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () {
                      Navigator.pop(context);
                      onEdit();
                    },
                    icon: const Icon(Icons.edit_outlined, size: 16),
                    label: const Text('Edit'),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () {
                      Navigator.pop(context);
                      onDelete();
                    },
                    icon: Icon(Icons.delete_outline, size: 16, color: colorScheme.error),
                    label: Text('Delete', style: TextStyle(color: colorScheme.error)),
                    style: OutlinedButton.styleFrom(
                      side: BorderSide(color: colorScheme.error),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
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
  final int hourInterval;

  const _TimeGrid({required this.colorScheme, this.hourInterval = 1});

  @override
  Widget build(BuildContext context) {
    final count = 24 ~/ hourInterval;
    return SizedBox(
      width: _kTimeGutter,
      child: Stack(
        children: List.generate(count, (i) {
          final hour = i * hourInterval;
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
    final positioned = _layoutEvents(events, width);

    // Group PlanTaskEvents by planId for background rendering
    final planGroups = <int, List<PlanTaskEvent>>{};
    for (final event in events) {
      if (event is PlanTaskEvent) {
        planGroups.putIfAbsent(event.planId, () => []).add(event);
      }
    }

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
            // Plan group backgrounds (rendered before events)
            ...planGroups.entries.map((entry) {
              final planEvents = entry.value;
              final minStart = planEvents.map((e) => e.startMinutes).reduce((a, b) => a < b ? a : b);
              final maxEnd = planEvents
                  .map((e) => e.startMinutes + e.durationMinutes)
                  .reduce((a, b) => a > b ? a : b);
              final top = (minStart * _kPixelsPerMinute) - 12;
              final bgHeight = (((maxEnd - minStart) * _kPixelsPerMinute) + 12).clamp(18.0, double.infinity);
              final planName = planEvents.first.planName;
              return Positioned(
                top: top,
                left: 1.5,
                width: width - 3,
                height: bgHeight,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.amber.withValues(alpha: 0.08),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  padding: const EdgeInsets.only(left: 3, top: 1),
                  child: Text(
                    planName,
                    style: TextStyle(fontSize: 8, color: Colors.amber.shade700),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                ),
              );
            }),
            // Events
            ...positioned.map((p) {
              final event = p.event;
              final top = event.startMinutes * _kPixelsPerMinute;
              final height = (event.durationMinutes * _kPixelsPerMinute).clamp(18.0, double.infinity);
              final isDone = event.isDone;

              return Positioned(
                top: top,
                left: p.left + 1.5,
                width: p.width - 3,
                height: height,
                child: GestureDetector(
                  onTap: () => onEventTap(event),
                  onLongPress: () => onEventLongPress?.call(event),
                  child: Stack(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: event.color.withValues(alpha: isDone ? 0.12 : 0.2),
                          borderRadius: BorderRadius.circular(4),
                          border: Border(
                            left: BorderSide(color: event.color, width: 2),
                          ),
                        ),
                        padding: const EdgeInsets.only(left: 4, top: 2, right: 2),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            if (event.startTime != null)
                              Text(
                                event.shortTimeRange,
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
                      // Subtle bottom separator
                      Positioned(
                        left: 0,
                        right: 0,
                        bottom: 0,
                        child: Container(height: 0.5, color: colorScheme.outlineVariant),
                      ),
                      // "+N" overflow badge
                      if (p.overflowCount > 0)
                        Positioned(
                          top: 2,
                          right: 2,
                          child: GestureDetector(
                            onTap: () => _showOverflowSheet(context, p.overflowEvents),
                            child: Container(
                              padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                              decoration: BoxDecoration(
                                color: event.color.withValues(alpha: 0.85),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Text(
                                '+${p.overflowCount}',
                                style: const TextStyle(
                                  fontSize: 8,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              );
            }),
          ],
        ),
      ),
    );
  }

  void _showOverflowSheet(BuildContext context, List<WeekEvent> overflowEvents) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Theme.of(context).colorScheme.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (ctx) {
        final cs = Theme.of(ctx).colorScheme;
        return Padding(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 32),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 36,
                  height: 4,
                  decoration: BoxDecoration(
                    color: cs.outlineVariant,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Text(
                'More events',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: cs.onSurface),
              ),
              const SizedBox(height: 8),
              ...overflowEvents.map((e) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: Row(
                  children: [
                    Container(
                      width: 3,
                      height: 32,
                      decoration: BoxDecoration(
                        color: e.color,
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(e.name, style: TextStyle(fontSize: 13, color: cs.onSurface)),
                          if (e.timeRange.isNotEmpty)
                            Text(
                              e.timeRange,
                              style: TextStyle(fontSize: 11, color: cs.onSurface.withValues(alpha: 0.6)),
                            ),
                        ],
                      ),
                    ),
                  ],
                ),
              )),
            ],
          ),
        );
      },
    );
  }

  List<_PositionedEvent> _layoutEvents(List<WeekEvent> events, double columnWidth) {
    if (events.isEmpty) return [];

    final sorted = [...events]..sort((a, b) => a.startMinutes.compareTo(b.startMinutes));
    final clusters = _buildClusters(sorted);
    final result = <_PositionedEvent>[];

    for (final cluster in clusters) {
      if (cluster.length >= 3) {
        // 3+ overlapping: first event full-width, rest hidden behind "+N" badge
        final first = cluster.first;
        result.add(_PositionedEvent(
          event: first,
          left: 0,
          width: columnWidth,
          colIndex: 0,
          overflowCount: cluster.length - 1,
          overflowEvents: cluster.skip(1).toList(),
        ));
      } else {
        // 1 or 2 events: side-by-side columns within cluster
        final subCols = <List<WeekEvent>>[];
        for (final event in cluster) {
          int col = -1;
          for (int i = 0; i < subCols.length; i++) {
            final last = subCols[i].last;
            if (event.startMinutes >= last.startMinutes + last.durationMinutes) {
              col = i;
              break;
            }
          }
          if (col == -1) {
            col = subCols.length;
            subCols.add([]);
          }
          subCols[col].add(event);
        }
        final totalCols = subCols.length;
        final w = columnWidth / totalCols;
        for (int c = 0; c < subCols.length; c++) {
          for (final event in subCols[c]) {
            result.add(_PositionedEvent(event: event, left: c * w, width: w, colIndex: c));
          }
        }
      }
    }

    return result;
  }

  /// Groups events into overlap clusters (transitive closure of pairwise overlap).
  List<List<WeekEvent>> _buildClusters(List<WeekEvent> sorted) {
    final clusters = <List<WeekEvent>>[];
    for (final event in sorted) {
      bool added = false;
      for (final cluster in clusters) {
        final overlaps = cluster.any((e) =>
          event.startMinutes < e.startMinutes + e.durationMinutes &&
          e.startMinutes < event.startMinutes + event.durationMinutes);
        if (overlaps) {
          cluster.add(event);
          added = true;
          break;
        }
      }
      if (!added) clusters.add([event]);
    }
    return clusters;
  }
}

class _PositionedEvent {
  final WeekEvent event;
  final double left;
  final double width;
  final int colIndex;
  final int overflowCount;
  final List<WeekEvent> overflowEvents;

  const _PositionedEvent({
    required this.event,
    required this.left,
    required this.width,
    required this.colIndex,
    this.overflowCount = 0,
    this.overflowEvents = const [],
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
