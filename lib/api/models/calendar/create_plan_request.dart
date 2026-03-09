import 'package:marquer/api/models/calendar/plan_schedule.dart';

class CreatePlanTaskRequest {
  final String name;
  final int sortOrder;

  const CreatePlanTaskRequest({required this.name, required this.sortOrder});

  Map<String, dynamic> toJson() => {'name': name, 'sort_order': sortOrder};
}

class CreatePlanRequest {
  final String name;
  final PlanSchedule schedule;
  final String startDate;
  final String? endDate;
  final List<CreatePlanTaskRequest> tasks;

  const CreatePlanRequest({
    required this.name,
    required this.schedule,
    required this.startDate,
    this.endDate,
    required this.tasks,
  });

  Map<String, dynamic> toJson() => {
    'name': name,
    'schedule': schedule.toJson(),
    'start_date': startDate,
    if (endDate != null) 'end_date': endDate,
    'tasks': tasks.map((t) => t.toJson()).toList(),
  };
}
