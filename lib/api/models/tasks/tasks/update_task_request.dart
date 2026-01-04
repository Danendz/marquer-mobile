import 'package:marquer/api/models/tasks/tasks/task_status.dart';

class UpdateTaskRequest {
  final String name;
  final int taskCategoryId;
  final TaskStatus status;

  UpdateTaskRequest({
    required this.name,
    required this.taskCategoryId,
    required this.status,
  });

  Map<String, dynamic> toJson() => {
    'name': name,
    'task_category_id': taskCategoryId,
    'status': status.name,
  };
}
