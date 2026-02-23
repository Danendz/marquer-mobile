class CreateTaskRequest {
  final String name;
  final int? taskCategoryId;

  CreateTaskRequest({
    required this.name,
    this.taskCategoryId,
  });

  Map<String, dynamic> toJson() => {
    'name': name,
    if (taskCategoryId != null) 'task_category_id': taskCategoryId,
  };
}
