import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:marquer/api/models/tasks/tasks/create_task_request.dart';
import 'package:marquer/api/models/tasks/tasks/get_tasks_request.dart';
import 'package:marquer/api/models/tasks/tasks/task.dart';
import 'package:marquer/api/models/tasks/tasks/task_status.dart';
import 'package:marquer/api/models/tasks/tasks/update_task_request.dart';
import 'package:marquer/api/services/tasks_service.dart';
import 'package:marquer/providers/calendar/calendar_selected_date_provider.dart';
import 'package:marquer/providers/optimistic_mutation.dart';
import 'package:marquer/utils/format.dart';
import 'package:marquer/services/toast_service.dart';

final calendarDayEventsProvider =
    AsyncNotifierProvider<CalendarDayEventsNotifier, List<Task>>(
      CalendarDayEventsNotifier.new,
    );

class CalendarDayEventsNotifier extends AsyncNotifier<List<Task>>
    with OptimisticMutation {
  final _service = TasksService();

  @override
  Future<List<Task>> build() async {
    final selected = ref.watch(calendarSelectedDateProvider);
    return _service.getTasks(GetTasksRequest(date: formatDate(selected)));
  }

  Future<void> addEvent(String name, {String? startTime, String? endTime, String? date, String? color}) async {
    final current = currentValue;
    final taskDate = date ?? formatDate(ref.read(calendarSelectedDateProvider));

    if (current == null) {
      // State not yet loaded — persist without optimistic update, then refresh
      try {
        await _service.createTask(
          CreateTaskRequest(name: name, date: taskDate, startTime: startTime, endTime: endTime, color: color),
        );
        if (!ref.mounted) return;
        ref.invalidateSelf();
      } catch (e) {
        debugPrint(e.toString());
        ToastService.showError('Unable to add event! Try again later');
      }
      return;
    }

    final optimistic = Task(
      id: -DateTime.now().millisecondsSinceEpoch,
      name: name,
      status: TaskStatus.draft,
      date: taskDate,
      startTime: startTime,
      endTime: endTime,
      color: color,
      createdAt: DateTime.now().toIso8601String(),
      updatedAt: DateTime.now().toIso8601String(),
    );

    state = AsyncData([optimistic, ...current]);

    await mutate(
      action: () => _service.createTask(
        CreateTaskRequest(name: name, date: taskDate, startTime: startTime, endTime: endTime, color: color),
      ),
      errorMessage: 'Unable to add event! Try again later',
      rollback: () => [...?state.asData?.value]..removeWhere((t) => t.id == optimistic.id),
      onSuccess: (latest, created) => [
        for (final t in latest) if (t.id == optimistic.id) created else t,
      ],
    );
  }

  Future<void> toggleEvent(Task task) async {
    final current = currentValue;
    if (current == null) return;

    final newStatus = task.status == TaskStatus.done ? TaskStatus.draft : TaskStatus.done;
    state = AsyncData([
      for (final t in current) if (t.id == task.id) task.copyWith(status: newStatus) else t,
    ]);

    await mutate(
      action: () => _service.updateTask(task.id.toString(), UpdateTaskRequest(status: newStatus)),
      errorMessage: 'Unable to update event! Try again later',
      rollback: () => [
        for (final t in state.asData?.value ?? current) if (t.id == task.id) task else t,
      ],
      onSuccess: (latest, updated) => [
        for (final t in latest) if (t.id == task.id) updated else t,
      ],
    );
  }

  Future<void> deleteEvent(Task task) async {
    final current = currentValue;
    if (current == null) return;

    state = AsyncData([for (final t in current) if (t.id != task.id) t]);

    await mutate(
      action: () => _service.deleteTask(task.id.toString()),
      errorMessage: 'Unable to delete event! Try again later',
      rollback: () {
        final latest = state.asData?.value ?? current;
        return latest.any((t) => t.id == task.id) ? latest : [task, ...latest];
      },
    );
  }

  Future<void> updateEvent(Task task, UpdateTaskRequest request, Task optimistic) async {
    final current = currentValue;
    if (current == null) return;

    state = AsyncData([
      for (final t in current) if (t.id == task.id) optimistic else t,
    ]);

    await mutate(
      action: () => _service.updateTask(task.id.toString(), request),
      errorMessage: 'Unable to update event! Try again later',
      rollback: () => [
        for (final t in state.asData?.value ?? current) if (t.id == task.id) task else t,
      ],
      onSuccess: (latest, updated) => [
        for (final t in latest) if (t.id == task.id) updated else t,
      ],
    );
  }

  Future<void> renameEvent(Task task, String newName) async {
    final current = currentValue;
    if (current == null) return;

    state = AsyncData([
      for (final t in current) if (t.id == task.id) t.copyWith(name: newName) else t,
    ]);

    await mutate(
      action: () => _service.updateTask(task.id.toString(), UpdateTaskRequest(name: newName)),
      errorMessage: 'Unable to rename event! Try again later',
      rollback: () => [
        for (final t in state.asData?.value ?? current) if (t.id == task.id) task else t,
      ],
      onSuccess: (latest, updated) => [
        for (final t in latest) if (t.id == task.id) updated else t,
      ],
    );
  }
}
