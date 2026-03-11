class Countdown {
  final int id;
  final String name;
  final String targetDate;
  final String bgImage;
  final bool isPinned;
  final String createdAt;
  final String updatedAt;

  Countdown({
    required this.id,
    required this.name,
    required this.targetDate,
    required this.bgImage,
    required this.isPinned,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Countdown.fromJson(Map<String, dynamic> json) => Countdown(
    id: json['id'] as int,
    name: json['name'] as String,
    targetDate: json['target_date'] as String,
    bgImage: json['bg_image'] as String,
    isPinned: json['is_pinned'] as bool,
    createdAt: json['created_at'] as String,
    updatedAt: json['updated_at'] as String,
  );

  Countdown copyWith({String? name, String? targetDate, bool? isPinned, String? bgImage}) {
    return Countdown(
      id: id,
      name: name ?? this.name,
      targetDate: targetDate ?? this.targetDate,
      bgImage: bgImage ?? this.bgImage,
      isPinned: isPinned ?? this.isPinned,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }
}
