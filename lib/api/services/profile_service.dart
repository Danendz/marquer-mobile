import 'package:get_it/get_it.dart';
import 'package:marquer/api/api.dart';
import 'package:marquer/api/models/profile/achievement.dart';
import 'package:marquer/api/models/profile/friendship.dart';
import 'package:marquer/api/models/profile/upload_url_response.dart';
import 'package:marquer/api/models/profile/user_profile.dart';
import 'package:marquer/api/models/profile/user_settings.dart';
import 'package:marquer/api/models/profile/upsert_profile_request.dart';

import '../models/model_parser.dart';

final getIt = GetIt.instance;

class ProfileService {
  final api = getIt<ApiService>(instanceName: 'api');

  Future<UserProfile> getProfile() async {
    final resp = await api.get<UserProfile>(
      '/profile',
      fromJsonT: (json) =>
          ModelParser.objectFromJson(json, UserProfile.fromJson),
    );

    return resp.data;
  }

  Future<UserProfile> upsertProfile(UpsertProfileRequest request) async {
    final resp = await api.put<UserProfile>(
      '/profile',
      body: request,
      fromJsonT: (json) =>
          ModelParser.objectFromJson(json, UserProfile.fromJson),
    );

    return resp.data;
  }

  Future<UploadUrlResponse> getAvatarUploadUrl(String contentType) async {
    final resp = await api.post<UploadUrlResponse>(
      '/profile/avatar/upload-url',
      body: {'content_type': contentType},
      fromJsonT: (json) =>
          ModelParser.objectFromJson(json, UploadUrlResponse.fromJson),
    );

    return resp.data;
  }

  Future<UploadUrlResponse> getCoverUploadUrl(String contentType) async {
    final resp = await api.post<UploadUrlResponse>(
      '/profile/cover/upload-url',
      body: {'content_type': contentType},
      fromJsonT: (json) =>
          ModelParser.objectFromJson(json, UploadUrlResponse.fromJson),
    );

    return resp.data;
  }

  Future<List<Friend>> getFriends() async {
    final resp = await api.get<List<Friend>>(
      '/friends',
      fromJsonT: (json) => ModelParser.listFromJson(json, Friend.fromJson),
    );
    return resp.data;
  }

  Future<List<FriendRequest>> getPendingRequests() async {
    final resp = await api.get<List<FriendRequest>>(
      '/friends/requests',
      fromJsonT: (json) =>
          ModelParser.listFromJson(json, FriendRequest.fromJson),
    );
    return resp.data;
  }

  Future<void> sendFriendRequest(int friendId) async {
    await api.post<Map<String, dynamic>>(
      '/friends/request',
      body: {'friend_id': friendId},
      fromJsonT: (json) => json as Map<String, dynamic>,
    );
  }

  Future<void> respondToFriendRequest(int requestId, String action) async {
    await api.put<Map<String, dynamic>>(
      '/friends/request/$requestId',
      body: {'action': action},
      fromJsonT: (json) => json as Map<String, dynamic>,
    );
  }

  Future<void> removeFriend(int friendUserId) async {
    await api.delete('/friends/$friendUserId');
  }

  Future<List<Achievement>> getAchievements() async {
    final resp = await api.get<List<Achievement>>(
      '/achievements',
      fromJsonT: (json) =>
          ModelParser.listFromJson(json, Achievement.fromJson),
    );

    return resp.data;
  }

  Future<UserSettings> getSettings() async {
    final resp = await api.get<UserSettings>(
      '/settings',
      fromJsonT: (json) =>
          ModelParser.objectFromJson(json, UserSettings.fromJson),
    );

    return resp.data;
  }

  Future<UserSettings> upsertSettings(Map<String, dynamic> data) async {
    final resp = await api.put<UserSettings>(
      '/settings',
      body: data,
      fromJsonT: (json) =>
          ModelParser.objectFromJson(json, UserSettings.fromJson),
    );

    return resp.data;
  }
}
