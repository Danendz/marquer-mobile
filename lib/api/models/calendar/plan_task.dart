class PlanTask {
  final int id;
  final String name;
  final int sortOrder;

  const PlanTask({
    required this.id,
    required this.name,
    required this.sortOrder,
  });

  factory PlanTask.fromJson(Map<String, dynamic> json) => PlanTask(
    id: json['id'] as int,
    name: json['name'] as String,
    sortOrder: json['sort_order'] as int,
  );

  PlanTask copyWith({String? name, int? sortOrder}) => PlanTask(
    id: id,
    name: name ?? this.name,
    sortOrder: sortOrder ?? this.sortOrder,
  );
}
