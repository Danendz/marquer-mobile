import 'package:freezed_annotation/freezed_annotation.dart';

part 'friendship.freezed.dart';
part 'friendship.g.dart';

@freezed
abstract class Friend with _$Friend {
  const factory Friend({
    @JsonKey(name: 'user_id') required int userId,
    String? username,
    String? status,
    @JsonKey(name: 'avatar_url') String? avatarUrl,
  }) = _Friend;

  factory Friend.fromJson(Map<String, dynamic> json) =>
      _$FriendFromJson(json);
}

@freezed
abstract class FriendRequest with _$FriendRequest {
  const factory FriendRequest({
    required int id,
    @JsonKey(name: 'user_id') required int userId,
    String? username,
    @JsonKey(name: 'avatar_url') String? avatarUrl,
    @JsonKey(name: 'created_at') String? createdAt,
  }) = _FriendRequest;

  factory FriendRequest.fromJson(Map<String, dynamic> json) =>
      _$FriendRequestFromJson(json);
}
