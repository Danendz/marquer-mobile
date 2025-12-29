class UpdateNoteRequest {
  final String content;

  UpdateNoteRequest({
    required this.content,
  });

  Map<String, dynamic> toJson() => {
    'content': content,
  };
}
