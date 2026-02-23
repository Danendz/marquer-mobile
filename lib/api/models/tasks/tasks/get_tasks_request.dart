class GetTasksRequest {
  final int? taskCategoryId;
  final String? status;

  GetTasksRequest({
    this.taskCategoryId,
    this.status,
  });

  Map<String, dynamic> toJson() => {
    if (taskCategoryId != null) 'task_category_id': taskCategoryId,
    if (status != null) 'status': status,
  };
}
