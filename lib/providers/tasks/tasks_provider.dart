import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:marquer/api/models/tasks/tasks/create_task_request.dart';
import 'package:marquer/api/models/tasks/tasks/get_tasks_request.dart';
import 'package:marquer/api/models/tasks/tasks/task.dart';
import 'package:marquer/api/models/tasks/tasks/task_status.dart';
import 'package:marquer/api/models/tasks/tasks/update_task_request.dart';
import 'package:marquer/api/services/tasks_service.dart';
import 'package:marquer/providers/tasks/task_filter.dart';
import 'package:marquer/providers/tasks/task_filter_provider.dart';
import 'package:marquer/services/toast_service.dart';

final tasksProvider =
    AsyncNotifierProvider<TasksAsyncNotifier, List<Task>>(
      TasksAsyncNotifier.new,
    );

class TasksAsyncNotifier extends AsyncNotifier<List<Task>> {
  final _service = TasksService();

  @override
  Future<List<Task>> build() async {
    final TaskFilter filter = ref.watch(taskFilterProvider);

    final request = switch (filter) {
      AllTasksFilter() => GetTasksRequest(),
      CategoryFilter(:final categoryId) => GetTasksRequest(taskCategoryId: categoryId),
      RecentlyDeletedFilter() => GetTasksRequest(status: 'cancelled'),
    };

    return _service.getTasks(request);
  }

  Future<void> addTask(String name, [int? categoryId]) async {
    final current = state.asData?.value;
    if (current == null) return;

    final optimistic = Task(
      id: -DateTime.now().millisecondsSinceEpoch,
      name: name,
      status: TaskStatus.draft,
      taskCategoryId: categoryId,
      createdAt: DateTime.now().toIso8601String(),
      updatedAt: DateTime.now().toIso8601String(),
    );

    state = AsyncData([optimistic, ...current]);

    try {
      final created = await _service.createTask(
        CreateTaskRequest(name: name, taskCategoryId: categoryId),
      );
      state = AsyncData([
        for (final t in state.asData!.value)
          if (t.id == optimistic.id) created else t,
      ]);
    } catch (e) {
      if (!ref.mounted) return;
      state = AsyncData(current);
      debugPrint(e.toString());
      ToastService.showError("Unable to add task! Try again later");
    }
  }

  Future<void> toggleTaskStatus(Task task) async {
    final current = state.asData?.value;
    if (current == null) return;

    final newStatus = task.status == TaskStatus.done
        ? TaskStatus.draft
        : TaskStatus.done;

    state = AsyncData([
      for (final t in current)
        if (t.id == task.id) t.copyWith(status: newStatus) else t,
    ]);

    try {
      await _service.updateTask(
        task.id.toString(),
        UpdateTaskRequest(status: newStatus),
      );
    } catch (e) {
      if (!ref.mounted) return;
      state = AsyncData(current);
      debugPrint(e.toString());
      ToastService.showError("Unable to update task! Try again later");
    }
  }

  Future<void> renameTask(Task task, String newName) async {
    final current = state.asData?.value;
    if (current == null) return;

    state = AsyncData([
      for (final t in current)
        if (t.id == task.id) t.copyWith(name: newName) else t,
    ]);

    try {
      await _service.updateTask(
        task.id.toString(),
        UpdateTaskRequest(name: newName),
      );
    } catch (e) {
      if (!ref.mounted) return;
      state = AsyncData(current);
      debugPrint(e.toString());
      ToastService.showError("Unable to rename task! Try again later");
    }
  }

  Future<void> deleteTask(Task task) async {
    final current = state.asData?.value;
    if (current == null) return;

    state = AsyncData([
      for (final t in current)
        if (t.id != task.id) t,
    ]);

    try {
      await _service.updateTask(
        task.id.toString(),
        UpdateTaskRequest(status: TaskStatus.cancelled),
      );
    } catch (e) {
      if (!ref.mounted) return;
      state = AsyncData(current);
      debugPrint(e.toString());
      ToastService.showError("Unable to delete task! Try again later");
    }
  }

  Future<void> permanentlyDelete(Task task) async {
    final current = state.asData?.value;
    if (current == null) return;

    state = AsyncData([
      for (final t in current)
        if (t.id != task.id) t,
    ]);

    try {
      await _service.deleteTask(task.id.toString());
    } catch (e) {
      if (!ref.mounted) return;
      state = AsyncData(current);
      debugPrint(e.toString());
      ToastService.showError("Unable to delete task! Try again later");
    }
  }

  Future<void> restoreTask(Task task) async {
    final current = state.asData?.value;
    if (current == null) return;

    state = AsyncData([
      for (final t in current)
        if (t.id != task.id) t,
    ]);

    try {
      await _service.updateTask(
        task.id.toString(),
        UpdateTaskRequest(status: TaskStatus.draft),
      );
    } catch (e) {
      if (!ref.mounted) return;
      state = AsyncData(current);
      debugPrint(e.toString());
      ToastService.showError("Unable to restore task! Try again later");
    }
  }
}
