import 'package:marquer/api/models/calendar/plan_schedule.dart';

class CreatePlanTaskRequest {
  final String name;
  final int sortOrder;
  final String? startTime;
  final String? endTime;

  const CreatePlanTaskRequest({
    required this.name,
    required this.sortOrder,
    this.startTime,
    this.endTime,
  });

  Map<String, dynamic> toJson() => {
    'name': name,
    'sort_order': sortOrder,
    if (startTime != null) 'start_time': startTime,
    if (endTime != null) 'end_time': endTime,
  };
}

class CreatePlanRequest {
  final String name;
  final PlanSchedule schedule;
  final String startDate;
  final String? endDate;
  final String? color;
  final List<CreatePlanTaskRequest> tasks;

  const CreatePlanRequest({
    required this.name,
    required this.schedule,
    required this.startDate,
    this.endDate,
    this.color,
    required this.tasks,
  });

  Map<String, dynamic> toJson() => {
    'name': name,
    'schedule': schedule.toJson(),
    'start_date': startDate,
    if (endDate != null) 'end_date': endDate,
    if (color != null) 'color': color,
    'tasks': tasks.map((t) => t.toJson()).toList(),
  };
}
