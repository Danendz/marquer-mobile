class CalendarOverview {
  final Set<String> datesWithIncomplete;
  final Set<String> datesWithPlans;

  CalendarOverview({required this.datesWithIncomplete, required this.datesWithPlans});

  factory CalendarOverview.fromJson(Map<String, dynamic> json) => CalendarOverview(
    datesWithIncomplete: Set<String>.from(json['tasks'] as List),
    datesWithPlans: Set<String>.from(json['plan_tasks'] as List),
  );
}
