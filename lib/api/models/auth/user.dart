class User {
  final int id;
  final String name;
  final String createdAt;

  User({
    required this.id,
    required this.name,
    required this.createdAt,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json['id'] as int,
    name: json['name'] as String,
    createdAt: json['created_at'] as String,
  );
}
