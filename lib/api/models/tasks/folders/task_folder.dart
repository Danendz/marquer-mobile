import 'package:marquer/api/models/tasks/categories/task_category.dart';

class TaskFolder {
  final int id;
  final String name;
  final List<TaskCategory> categories;
  final String? createdAt;
  final String? updatedAt;

  TaskFolder({
    required this.id,
    required this.name,
    required this.categories,
    this.createdAt,
    this.updatedAt,
  });

  factory TaskFolder.fromJson(Map<String, dynamic> json) => TaskFolder(
    id: json['id'] as int,
    name: json['name'] as String,
    categories: (json['categories'] as List? ?? [])
        .map((e) => TaskCategory.fromJson(e as Map<String, dynamic>))
        .toList(),
    createdAt: json['created_at'] as String?,
    updatedAt: json['updated_at'] as String?,
  );

  TaskFolder copyWith({
    int? id,
    String? name,
    List<TaskCategory>? categories,
    String? createdAt,
    String? updatedAt,
  }) {
    return TaskFolder(
      id: id ?? this.id,
      name: name ?? this.name,
      categories: categories ?? this.categories,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
