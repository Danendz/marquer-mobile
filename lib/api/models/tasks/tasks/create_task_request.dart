class CreateTaskRequest {
  final String name;
  final int taskCategoryId;

  CreateTaskRequest({
    required this.name,
    required this.taskCategoryId,
  });

  Map<String, dynamic> toJson() => {
    'name': name,
    'task_category_id': taskCategoryId,
  };
}
