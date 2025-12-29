class CreateNoteRequest {
  final String content;
  final String title;

  CreateNoteRequest({
    required this.title,
    required this.content,
  });

  Map<String, dynamic> toJson() => {
    'content': content,
    'title': title,
  };
}
