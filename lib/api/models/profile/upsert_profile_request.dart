import 'package:freezed_annotation/freezed_annotation.dart';

part 'upsert_profile_request.freezed.dart';
part 'upsert_profile_request.g.dart';

@freezed
abstract class UpsertProfileRequest with _$UpsertProfileRequest {
  const factory UpsertProfileRequest({
    String? username,
    String? status,
    String? location,
    String? bio,
    @JsonKey(name: 'avatar_url') String? avatarUrl,
    @JsonKey(name: 'cover_url') String? coverUrl,
    @JsonKey(name: 'cover_type') String? coverType,
  }) = _UpsertProfileRequest;

  factory UpsertProfileRequest.fromJson(Map<String, dynamic> json) =>
      _$UpsertProfileRequestFromJson(json);
}
