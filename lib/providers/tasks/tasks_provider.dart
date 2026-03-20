import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:marquer/api/models/tasks/tasks/create_task_request.dart';
import 'package:marquer/api/models/tasks/tasks/get_tasks_request.dart';
import 'package:marquer/api/models/tasks/tasks/task.dart';
import 'package:marquer/api/models/tasks/tasks/task_status.dart';
import 'package:marquer/api/models/tasks/tasks/update_task_request.dart';
import 'package:marquer/api/services/tasks_service.dart';
import 'package:marquer/providers/optimistic_mutation.dart';
import 'package:marquer/providers/tasks/task_filter.dart';
import 'package:marquer/providers/tasks/task_filter_provider.dart';

final tasksProvider =
    AsyncNotifierProvider<TasksAsyncNotifier, List<Task>>(
      TasksAsyncNotifier.new,
    );

class TasksAsyncNotifier extends AsyncNotifier<List<Task>>
    with OptimisticMutation {
  final _service = TasksService();

  @override
  Future<List<Task>> build() async {
    final TaskFilter filter = ref.watch(taskFilterProvider);

    final request = switch (filter) {
      AllTasksFilter() => GetTasksRequest(),
      CategoryFilter(:final categoryId) => GetTasksRequest(taskCategoryId: categoryId),
      FolderFilter(:final folderId) => GetTasksRequest(taskFolderId: folderId),
      RecentlyDeletedFilter() => GetTasksRequest(status: TaskStatus.cancelled),
    };

    return _service.getTasks(request);
  }

  Future<void> addTask(String name, [int? categoryId]) async {
    final current = currentValue;
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

    await mutate(
      action: () => _service.createTask(
        CreateTaskRequest(name: name, taskCategoryId: categoryId),
      ),
      errorMessage: 'Unable to add task! Try again later',
      rollback: () => [
        for (final t in state.asData?.value ?? current)
          if (t.id != optimistic.id) t,
      ],
      onSuccess: (latest, created) => [
        for (final t in latest)
          if (t.id == optimistic.id) created else t,
      ],
    );
  }

  Future<void> toggleTaskStatus(Task task) async {
    final current = currentValue;
    if (current == null) return;

    final newStatus = task.status == TaskStatus.done
        ? TaskStatus.draft
        : TaskStatus.done;

    state = AsyncData([
      for (final t in current)
        if (t.id == task.id) t.copyWith(status: newStatus) else t,
    ]);

    await mutate(
      action: () => _service.updateTask(
        task.id.toString(),
        UpdateTaskRequest(status: newStatus),
      ),
      errorMessage: 'Unable to update task! Try again later',
      rollback: () => [
        for (final t in state.asData?.value ?? current)
          if (t.id == task.id) task else t,
      ],
    );
  }

  Future<void> renameTask(Task task, String newName) async {
    final current = currentValue;
    if (current == null) return;

    state = AsyncData([
      for (final t in current)
        if (t.id == task.id) t.copyWith(name: newName) else t,
    ]);

    await mutate(
      action: () => _service.updateTask(
        task.id.toString(),
        UpdateTaskRequest(name: newName),
      ),
      errorMessage: 'Unable to rename task! Try again later',
      rollback: () => [
        for (final t in state.asData?.value ?? current)
          if (t.id == task.id) task else t,
      ],
    );
  }

  Future<void> updateTask(Task task, UpdateTaskRequest request, Task optimisticTask) async {
    final current = currentValue;
    if (current == null) return;

    state = AsyncData([
      for (final t in current)
        if (t.id == task.id) optimisticTask else t,
    ]);

    await mutate(
      action: () => _service.updateTask(task.id.toString(), request),
      errorMessage: 'Unable to update task! Try again later',
      rollback: () => [
        for (final t in state.asData?.value ?? current)
          if (t.id == task.id) task else t,
      ],
    );
  }

  Future<void> deleteTask(Task task) async {
    final current = currentValue;
    if (current == null) return;

    state = AsyncData([
      for (final t in current) if (t.id != task.id) t,
    ]);

    await mutate(
      action: () => _service.updateTask(
        task.id.toString(),
        UpdateTaskRequest(status: TaskStatus.cancelled),
      ),
      errorMessage: 'Unable to delete task! Try again later',
      rollback: () {
        final latest = state.asData?.value ?? current;
        return latest.any((t) => t.id == task.id) ? latest : [task, ...latest];
      },
    );
  }

  Future<void> permanentlyDelete(Task task) async {
    final current = currentValue;
    if (current == null) return;

    state = AsyncData([
      for (final t in current) if (t.id != task.id) t,
    ]);

    await mutate(
      action: () => _service.deleteTask(task.id.toString()),
      errorMessage: 'Unable to delete task! Try again later',
      rollback: () {
        final latest = state.asData?.value ?? current;
        return latest.any((t) => t.id == task.id) ? latest : [task, ...latest];
      },
    );
  }

  Future<void> restoreTask(Task task) async {
    final current = currentValue;
    if (current == null) return;

    state = AsyncData([
      for (final t in current) if (t.id != task.id) t,
    ]);

    await mutate(
      action: () => _service.updateTask(
        task.id.toString(),
        UpdateTaskRequest(status: TaskStatus.draft),
      ),
      errorMessage: 'Unable to restore task! Try again later',
      rollback: () {
        final latest = state.asData?.value ?? current;
        return latest.any((t) => t.id == task.id) ? latest : [task, ...latest];
      },
    );
  }
}
