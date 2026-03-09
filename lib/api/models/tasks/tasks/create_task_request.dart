class CreateTaskRequest {
  final String name;
  final String? date;
  final int? taskCategoryId;

  CreateTaskRequest({
    required this.name,
    this.date,
    this.taskCategoryId,
  });

  Map<String, dynamic> toJson() => {
    'name': name,
    if (date != null) 'date': date,
    if (taskCategoryId != null) 'task_category_id': taskCategoryId,
  };
}
