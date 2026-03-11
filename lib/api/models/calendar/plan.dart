import 'package:marquer/api/models/calendar/plan_schedule.dart';
import 'package:marquer/api/models/calendar/plan_task.dart';

class Plan {
  final int id;
  final String name;
  final PlanSchedule schedule;
  final String startDate;
  final String? endDate;
  final bool isActive;
  final String? color;
  final List<PlanTask> tasks;
  final String createdAt;
  final String updatedAt;

  const Plan({
    required this.id,
    required this.name,
    required this.schedule,
    required this.startDate,
    this.endDate,
    required this.isActive,
    this.color,
    required this.tasks,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Plan.fromJson(Map<String, dynamic> json) => Plan(
    id: json['id'] as int,
    name: json['name'] as String,
    schedule: PlanSchedule.fromJson(json['schedule'] as Map<String, dynamic>),
    startDate: json['start_date'] as String,
    endDate: json['end_date'] as String?,
    isActive: json['is_active'] as bool,
    color: json['color'] as String?,
    tasks: (json['tasks'] as List).map((t) => PlanTask.fromJson(t as Map<String, dynamic>)).toList(),
    createdAt: json['created_at'] as String,
    updatedAt: json['updated_at'] as String,
  );

  Plan copyWith({
    String? name,
    PlanSchedule? schedule,
    String? startDate,
    String? endDate,
    bool? isActive,
    String? color,
    List<PlanTask>? tasks,
  }) => Plan(
    id: id,
    name: name ?? this.name,
    schedule: schedule ?? this.schedule,
    startDate: startDate ?? this.startDate,
    endDate: endDate ?? this.endDate,
    isActive: isActive ?? this.isActive,
    color: color ?? this.color,
    tasks: tasks ?? this.tasks,
    createdAt: createdAt,
    updatedAt: updatedAt,
  );
}
