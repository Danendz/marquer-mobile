class CreateTaskRequest {
  final String name;
  final String? date;
  final String? startTime;
  final String? endTime;
  final int? taskCategoryId;
  final String? color;

  CreateTaskRequest({
    required this.name,
    this.date,
    this.startTime,
    this.endTime,
    this.taskCategoryId,
    this.color,
  });

  Map<String, dynamic> toJson() => {
    'name': name,
    if (date != null) 'date': date,
    if (startTime != null) 'start_time': startTime,
    if (endTime != null) 'end_time': endTime,
    if (taskCategoryId != null) 'task_category_id': taskCategoryId,
    if (color != null) 'color': color,
  };
}
