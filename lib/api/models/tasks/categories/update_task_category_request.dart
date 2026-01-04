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
    'name': name,
    'task_folder_id': taskFolderId,
    'color': color,
  };
}
