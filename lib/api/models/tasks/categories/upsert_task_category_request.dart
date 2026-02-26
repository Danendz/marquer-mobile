class UpsertTaskCategoryRequest {
  final String name;
  final int taskFolderId;
  final String? color;

  const UpsertTaskCategoryRequest({
    required this.name,
    required this.taskFolderId,
    this.color,
  });

  Map<String, dynamic> toJson() => {
    'name': name,
    'task_folder_id': taskFolderId,
    if (color != null) 'color': color,
  };
}
