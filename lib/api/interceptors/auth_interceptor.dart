import 'dart:async';

import 'package:dio/dio.dart';
import 'package:marquer/api/services/auth_service.dart';
import 'package:marquer/stores/auth_store.dart';

class AuthInterceptor extends Interceptor {
  final AuthStore auth;

  AuthInterceptor(this.auth);

  bool _isRefreshing = false;
  final List<_QueuedRequest> _queue = [];

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    final token = auth.token;

    if (token == null || token.isEmpty) {
      return handler.next(options);
    }

    final path = options.path;
    final isAuthEndpoint =
        path.startsWith('/login') || path.startsWith('/register');

    if (!isAuthEndpoint) {
      options.headers['Authorization'] = 'Bearer $token';
    }

    handler.next(options);
  }

  @override
  Future<void> onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    final status = err.response?.statusCode;
    final authService = AuthService();

    if (status != 401) {
      return handler.next(err);
    }

    final path = err.requestOptions.path;
    final isAuthEndpoint =
        path.startsWith('/login') ||
        path.startsWith('/register') ||
        path.startsWith('/refresh');

    if (isAuthEndpoint) {
      return handler.next(err);
    }

    final completer = Completer<Response<dynamic>>();
    _queue.add(_QueuedRequest(err.requestOptions, completer));

    if (_isRefreshing) {
      try {
        final res = await completer.future;
        return handler.resolve(res);
      } catch (e) {
        return handler.reject(err);
      }
    }

    _isRefreshing = true;

    try {
      final data = await authService.refresh();
      final newToken = data.token;
      await auth.setToken(newToken);

      final queued = List<_QueuedRequest>.from(_queue);
      _queue.clear();

      for (final item in queued) {
        final ro = item.requestOptions;

        try {
          final retryResponse = await _retryWithNewToken(ro, newToken);
          item.completer.complete(retryResponse);
        } catch (e) {
          item.completer.completeError(e);
        }
      }

      _isRefreshing = false;

      final res = await completer.future;
      return handler.resolve(res);
    } catch (e) {
      final queued = List<_QueuedRequest>.from(_queue);
      _queue.clear();
      for (final item in queued) {
        item.completer.completeError(e);
      }
      _isRefreshing = false;
      await auth.logout();

      return handler.next(err);
    }
  }

  Future<Response<dynamic>> _retryWithNewToken(
    RequestOptions requestOptions,
    String newToken,
  ) {
    final dio = Dio(BaseOptions(baseUrl: requestOptions.baseUrl));
    return dio.request<dynamic>(
      requestOptions.path,
      data: requestOptions.data,
      queryParameters: requestOptions.queryParameters,
      options: Options(
        method: requestOptions.method,
        headers: {
          ...requestOptions.headers,
          'Authorization': 'Bearer $newToken',
        },
        responseType: requestOptions.responseType,
        contentType: requestOptions.contentType,
        validateStatus: requestOptions.validateStatus,
        receiveDataWhenStatusError: requestOptions.receiveDataWhenStatusError,
        followRedirects: requestOptions.followRedirects,
      ),
      cancelToken: requestOptions.cancelToken,
      onReceiveProgress: requestOptions.onReceiveProgress,
      onSendProgress: requestOptions.onSendProgress,
    );
  }
}

class _QueuedRequest {
  final RequestOptions requestOptions;
  final Completer<Response<dynamic>> completer;

  _QueuedRequest(this.requestOptions, this.completer);
}
