import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:marquer/api/models/calendar/plan.dart';
import 'package:marquer/api/models/calendar/plan_schedule.dart';
import 'package:marquer/screens/calendar/widgets/plan_event_list.dart';
import 'package:marquer/screens/calendar/widgets/schedule_config.dart';

final planFormProvider =
    NotifierProvider<PlanFormNotifier, PlanFormState>(PlanFormNotifier.new);

class PlanFormState {
  final String name;
  final ScheduleType scheduleType;
  final List<int> weeklyDays;
  final int intervalEvery;
  final List<int> monthlyDates;
  final int monthlyWeekdayOccurrence;
  final int monthlyWeekdayDay;
  final DateTime startDate;
  final DateTime? endDate;
  final bool hasEndDate;
  final List<PlanTaskItem> tasks;
  final String? color;

  PlanFormState({
    this.name = '',
    this.scheduleType = ScheduleType.daily,
    this.weeklyDays = const [0],
    this.intervalEvery = 1,
    this.monthlyDates = const [1],
    this.monthlyWeekdayOccurrence = 1,
    this.monthlyWeekdayDay = 0,
    DateTime? startDate,
    this.endDate,
    this.hasEndDate = false,
    this.tasks = const [],
    this.color,
  }) : startDate = startDate ?? DateTime.now();

  PlanFormState copyWith({
    String? name,
    ScheduleType? scheduleType,
    List<int>? weeklyDays,
    int? intervalEvery,
    List<int>? monthlyDates,
    int? monthlyWeekdayOccurrence,
    int? monthlyWeekdayDay,
    DateTime? startDate,
    DateTime? endDate,
    bool? hasEndDate,
    List<PlanTaskItem>? tasks,
    String? color,
  }) =>
      PlanFormState(
        name: name ?? this.name,
        scheduleType: scheduleType ?? this.scheduleType,
        weeklyDays: weeklyDays ?? this.weeklyDays,
        intervalEvery: intervalEvery ?? this.intervalEvery,
        monthlyDates: monthlyDates ?? this.monthlyDates,
        monthlyWeekdayOccurrence:
            monthlyWeekdayOccurrence ?? this.monthlyWeekdayOccurrence,
        monthlyWeekdayDay: monthlyWeekdayDay ?? this.monthlyWeekdayDay,
        startDate: startDate ?? this.startDate,
        endDate: endDate ?? this.endDate,
        hasEndDate: hasEndDate ?? this.hasEndDate,
        tasks: tasks ?? this.tasks,
        color: color ?? this.color,
      );

  /// Builds the [PlanSchedule] from current form state.
  PlanSchedule buildSchedule() {
    return switch (scheduleType) {
      ScheduleType.daily => const DailySchedule(),
      ScheduleType.weekly => WeeklySchedule(days: List.from(weeklyDays)),
      ScheduleType.interval => IntervalSchedule(every: intervalEvery),
      ScheduleType.monthlyDates =>
        MonthlyDatesSchedule(days: List.from(monthlyDates)),
      ScheduleType.monthlyWeekday => MonthlyWeekdaySchedule(
          week: monthlyWeekdayOccurrence,
          weekday: monthlyWeekdayDay,
        ),
    };
  }

  /// Returns valid tasks (non-empty name), sorted by time.
  List<PlanTaskItem> get validTasks {
    final items = tasks.where((t) => t.name.trim().isNotEmpty).toList();
    items.sort((a, b) {
      if (a.startTime == null && b.startTime == null) return 0;
      if (a.startTime == null) return -1;
      if (b.startTime == null) return 1;
      return a.startTime!.compareTo(b.startTime!);
    });
    return items;
  }

  /// Validates the form. Returns null if valid, error message otherwise.
  String? validate() {
    if (name.trim().isEmpty) return 'Plan name is required';
    if (validTasks.isEmpty) return 'At least one event is required';
    return null;
  }
}

class PlanFormNotifier extends Notifier<PlanFormState> {
  @override
  PlanFormState build() => PlanFormState();

