import 'package:get_it/get_it.dart';
import 'package:marquer/api/api.dart';
import 'package:marquer/api/models/auth/auth_response.dart';
import 'package:marquer/api/models/auth/login_request.dart';
import 'package:marquer/api/models/auth/user.dart';

import '../models/auth/register_request.dart';
import '../models/model_parser.dart';

final getIt = GetIt.instance;

final class AuthService {
  final api = getIt<ApiService>(instanceName: 'authApi');

  Future<AuthResponse> login(LoginRequest data) async {
    final resp = await api.post<AuthResponse>(
      '/login',
      body: data,
      fromJsonT: (json) =>
          ModelParser.objectFromJson(json, AuthResponse.fromJson),
    );

    return resp.data;
  }

  Future<AuthResponse> register(RegisterRequest data) async {
    final resp = await api.post<AuthResponse>(
      '/register',
      body: data,
      fromJsonT: (json) =>
          ModelParser.objectFromJson(json, AuthResponse.fromJson),
    );

    return resp.data;
  }

  Future<AuthResponse> refresh() async {
    final resp = await api.post<AuthResponse>(
      '/refresh',
      fromJsonT: (json) =>
          ModelParser.objectFromJson(json, AuthResponse.fromJson),
    );

    return resp.data;
  }

  Future<User> me() async {
    final resp = await api.get<User>(
      '/me',
      fromJsonT: (json) => ModelParser.objectFromJson(json, User.fromJson),
    );

    return resp.data;
  }
}
