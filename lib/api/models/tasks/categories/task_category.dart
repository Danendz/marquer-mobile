class TaskCategory {
  final int? id;
  final String name;
  final String color;
  final int tasksCount;
  final String? createdAt;
  final String? updatedAt;
  final String? tempNewUUID;

  TaskCategory({
    this.id,
    required this.name,
    required this.color,
    required this.tasksCount,
    this.createdAt,
    this.updatedAt,
    this.tempNewUUID
  });

  factory TaskCategory.fromJson(Map<String, dynamic> json) => TaskCategory(
    id: json['id'] as int,
    name: json['name'] as String,
    color: json['color'] as String,
    tasksCount: json['tasks_count'] as int,
    createdAt: json['created_at'] as String,
    updatedAt: json['updated_at'] as String,
  );

  TaskCategory copyWith({
    int? id,
    String? name,
    String? color,
    int? tasksCount,
    String? createdAt,
    String? updatedAt,
  }) {
    return TaskCategory(
      id: id ?? this.id,
      name: name ?? this.name,
      color: color ?? this.color,
      tasksCount: tasksCount ?? this.tasksCount,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
