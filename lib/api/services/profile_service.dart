import 'package:get_it/get_it.dart';
import 'package:marquer/api/api.dart';
import 'package:marquer/api/models/profile/user_profile.dart';
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
}
