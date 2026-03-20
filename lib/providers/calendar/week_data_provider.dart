import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:marquer/api/models/calendar/week_data.dart';
import 'package:marquer/api/models/tasks/tasks/create_task_request.dart';
import 'package:marquer/api/models/tasks/tasks/task.dart';
import 'package:marquer/api/models/tasks/tasks/task_status.dart';
import 'package:marquer/api/models/tasks/tasks/update_task_request.dart';
import 'package:marquer/api/services/calendar_service.dart';
import 'package:marquer/api/services/tasks_service.dart';
import 'package:marquer/providers/optimistic_mutation.dart';
import 'package:marquer/utils/format.dart';
import 'package:marquer/services/toast_service.dart';

final weekDataProvider =
    AsyncNotifierProvider.family<WeekDataNotifier, WeekData, String>(
  WeekDataNotifier.new,
);

class WeekDataNotifier extends AsyncNotifier<WeekData>
    with OptimisticMutation {
  WeekDataNotifier(this.mondayStr);
  final String mondayStr;

  final _service = CalendarService();
  final _tasksService = TasksService();

  int _pendingMutations = 0;
  bool get hasPendingMutations => _pendingMutations > 0;

  @override
  Future<WeekData> build() async {
    final link = ref.keepAlive();
    final timer = Timer(const Duration(minutes: 5), link.close);
    ref.onDispose(timer.cancel);

    final monday = DateTime.parse(mondayStr);
    final sunday = monday.add(const Duration(days: 6));
    return _service.getWeekData(mondayStr, formatDate(sunday));
  }

  Future<void> togglePlanTask(int planTaskId, int planId, String date) async {
    final current = currentValue;
    if (current == null) return;

    _pendingMutations++;
    state = AsyncData(_toggleInData(current, planTaskId, planId, date, null));

    try {
      final isCompleted = await _service.togglePlanTaskCompletion(planTaskId.toString(), date);
      if (!ref.mounted) return;
      state = AsyncData(_toggleInData(state.asData!.value, planTaskId, planId, date, isCompleted));
    } catch (e) {
      if (!ref.mounted) return;
      state = AsyncData(_toggleInData(state.asData?.value ?? current, planTaskId, planId, date, null));
      debugPrint(e.toString());
      ToastService.showError('Unable to update plan task! Try again later');
    } finally {
      _pendingMutations--;
    }
  }

  Future<void> toggleTask(Task task, String date) async {
    final current = currentValue;
    if (current == null) return;

    _pendingMutations++;
    final newStatus = task.status == TaskStatus.done ? TaskStatus.draft : TaskStatus.done;
    state = AsyncData(_updateTaskInData(current, date, task.id, task.copyWith(status: newStatus)));

    await mutate(
      action: () => _tasksService.updateTask(
        task.id.toString(),
        UpdateTaskRequest(status: newStatus),
      ),
      errorMessage: 'Unable to update event! Try again later',
      rollback: () => _updateTaskInData(state.asData?.value ?? current, date, task.id, task),
      onSuccess: (latest, updated) => _updateTaskInData(latest, date, task.id, updated),
    );
    _pendingMutations--;
  }

  Future<void> deleteTask(Task task, String date) async {
    final current = currentValue;
    if (current == null) return;

    _pendingMutations++;
    state = AsyncData(_updateTaskInData(current, date, task.id, null));

    await mutate(
      action: () => _tasksService.deleteTask(task.id.toString()),
      errorMessage: 'Unable to delete event! Try again later',
      rollback: () {
        final latest = state.asData?.value ?? current;
        final updatedTasks = Map<String, List<Task>>.from(latest.tasks);
        final list = List<Task>.from(updatedTasks[date] ?? []);
        if (!list.any((t) => t.id == task.id)) list.insert(0, task);
        updatedTasks[date] = list;
        return latest.copyWith(tasks: updatedTasks);
      },
    );
    _pendingMutations--;
  }

  Future<void> updateTask(Task task, String date, UpdateTaskRequest request, Task optimistic) async {
    final current = currentValue;
    if (current == null) return;

    _pendingMutations++;
    state = AsyncData(_updateTaskInData(current, date, task.id, optimistic));

    await mutate(
      action: () => _tasksService.updateTask(task.id.toString(), request),
      errorMessage: 'Unable to update event! Try again later',
      rollback: () => _updateTaskInData(state.asData?.value ?? current, date, task.id, task),
      onSuccess: (latest, updated) => _updateTaskInData(latest, date, task.id, updated),
    );
    _pendingMutations--;
  }

  Future<void> addTask(String name, String date, {String? startTime, String? endTime, String? color}) async {
    final current = currentValue;
    if (current == null) return;

    _pendingMutations++;
    final placeholder = Task(
      id: -DateTime.now().millisecondsSinceEpoch,
      name: name,
      status: TaskStatus.draft,
      date: date,
      startTime: startTime,
      endTime: endTime,
      color: color,
      createdAt: DateTime.now().toIso8601String(),
      updatedAt: DateTime.now().toIso8601String(),
    );

    final updatedTasks = Map<String, List<Task>>.from(current.tasks);
    updatedTasks[date] = [placeholder, ...(updatedTasks[date] ?? [])];
    state = AsyncData(current.copyWith(tasks: updatedTasks));

    await mutate(
      action: () => _tasksService.createTask(
        CreateTaskRequest(name: name, date: date, startTime: startTime, endTime: endTime, color: color),
      ),
      errorMessage: 'Unable to add event! Try again later',
      rollback: () => _updateTaskInData(state.asData?.value ?? current, date, placeholder.id, null),
      onSuccess: (latest, created) => _updateTaskInData(latest, date, placeholder.id, created),
    );
    _pendingMutations--;
  }

  /// Refetch from server without showing loading state (stale-while-revalidate).
  /// No-ops while optimistic mutations are in flight to avoid overwriting local state.
  Future<void> safeRefresh() async {
    if (hasPendingMutations) return;
    return silentRefresh();
  }

  /// Refetch from server without showing loading state (stale-while-revalidate).
  Future<void> silentRefresh() async {
    if (state.asData == null) return;
    try {
      final monday = DateTime.parse(mondayStr);
      final sunday = monday.add(const Duration(days: 6));
      final fresh = await _service.getWeekData(mondayStr, formatDate(sunday));
      if (!ref.mounted) return;
      state = AsyncData(fresh);
    } catch (_) {
      // Keep stale data on error
    }
  }

  WeekData _updateTaskInData(WeekData data, String date, int taskId, Task? replacement) {
    final updatedTasks = Map<String, List<Task>>.from(data.tasks);
    final list = List<Task>.from(updatedTasks[date] ?? []);
    final idx = list.indexWhere((t) => t.id == taskId);
    if (replacement == null) {
      if (idx != -1) list.removeAt(idx);
    } else if (idx != -1) {
      list[idx] = replacement;
    } else {
      list.insert(0, replacement);
    }
    updatedTasks[date] = list;
    return data.copyWith(tasks: updatedTasks);
  }

  WeekData _toggleInData(WeekData data, int planTaskId, int planId, String date, bool? forcedValue) {
    final updatedPlanTasks = Map<String, List<WeekPlanTask>>.from(data.planTasks);
    if (updatedPlanTasks.containsKey(date)) {
      updatedPlanTasks[date] = [
        for (final t in updatedPlanTasks[date]!)
          if (t.id == planTaskId && t.planId == planId)
            t.copyWith(isCompleted: forcedValue ?? !t.isCompleted)
          else
            t,
      ];
    }
    return data.copyWith(planTasks: updatedPlanTasks);
  }
}
