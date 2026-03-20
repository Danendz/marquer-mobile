import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:marquer/api/interceptors/auth_interceptor.dart';
import 'package:sentry_dio/sentry_dio.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'interceptors/error_toast_interceptor.dart';

import 'models/api_response.dart';

class ApiService {
  final Dio _dio;

  ApiService({
    String? baseUrl,
    required String? Function() getToken,
    required Future<void> Function(String token) setToken,
    required Future<void> Function() logout,
  }) : _dio =
          Dio(
              BaseOptions(
                baseUrl: baseUrl ?? dotenv.get('MARQUER_API_URL'),
                connectTimeout: const Duration(seconds: 10),
                receiveTimeout: const Duration(seconds: 10),
                headers: {
                  'Content-Type': 'application/json',
                  'Accept': 'application/json',
                },
              ),
            )
            ..interceptors.addAll([
              AuthInterceptor(
                getToken: getToken,
                setToken: setToken,
                logout: logout,
              ),
              ErrorToastInterceptor(logout: logout),
              LogInterceptor(
                requestHeader: true,
                requestBody: true,
                responseHeader: true,
                responseBody: true,
                error: true,
                logPrint: (obj) => debugPrint(obj.toString()),
              ),
            ])
            ..addSentry(
              failedRequestStatusCodes: [
                SentryStatusCode(400),
                SentryStatusCode.range(402, 599),
              ],
            );

  Future<ApiResponse<T>> get<T>(
    String path, {
    Map<String, dynamic>? query,
    required T Function(Object? json) fromJsonT,
  }) async {
    final res = await _dio.get(path, queryParameters: query);
    final map = res.data as Map<String, dynamic>;
    return ApiResponse<T>.fromJson(map, fromJsonT);
  }

  Future<ApiResponse<T>> post<T>(
    String path, {
    Object? body,
    required T Function(Object? json) fromJsonT,
  }) async {
    final res = await _dio.post(path, data: body);
    final map = res.data as Map<String, dynamic>;
    return ApiResponse<T>.fromJson(map, fromJsonT);
  }

  Future<ApiResponse<T>> put<T>(
    String path, {
    Object? body,
    required T Function(Object? json) fromJsonT,
  }) async {
    final res = await _dio.put(path, data: body);
    final map = res.data as Map<String, dynamic>;
    return ApiResponse<T>.fromJson(map, fromJsonT);
  }

  Future<ApiResponse<Null>> delete(String path, {Object? body}) async {
    final res = await _dio.delete(path, data: body);
    final map = res.data as Map<String, dynamic>;
    return ApiResponse<Null>.fromJson(map, (json) => null);
  }
}
