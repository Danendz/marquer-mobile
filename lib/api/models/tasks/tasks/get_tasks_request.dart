class GetTasksRequest {
  final int? taskCategoryId;
  final int? taskFolderId;
  final String? status;

  GetTasksRequest({
    this.taskCategoryId,
    this.taskFolderId,
    this.status,
  });

  Map<String, dynamic> toJson() => {
    if (taskCategoryId != null) 'task_category_id': taskCategoryId,
    if (taskFolderId != null) 'task_folder_id': taskFolderId,
    if (status != null) 'status': status,
  };
}
