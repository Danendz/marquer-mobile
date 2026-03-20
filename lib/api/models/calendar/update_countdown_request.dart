import 'package:freezed_annotation/freezed_annotation.dart';

part 'update_countdown_request.freezed.dart';
part 'update_countdown_request.g.dart';

@freezed
abstract class UpdateCountdownRequest with _$UpdateCountdownRequest {
  @JsonSerializable(includeIfNull: false)
  const factory UpdateCountdownRequest({
    String? name,
    @JsonKey(name: 'target_date') String? targetDate,
    @JsonKey(name: 'is_pinned') bool? isPinned,
    @JsonKey(name: 'bg_image') String? bgImage,
  }) = _UpdateCountdownRequest;

  factory UpdateCountdownRequest.fromJson(Map<String, dynamic> json) =>
      _$UpdateCountdownRequestFromJson(json);
}
