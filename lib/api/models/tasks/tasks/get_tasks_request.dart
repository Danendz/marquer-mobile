import 'package:marquer/api/models/tasks/tasks/task_status.dart';

class GetTasksRequest {
  final int? taskCategoryId;
  final int? taskFolderId;
  final TaskStatus? status;

  GetTasksRequest({
    this.taskCategoryId,
    this.taskFolderId,
    this.status,
  });

  Map<String, dynamic> toJson() => {
    if (taskCategoryId != null) 'task_category_id': taskCategoryId,
    if (taskFolderId != null) 'task_folder_id': taskFolderId,
    if (status != null) 'status': status!.name,
  };
}
