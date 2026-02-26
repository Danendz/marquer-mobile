import 'package:marquer/api/models/tasks/tasks/task_status.dart';

class Task {
  final int id;
  final String name;
  final TaskStatus status;
  final int? taskCategoryId;
  final String createdAt;
  final String updatedAt;

  Task({
    required this.id,
    required this.name,
    required this.status,
    this.taskCategoryId,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Task.fromJson(Map<String, dynamic> json) => Task(
    id: json['id'] as int,
    name: json['name'] as String,
    status: TaskStatus.values.firstWhere(
      (e) => e.name == json['status'],
      orElse: () => TaskStatus.draft,
    ),
    taskCategoryId: json['task_category_id'] as int?,
    createdAt: json['created_at'] as String,
    updatedAt: json['updated_at'] as String,
  );

  static const _unset = Object();

  Task copyWith({String? name, TaskStatus? status, Object? taskCategoryId = _unset}) {
    return Task(
      id: id,
      name: name ?? this.name,
      status: status ?? this.status,
      taskCategoryId: identical(taskCategoryId, _unset) ? this.taskCategoryId : taskCategoryId as int?,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }
}
