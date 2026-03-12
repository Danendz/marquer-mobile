class CreateCountdownRequest {
  final String name;
  final String targetDate;
  final String bgImage;

  CreateCountdownRequest({required this.name, required this.targetDate, required this.bgImage});

  Map<String, dynamic> toJson() => {
    'name': name,
    'target_date': targetDate,
    'bg_image': bgImage,
  };
}
