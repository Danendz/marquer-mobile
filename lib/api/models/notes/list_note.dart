class ListNote {
  final int id;
  final String title;
  final String createdAt;
  final String updatedAt;

  ListNote({
    required this.id,
    required this.title,
    required this.createdAt,
    required this.updatedAt,
  });

  factory ListNote.fromJson(Map<String, dynamic> json) => ListNote(
    id: json['id'] as int,
    title: json['title'] as String,
    createdAt: json['created_at'] as String,
    updatedAt: json['updated_at'] as String,
  );
}
