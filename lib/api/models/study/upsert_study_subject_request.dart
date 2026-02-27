class UpsertStudySubjectRequest {
  final String name;
  final String color;

  UpsertStudySubjectRequest({required this.name, required this.color});

  Map<String, dynamic> toJson() => {'name': name, 'color': color};
}
