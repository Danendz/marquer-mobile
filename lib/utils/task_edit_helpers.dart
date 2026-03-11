import 'package:marquer/api/models/tasks/tasks/task.dart';
import 'package:marquer/api/models/tasks/tasks/update_task_request.dart';

/// Builds the [UpdateTaskRequest] and optimistic [Task] from [TaskEditSheet.onSave] inputs.
({UpdateTaskRequest request, Task optimistic}) buildUpdateRequestAndOptimistic(
  Task task, {
  required String name,
  required String? startTime,
  required String? endTime,
  required bool clearStartTime,
  required bool clearEndTime,
  required String? color,
}) {
  final request = UpdateTaskRequest(
    name: name != task.name ? name : null,
    startTime: startTime,
    endTime: endTime,
    clearStartTime: clearStartTime,
    clearEndTime: clearEndTime,
    color: color,
    clearColor: color == null && task.color != null,
  );
  final optimistic = task.copyWith(
    name: name,
    startTime: startTime,
    endTime: endTime,
    color: color,
  );
  return (request: request, optimistic: optimistic);
}