  /// Initializes form state from an existing plan for editing.
  void loadFromPlan(Plan plan) {
    final tasks = plan.tasks
        .map((t) => PlanTaskItem(
              id: t.id,
              name: t.name,
              sortOrder: t.sortOrder,
              startTime: t.startTime,
              endTime: t.endTime,
            ))
        .toList();

    final (scheduleType, weeklyDays, intervalEvery, monthlyDates,
        monthlyWeekdayOccurrence, monthlyWeekdayDay) =
        _parseSchedule(plan.schedule);

    state = PlanFormState(
      name: plan.name,
      scheduleType: scheduleType,
      weeklyDays: weeklyDays,
      intervalEvery: intervalEvery,
      monthlyDates: monthlyDates,
      monthlyWeekdayOccurrence: monthlyWeekdayOccurrence,
      monthlyWeekdayDay: monthlyWeekdayDay,
      startDate: DateTime.parse(plan.startDate),
      endDate: plan.endDate != null ? DateTime.parse(plan.endDate!) : null,
      hasEndDate: plan.endDate != null,
      tasks: tasks,
      color: plan.color,
    );
  }

  void setName(String name) => state = state.copyWith(name: name);

  void setScheduleType(ScheduleType type) =>
      state = state.copyWith(scheduleType: type);

  void setWeeklyDays(List<int> days) =>
      state = state.copyWith(weeklyDays: days);

  void setIntervalEvery(int every) =>
      state = state.copyWith(intervalEvery: every);

  void setMonthlyDates(List<int> dates) =>
      state = state.copyWith(monthlyDates: dates);

  void setMonthlyWeekdayOccurrence(int occurrence) =>
      state = state.copyWith(monthlyWeekdayOccurrence: occurrence);

  void setMonthlyWeekdayDay(int day) =>
      state = state.copyWith(monthlyWeekdayDay: day);

  void setStartDate(DateTime date) {
    final clearEnd = state.endDate != null && state.endDate!.isBefore(date);
    state = PlanFormState(
      name: state.name,
      scheduleType: state.scheduleType,
      weeklyDays: state.weeklyDays,
      intervalEvery: state.intervalEvery,
      monthlyDates: state.monthlyDates,
      monthlyWeekdayOccurrence: state.monthlyWeekdayOccurrence,
      monthlyWeekdayDay: state.monthlyWeekdayDay,
      startDate: date,
      endDate: clearEnd ? null : state.endDate,
      hasEndDate: clearEnd ? false : state.hasEndDate,
      tasks: state.tasks,
      color: state.color,
    );
  }

  void setEndDate(DateTime date) => state = state.copyWith(endDate: date);

  void setHasEndDate(bool value) {
    state = PlanFormState(
      name: state.name,
      scheduleType: state.scheduleType,
      weeklyDays: state.weeklyDays,
      intervalEvery: state.intervalEvery,
      monthlyDates: state.monthlyDates,
      monthlyWeekdayOccurrence: state.monthlyWeekdayOccurrence,
      monthlyWeekdayDay: state.monthlyWeekdayDay,
      startDate: state.startDate,
      endDate: value ? state.endDate : null,
      hasEndDate: value,
      tasks: state.tasks,
      color: state.color,
    );
  }

  void setColor(String? color) => state = state.copyWith(color: color);

  void addTask(PlanTaskItem task) =>
      state = state.copyWith(tasks: [...state.tasks, task]);

  void updateTask(int index, PlanTaskItem task) {
    final tasks = List<PlanTaskItem>.from(state.tasks);
    tasks[index] = task;
    state = state.copyWith(tasks: tasks);
  }

  void removeTask(int index) {
    final tasks = List<PlanTaskItem>.from(state.tasks);
    tasks.removeAt(index);
    state = state.copyWith(tasks: tasks);
  }

  static (
    ScheduleType,
    List<int>,
    int,
    List<int>,
    int,
    int,
  ) _parseSchedule(PlanSchedule schedule) {
    return switch (schedule) {
      DailySchedule() => (ScheduleType.daily, [0], 1, [1], 1, 0),
      WeeklySchedule(:final days) => (
          ScheduleType.weekly,
          List<int>.from(days),
          1,
          [1],
          1,
          0
        ),
      IntervalSchedule(:final every) => (
          ScheduleType.interval,
          [0],
          every,
          [1],
          1,
          0
        ),
      MonthlyDatesSchedule(:final days) => (
          ScheduleType.monthlyDates,
          [0],
          1,
          List<int>.from(days),
          1,
          0
        ),
      MonthlyWeekdaySchedule(:final week, :final weekday) => (
          ScheduleType.monthlyWeekday,
          [0],
          1,
          [1],
          week,
          weekday
        ),
    };
  }
}
