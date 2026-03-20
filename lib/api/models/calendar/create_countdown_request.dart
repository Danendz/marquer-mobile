import 'package:freezed_annotation/freezed_annotation.dart';

part 'create_countdown_request.freezed.dart';
part 'create_countdown_request.g.dart';

@freezed
abstract class CreateCountdownRequest with _$CreateCountdownRequest {
  const factory CreateCountdownRequest({
    required String name,
    @JsonKey(name: 'target_date') required String targetDate,
    @JsonKey(name: 'bg_image') required String bgImage,
  }) = _CreateCountdownRequest;

  factory CreateCountdownRequest.fromJson(Map<String, dynamic> json) =>
      _$CreateCountdownRequestFromJson(json);
}
