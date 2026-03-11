import 'package:marquer/api/models/tasks/tasks/task_status.dart';

class UpdateTaskRequest {
  final String? name;
  final String? date;
  final String? startTime;
  final String? endTime;
  final int? taskCategoryId;
  final TaskStatus? status;
  final bool clearStartTime;
  final bool clearEndTime;
  final String? color;
  final bool clearColor;

  UpdateTaskRequest({
    this.name,
    this.date,
    this.startTime,
    this.endTime,
    this.taskCategoryId,
    this.status,
    this.clearStartTime = false,
    this.clearEndTime = false,
    this.color,
    this.clearColor = false,
  });

  Map<String, dynamic> toJson() => {
    if (name != null) 'name': name,
    if (date != null) 'date': date,
    if (clearStartTime) 'start_time': null else if (startTime != null) 'start_time': startTime,
    if (clearEndTime) 'end_time': null else if (endTime != null) 'end_time': endTime,
    if (taskCategoryId != null) 'task_category_id': taskCategoryId,
    if (status != null) 'status': status!.name,
    if (clearColor) 'color': null else if (color != null) 'color': color,
  };
}
