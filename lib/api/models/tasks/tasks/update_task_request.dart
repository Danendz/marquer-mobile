import 'package:marquer/api/models/tasks/tasks/task_status.dart';

class UpdateTaskRequest {
  final String? name;
  final int? taskCategoryId;
  final TaskStatus? status;

  UpdateTaskRequest({
    this.name,
    this.taskCategoryId,
    this.status,
  });

  Map<String, dynamic> toJson() => {
    if (name != null) 'name': name,
    if (taskCategoryId != null) 'task_category_id': taskCategoryId,
    if (status != null) 'status': status!.name,
  };
}
