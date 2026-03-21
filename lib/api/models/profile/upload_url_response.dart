import 'package:freezed_annotation/freezed_annotation.dart';

part 'upload_url_response.freezed.dart';
part 'upload_url_response.g.dart';

@freezed
abstract class UploadUrlResponse with _$UploadUrlResponse {
  const factory UploadUrlResponse({
    @JsonKey(name: 'upload_url') required String uploadUrl,
    @JsonKey(name: 'public_url') required String publicUrl,
    @JsonKey(name: 'object_key') required String objectKey,
  }) = _UploadUrlResponse;

  factory UploadUrlResponse.fromJson(Map<String, dynamic> json) =>
      _$UploadUrlResponseFromJson(json);
}
