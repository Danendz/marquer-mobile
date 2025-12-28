import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:marquer/api/api.dart';
import 'package:marquer/api/models/auth/auth_response.dart';
import 'package:marquer/api/models/auth/login_request.dart';

import '../models/auth/register_request.dart';
import '../models/model_parser.dart';

final class AuthService {
  final api = ApiService(baseUrl: dotenv.get('AUTH_API_URL'));

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
}
