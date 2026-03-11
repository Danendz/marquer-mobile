import 'package:marquer/api/models/calendar/countdown.dart';
import 'package:marquer/api/models/tasks/tasks/task.dart';

class WeekPlanTask {
  final int id;
  final String name;
  final int sortOrder;
  final String? startTime;
  final String? endTime;
  final bool isCompleted;
  final int planId;
  final String planName;
  final String? planColor;

  const WeekPlanTask({
    required this.id,
    required this.name,
    required this.sortOrder,
    this.startTime,
    this.endTime,
    required this.isCompleted,
    required this.planId,
    required this.planName,
    this.planColor,
  });

  factory WeekPlanTask.fromJson(Map<String, dynamic> json) => WeekPlanTask(
    id: json['id'] as int,
    name: json['name'] as String,
    sortOrder: json['sort_order'] as int,
    startTime: json['start_time'] as String?,
    endTime: json['end_time'] as String?,
    isCompleted: json['is_completed'] as bool,
    planId: json['plan_id'] as int,
    planName: json['plan_name'] as String,
    planColor: json['plan_color'] as String?,
  );

  WeekPlanTask copyWith({bool? isCompleted, String? planName}) => WeekPlanTask(
    id: id,
    name: name,
    sortOrder: sortOrder,
    startTime: startTime,
    endTime: endTime,
    isCompleted: isCompleted ?? this.isCompleted,
    planId: planId,
    planName: planName ?? this.planName,
    planColor: planColor,
  );
}

class WeekData {
  final Map<String, List<Task>> tasks;
  final Map<String, List<WeekPlanTask>> planTasks;
  final Map<String, List<Countdown>> countdowns;

  const WeekData({
    required this.tasks,
    required this.planTasks,
    required this.countdowns,
  });

  WeekData copyWith({
    Map<String, List<Task>>? tasks,
    Map<String, List<WeekPlanTask>>? planTasks,
    Map<String, List<Countdown>>? countdowns,
  }) => WeekData(
    tasks: tasks ?? this.tasks,
    planTasks: planTasks ?? this.planTasks,
    countdowns: countdowns ?? this.countdowns,
  );

  factory WeekData.fromJson(Map<String, dynamic> json) {
    final tasksRaw = json['tasks'];
    final tasksJson = tasksRaw is Map<String, dynamic> ? tasksRaw : <String, dynamic>{};
    final planTasksRaw = json['plan_tasks'];
    final planTasksJson = planTasksRaw is Map<String, dynamic> ? planTasksRaw : <String, dynamic>{};
    final countdownsRaw = json['countdowns'];
    final countdownsJson = countdownsRaw is Map<String, dynamic> ? countdownsRaw : <String, dynamic>{};

    return WeekData(
      tasks: tasksJson.map(
        (date, list) => MapEntry(
          date,
          (list as List).map((t) => Task.fromJson(t as Map<String, dynamic>)).toList(),
        ),
      ),
      planTasks: planTasksJson.map(
        (date, list) => MapEntry(
          date,
          (list as List).map((t) => WeekPlanTask.fromJson(t as Map<String, dynamic>)).toList(),
        ),
      ),
      countdowns: countdownsJson.map(
        (date, list) => MapEntry(
          date,
          (list as List).map((c) => Countdown.fromJson(c as Map<String, dynamic>)).toList(),
        ),
      ),
    );
  }
}
