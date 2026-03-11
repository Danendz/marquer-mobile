import 'package:marquer/api/models/tasks/tasks/task_status.dart';

class GetTasksRequest {
  final int? taskCategoryId;
  final int? taskFolderId;
  final TaskStatus? status;
  final String? date;

  GetTasksRequest({
    this.taskCategoryId,
    this.taskFolderId,
    this.status,
    this.date,
  });

  Map<String, dynamic> toJson() => {
    if (taskCategoryId != null) 'task_category_id': taskCategoryId,
    if (taskFolderId != null) 'task_folder_id': taskFolderId,
    if (status != null) 'status': status!.name,
    if (date != null) 'date': date,
  };
}
