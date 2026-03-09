import 'package:flutter/material.dart';
import 'package:marquer/api/models/calendar/countdown.dart';
import 'package:marquer/api/models/calendar/week_data.dart';
import 'package:marquer/api/models/tasks/tasks/task.dart';
import 'package:marquer/api/models/tasks/tasks/task_status.dart';

sealed class WeekEvent {
  String get name;
  String? get startTime;
  String? get endTime;
  bool get isAllDay => startTime == null || endTime == null;
  bool get isDone => false;
  Color get color;

  int get startMinutes {
    if (startTime == null) return 0;
    final parts = startTime!.split(':');
    return int.parse(parts[0]) * 60 + int.parse(parts[1]);
  }

  int get endMinutes {
    if (endTime == null) return startMinutes + 60;
    final parts = endTime!.split(':');
    return int.parse(parts[0]) * 60 + int.parse(parts[1]);
  }

  int get durationMinutes => (endMinutes - startMinutes).clamp(15, 24 * 60);

  String get timeRange {
    if (startTime == null) return '';
    if (endTime == null) return startTime!;
    return '${startTime!}–${endTime!}';
  }
}

final class TaskEvent extends WeekEvent {
  final Task task;
  TaskEvent(this.task);

  @override
  String get name => task.name;
  @override
  String? get startTime => task.startTime;
  @override
  String? get endTime => task.endTime;
  @override
  Color get color => Colors.teal;

  @override
  bool get isDone => task.status == TaskStatus.done;
}

final class PlanTaskEvent extends WeekEvent {
  final WeekPlanTask planTask;
  final String date;
  PlanTaskEvent(this.planTask, this.date);

  @override
  String get name => planTask.name;
  @override
  String? get startTime => planTask.startTime;
  @override
  String? get endTime => planTask.endTime;
  @override
  Color get color => Colors.amber;

  @override
  bool get isDone => planTask.isCompleted;
}

final class CountdownEvent extends WeekEvent {
  final Countdown countdown;
  final Color _color;
  CountdownEvent(this.countdown, this._color);

  @override
  String get name => countdown.name;
  @override
  String? get startTime => null;
  @override
  String? get endTime => null;
  @override
  Color get color => _color;
}
