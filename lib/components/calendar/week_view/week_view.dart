import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:marquer/api/models/calendar/week_data.dart';
import 'package:marquer/api/models/tasks/tasks/task.dart';
import 'package:marquer/api/models/tasks/tasks/update_task_request.dart';
import 'package:marquer/components/calendar/add_event_sheet.dart';
import 'package:marquer/components/calendar/week_view/all_day_row.dart';
import 'package:marquer/components/calendar/week_view/current_time_indicator.dart';
import 'package:marquer/components/calendar/week_view/day_column.dart';
import 'package:marquer/components/calendar/week_view/day_headers.dart';
import 'package:marquer/components/calendar/week_view/task_detail_sheet.dart';
import 'package:marquer/components/calendar/week_view/time_grid.dart';
import 'package:marquer/components/calendar/week_view/week_event.dart';
import 'package:marquer/components/calendar/week_view/week_view_constants.dart';
import 'package:marquer/components/shared/task_edit_sheet.dart';
import 'package:marquer/providers/calendar/calendar_selected_date_provider.dart';
import 'package:marquer/providers/calendar/calendar_settings_provider.dart';
import 'package:marquer/providers/calendar/week_data_provider.dart';
import 'package:marquer/utils/action_sheet.dart';
import 'package:marquer/utils/format.dart';

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
      ((DateTime.now().hour * kPixelsPerHour) - 80).clamp(0.0, double.infinity);

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
    // Stale-while-revalidate: show cached data immediately, refresh in background
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final mondayStr = formatDate(widget.monday);
      ref.read(weekDataProvider(mondayStr).notifier).silentRefresh();
    });
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
        DayHeaders(days: days, selected: selected, today: todayStr, colorScheme: colorScheme),
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
      events.add(TaskEvent(task, colors.primary));
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
            AllDayRow(
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
                height: 24 * kPixelsPerHour,
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    final columnWidth = (constraints.maxWidth - kTimeGutter) / kDayCount;
                    return Stack(
                      children: [
                        // Time gutter labels
                        Positioned(
                          left: 0,
                          top: 0,
                          bottom: 0,
                          child: SizedBox(
                            width: kTimeGutter,
                            child: TimeGrid(colorScheme: colorScheme, hourInterval: hourInterval),
                          ),
                        ),
                        // Full-width hour lines
                        ...List.generate(24 ~/ hourInterval, (i) {
                          final hour = i * hourInterval;
                          return Positioned(
                            top: hour * kPixelsPerHour,
                            left: kTimeGutter,
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
                            left: kTimeGutter + columnWidth * (i + 1),
                            child: Container(
                              width: 1,
                              color: colorScheme.outlineVariant,
                            ),
                          );
                        }),
                        // Event columns
                        Positioned(
                          left: kTimeGutter,
                          top: 0,
                          right: 0,
                          bottom: 0,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: List.generate(7, (i) {
                              return Expanded(
                                child: DayColumn(
                                  events: timedEventsByDay[i],
                                  colorScheme: colorScheme,
                                  onEventTap: (event) => _handleTap(event, ref, context),
                                  onEventLongPress: (event) => _handleLongPress(event, ref, context),
                                  onEmptyTap: (minutes) => _handleEmptyTap(i, minutes, ref, context),
                                ),
                              );
                            }),
                          ),
                        ),
                        // Current time indicator
                        CurrentTimeIndicator(colorScheme: colorScheme),
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
      builder: (ctx) => TaskDetailSheet(
        task: task,
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
        onSave: (name, startTime, endTime, clearStart, clearEnd, color) {
          final request = UpdateTaskRequest(
            name: name != task.name ? name : null,
            startTime: startTime,
            endTime: endTime,
            clearStartTime: clearStart,
            clearEndTime: clearEnd,
            color: color,
            clearColor: color == null && task.color != null,
          );
          final optimistic = task.copyWith(name: name, startTime: startTime, endTime: endTime, color: color);
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
        onSave: (name, start, end, date, color) =>
            ref.read(weekDataProvider(mondayStr).notifier).addTask(name, date, startTime: start, endTime: end, color: color),
      ),
    );
  }
}
