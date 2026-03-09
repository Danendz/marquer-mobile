class PlanTask {
  final int id;
  final String name;
  final int sortOrder;
  final String? startTime;
  final String? endTime;

  const PlanTask({
    required this.id,
    required this.name,
    required this.sortOrder,
    this.startTime,
    this.endTime,
  });

  factory PlanTask.fromJson(Map<String, dynamic> json) => PlanTask(
    id: json['id'] as int,
    name: json['name'] as String,
    sortOrder: json['sort_order'] as int,
    startTime: json['start_time'] as String?,
    endTime: json['end_time'] as String?,
  );

  PlanTask copyWith({String? name, int? sortOrder, String? startTime, String? endTime}) => PlanTask(
    id: id,
    name: name ?? this.name,
    sortOrder: sortOrder ?? this.sortOrder,
    startTime: startTime ?? this.startTime,
    endTime: endTime ?? this.endTime,
  );
}
