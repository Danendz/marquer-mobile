import 'package:freezed_annotation/freezed_annotation.dart';

part 'check_latest_response.freezed.dart';
part 'check_latest_response.g.dart';

@freezed
abstract class CheckLatestResponse with _$CheckLatestResponse {
  const factory CheckLatestResponse({
    required String version,
    @JsonKey(name: 'version_full') String? versionFull,
    @JsonKey(name: 'download_url') required String downloadUrl,
    String? changelog,
  }) = _CheckLatestResponse;

  factory CheckLatestResponse.fromJson(Map<String, dynamic> json) =>
      _$CheckLatestResponseFromJson(json);
}
