import 'package:marquer/api/models/tasks/tasks/task_status.dart';

class Task {
  final int id;
  final String name;
  final TaskStatus status;
  final String createdAt;
  final String updatedAt;

  Task({
    required this.id,
    required this.name,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Task.fromJson(Map<String, dynamic> json) => Task(
    id: json['id'] as int,
    name: json['name'] as String,
    status: json['categories'] as TaskStatus,
    createdAt: json['created_at'] as String,
    updatedAt: json['updated_at'] as String,
  );
}
