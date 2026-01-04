class GetTasksRequest {
  final int taskCategoryId;

  GetTasksRequest({
    required this.taskCategoryId,
  });

  Map<String, dynamic> toJson() => {
    'task_category_id': taskCategoryId,
  };
}
