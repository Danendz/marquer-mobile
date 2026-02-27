class StudySubject {
  final int id;
  final String name;
  final String color; // hex like #4285F4
  final bool isSystem;
  final String createdAt;

  StudySubject({
    required this.id,
    required this.name,
    required this.color,
    required this.isSystem,
    required this.createdAt,
  });

  factory StudySubject.fromJson(Map<String, dynamic> json) => StudySubject(
    id: json['id'] as int,
    name: json['name'] as String,
    color: json['color'] as String,
    isSystem: json['is_system'] as bool,
    createdAt: json['created_at'] as String,
  );

  StudySubject copyWith({String? name, String? color}) => StudySubject(
    id: id,
    name: name ?? this.name,
    color: color ?? this.color,
    isSystem: isSystem,
    createdAt: createdAt,
  );
}
