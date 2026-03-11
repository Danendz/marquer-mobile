class CreateCountdownRequest {
  final String name;
  final String targetDate;

  CreateCountdownRequest({required this.name, required this.targetDate});

  Map<String, dynamic> toJson() => {
    'name': name,
    'target_date': targetDate,
  };
}
