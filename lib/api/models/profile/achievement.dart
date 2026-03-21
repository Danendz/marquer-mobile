import 'package:freezed_annotation/freezed_annotation.dart';

part 'achievement.freezed.dart';
part 'achievement.g.dart';

@freezed
abstract class Achievement with _$Achievement {
  const factory Achievement({
    required int id,
    required String key,
    required String name,
    required String description,
    required String icon,
    required String category,
    @JsonKey(name: 'target_type') required String targetType,
    @JsonKey(name: 'target_value') required int targetValue,
    required bool unlocked,
    @JsonKey(name: 'unlocked_at') String? unlockedAt,
  }) = _Achievement;

  factory Achievement.fromJson(Map<String, dynamic> json) =>
      _$AchievementFromJson(json);
}
