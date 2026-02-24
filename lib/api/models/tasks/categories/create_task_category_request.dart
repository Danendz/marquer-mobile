class CreateTaskCategoryRequest {
  final String name;
  final int taskFolderId;
  final String? color;

  CreateTaskCategoryRequest({
    required this.name,
    required this.taskFolderId,
    this.color
  });

  Map<String, dynamic> toJson() => {
    'name': name,
    'task_folder_id': taskFolderId,
    'color': color,
  };
}
