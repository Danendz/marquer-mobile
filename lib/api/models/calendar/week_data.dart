import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:marquer/api/models/calendar/countdown.dart';
import 'package:marquer/api/models/tasks/tasks/task.dart';

part 'week_data.freezed.dart';
part 'week_data.g.dart';

@freezed
abstract class WeekPlanTask with _$WeekPlanTask {
  const factory WeekPlanTask({
    required int id,
    required String name,
    @JsonKey(name: 'sort_order') required int sortOrder,
    @JsonKey(name: 'start_time') String? startTime,
    @JsonKey(name: 'end_time') String? endTime,
    @JsonKey(name: 'is_completed') required bool isCompleted,
    @JsonKey(name: 'plan_id') required int planId,
    @JsonKey(name: 'plan_name') required String planName,
    @JsonKey(name: 'plan_color') String? planColor,
  }) = _WeekPlanTask;

  factory WeekPlanTask.fromJson(Map<String, dynamic> json) =>
      _$WeekPlanTaskFromJson(json);
}

/// WeekData has complex nested Map structure that doesn't map cleanly to
/// json_serializable, so we keep manual fromJson/copyWith via Freezed.
@freezed
abstract class WeekData with _$WeekData {
  const factory WeekData({
    required Map<String, List<Task>> tasks,
    @JsonKey(name: 'plan_tasks') required Map<String, List<WeekPlanTask>> planTasks,
    required Map<String, List<Countdown>> countdowns,
  }) = _WeekData;

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
