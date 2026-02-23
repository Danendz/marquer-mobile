class UpdateTaskCategoryRequest {
  String? name;
  int? taskFolderId;
  String? color;

  UpdateTaskCategoryRequest({
    this.name,
    this.taskFolderId,
    this.color
  });

  Map<String, dynamic> toJson() => {
    if (name != null) 'name': name,
    if (taskFolderId != null) 'task_folder_id': taskFolderId,
    if (color != null) 'color': color,
  };
}
