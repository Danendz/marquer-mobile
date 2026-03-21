import 'package:get_it/get_it.dart';
import 'package:marquer/api/api.dart';
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
