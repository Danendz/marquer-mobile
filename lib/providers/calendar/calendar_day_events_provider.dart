import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:marquer/api/models/tasks/tasks/create_task_request.dart';
import 'package:marquer/api/models/tasks/tasks/get_tasks_request.dart';
import 'package:marquer/api/models/tasks/tasks/task.dart';
import 'package:marquer/api/models/tasks/tasks/task_status.dart';
import 'package:marquer/api/models/tasks/tasks/update_task_request.dart';
import 'package:marquer/api/services/tasks_service.dart';
import 'package:marquer/providers/calendar/calendar_selected_date_provider.dart';
import 'package:marquer/utils/format.dart';
import 'package:marquer/services/toast_service.dart';

final calendarDayEventsProvider =
    AsyncNotifierProvider<CalendarDayEventsNotifier, List<Task>>(
      CalendarDayEventsNotifier.new,
    );

class CalendarDayEventsNotifier extends AsyncNotifier<List<Task>> {
  final _service = TasksService();

  @override
  Future<List<Task>> build() async {
    final selected = ref.watch(calendarSelectedDateProvider);
    return _service.getTasks(GetTasksRequest(date: formatDate(selected)));
  }

  Future<void> addEvent(String name, {String? startTime, String? endTime, String? date}) async {
    final current = state.asData?.value;
    if (current == null) return;
    final taskDate = date ?? formatDate(ref.read(calendarSelectedDateProvider));

    final optimistic = Task(
      id: -DateTime.now().millisecondsSinceEpoch,
      name: name,
      status: TaskStatus.draft,
      date: taskDate,
      startTime: startTime,
      endTime: endTime,
      createdAt: DateTime.now().toIso8601String(),
      updatedAt: DateTime.now().toIso8601String(),
    );

    state = AsyncData([optimistic, ...current]);

    try {
      final created = await _service.createTask(
        CreateTaskRequest(name: name, date: taskDate, startTime: startTime, endTime: endTime),
      );
      if (!ref.mounted) return;
      state = AsyncData([
        for (final t in state.asData!.value)
          if (t.id == optimistic.id) created else t,
      ]);
    } catch (e) {
      if (!ref.mounted) return;
      state = AsyncData([...?state.asData?.value]..removeWhere((t) => t.id == optimistic.id));
      debugPrint(e.toString());
      ToastService.showError('Unable to add event! Try again later');
    }
  }

  Future<void> toggleEvent(Task task) async {
    final current = state.asData?.value;
    if (current == null) return;

    final newStatus = task.status == TaskStatus.done ? TaskStatus.draft : TaskStatus.done;
    final optimistic = task.copyWith(status: newStatus);
    state = AsyncData([
      for (final t in current) if (t.id == task.id) optimistic else t,
    ]);

    try {
      final updated = await _service.updateTask(
        task.id.toString(),
        UpdateTaskRequest(status: newStatus),
      );
      if (!ref.mounted) return;
      state = AsyncData([
        for (final t in state.asData!.value) if (t.id == task.id) updated else t,
      ]);
    } catch (e) {
      if (!ref.mounted) return;
      state = AsyncData([
        for (final t in state.asData?.value ?? current) if (t.id == task.id) task else t,
      ]);
      debugPrint(e.toString());
      ToastService.showError('Unable to update event! Try again later');
    }
  }

  Future<void> deleteEvent(Task task) async {
    final current = state.asData?.value;
    if (current == null) return;

    state = AsyncData([for (final t in current) if (t.id != task.id) t]);

    try {
      await _service.deleteTask(task.id.toString());
    } catch (e) {
      if (!ref.mounted) return;
      final latest = state.asData?.value ?? current;
      state = AsyncData(latest.any((t) => t.id == task.id) ? latest : [task, ...latest]);
      debugPrint(e.toString());
      ToastService.showError('Unable to delete event! Try again later');
    }
  }

  Future<void> updateEvent(Task task, UpdateTaskRequest request, Task optimistic) async {
    final current = state.asData?.value;
    if (current == null) return;

    state = AsyncData([
      for (final t in current) if (t.id == task.id) optimistic else t,
    ]);

    try {
      final updated = await _service.updateTask(task.id.toString(), request);
      if (!ref.mounted) return;
      state = AsyncData([
        for (final t in state.asData!.value) if (t.id == task.id) updated else t,
      ]);
    } catch (e) {
      if (!ref.mounted) return;
      state = AsyncData([
        for (final t in state.asData?.value ?? current) if (t.id == task.id) task else t,
      ]);
      debugPrint(e.toString());
      ToastService.showError('Unable to update event! Try again later');
    }
  }

  Future<void> renameEvent(Task task, String newName) async {
    final current = state.asData?.value;
    if (current == null) return;

    state = AsyncData([
      for (final t in current) if (t.id == task.id) t.copyWith(name: newName) else t,
    ]);

    try {
      await _service.updateTask(task.id.toString(), UpdateTaskRequest(name: newName));
    } catch (e) {
      if (!ref.mounted) return;
      state = AsyncData([
        for (final t in state.asData?.value ?? current) if (t.id == task.id) task else t,
      ]);
      debugPrint(e.toString());
      ToastService.showError('Unable to rename event! Try again later');
    }
  }
}
