import 'package:marquer/api/models/calendar/plan_schedule.dart';

class UpdatePlanTaskRequest {
  final int? id;
  final String name;
  final int sortOrder;
  final String? startTime;
  final String? endTime;

  const UpdatePlanTaskRequest({
    this.id,
    required this.name,
    required this.sortOrder,
    this.startTime,
    this.endTime,
  });

  Map<String, dynamic> toJson() => {
    if (id != null) 'id': id,
    'name': name,
    'sort_order': sortOrder,
    if (startTime != null) 'start_time': startTime,
    if (endTime != null) 'end_time': endTime,
  };
}

class UpdatePlanRequest {
  final String name;
  final PlanSchedule schedule;
  final String startDate;
  final String? endDate;
  final bool? isActive;
  final List<UpdatePlanTaskRequest> tasks;

  const UpdatePlanRequest({
    required this.name,
    required this.schedule,
    required this.startDate,
    this.endDate,
    this.isActive,
    required this.tasks,
  });

  Map<String, dynamic> toJson() => {
    'name': name,
    'schedule': schedule.toJson(),
    'start_date': startDate,
    if (endDate != null) 'end_date': endDate,
    if (isActive != null) 'is_active': isActive,
    'tasks': tasks.map((t) => t.toJson()).toList(),
  };
}
