import 'package:dio/dio.dart';
import 'package:marquer/stores/auth_store.dart';

class AuthInterceptor extends Interceptor {
  final AuthStore auth;

  AuthInterceptor(this.auth);

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    final token = auth.token;

    if (token == null || token.isEmpty) {
      return handler.next(options);
    }

    final path = options.path;
    final isAuthEndpoint = path.startsWith('/login') || path.startsWith('/register');

    if (!isAuthEndpoint) {
      options.headers['Authorization'] = 'Bearer $token';
    }

    handler.next(options);
  }
}
