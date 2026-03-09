class UpdateCountdownRequest {
  final String? name;
  final String? targetDate;
  final bool? isPinned;
  final String? bgImage;

  UpdateCountdownRequest({this.name, this.targetDate, this.isPinned, this.bgImage});

  Map<String, dynamic> toJson() => {
    if (name != null) 'name': name,
    if (targetDate != null) 'target_date': targetDate,
    if (isPinned != null) 'is_pinned': isPinned,
    if (bgImage != null) 'bg_image': bgImage,
  };
}
