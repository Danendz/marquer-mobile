class PlanTaskForDate {
  final int id;
  final String name;
  final int sortOrder;
  final bool isCompleted;

  const PlanTaskForDate({
    required this.id,
    required this.name,
    required this.sortOrder,
    required this.isCompleted,
  });

  factory PlanTaskForDate.fromJson(Map<String, dynamic> json) => PlanTaskForDate(
    id: json['id'] as int,
    name: json['name'] as String,
    sortOrder: json['sort_order'] as int,
    isCompleted: json['is_completed'] as bool,
  );

  PlanTaskForDate copyWith({bool? isCompleted}) => PlanTaskForDate(
    id: id,
    name: name,
    sortOrder: sortOrder,
    isCompleted: isCompleted ?? this.isCompleted,
  );
}

class PlanForDate {
  final int id;
  final String name;
  final List<PlanTaskForDate> tasks;

  const PlanForDate({
    required this.id,
    required this.name,
    required this.tasks,
  });

  factory PlanForDate.fromJson(Map<String, dynamic> json) => PlanForDate(
    id: json['id'] as int,
    name: json['name'] as String,
    tasks: (json['tasks'] as List).map((t) => PlanTaskForDate.fromJson(t as Map<String, dynamic>)).toList(),
  );

  PlanForDate copyWith({List<PlanTaskForDate>? tasks}) => PlanForDate(
    id: id,
    name: name,
    tasks: tasks ?? this.tasks,
  );
}
