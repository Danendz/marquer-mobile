import 'package:freezed_annotation/freezed_annotation.dart';

part 'countdown.freezed.dart';
part 'countdown.g.dart';

@freezed
abstract class Countdown with _$Countdown {
  const factory Countdown({
    required int id,
    required String name,
    @JsonKey(name: 'target_date') required String targetDate,
    @JsonKey(name: 'bg_image') required String bgImage,
    @JsonKey(name: 'is_pinned') required bool isPinned,
    @JsonKey(name: 'created_at') required String createdAt,
    @JsonKey(name: 'updated_at') required String updatedAt,
  }) = _Countdown;

  factory Countdown.fromJson(Map<String, dynamic> json) =>
      _$CountdownFromJson(json);
}
