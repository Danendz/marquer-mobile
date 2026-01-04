class TaskCategory {
  final int id;
  final String name;
  final String color;
  final int tasksCount;
  final String createdAt;
  final String updatedAt;

  TaskCategory({
    required this.id,
    required this.name,
    required this.color,
    required this.tasksCount,
    required this.createdAt,
    required this.updatedAt,
  });

  factory TaskCategory.fromJson(Map<String, dynamic> json) => TaskCategory(
    id: json['id'] as int,
    name: json['name'] as String,
    color: json['color'] as String,
    tasksCount: json['tasks_count'] as int,
    createdAt: json['created_at'] as String,
    updatedAt: json['updated_at'] as String,
  );
}
