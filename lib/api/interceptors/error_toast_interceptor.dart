import 'dart:io';
import 'package:dio/dio.dart';
import 'package:marquer/stores/auth_store.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

import '../../services/toast_service.dart';

class ErrorToastInterceptor extends Interceptor {
  ErrorToastInterceptor(this._auth);

  final AuthStore _auth;

  @override
  Future<void> onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    await Sentry.captureException(err, stackTrace: err.stackTrace);
    final msg = await _toMessage(err);
    ToastService.showError(msg);
    handler.next(err);
  }

  Future<String> _toMessage(DioException e) async {
    if (e.type == DioExceptionType.connectionTimeout ||
        e.type == DioExceptionType.receiveTimeout ||
        e.type == DioExceptionType.sendTimeout) {
      return 'Timeout. Try again.';
    }
    if (e.type == DioExceptionType.connectionError ||
        e.error is SocketException) {
      return 'No internet connection.';
    }
    if (e.type == DioExceptionType.cancel) {
      return 'Request cancelled.';
    }

    if (e.response?.statusCode == 401) {
      await _auth.logout();

      return 'Authorization required.';
    }

    final status = e.response?.statusCode;
    final data = e.response?.data;

    if (data is Map<String, dynamic> && data['message'] is String) {
      return data['message'] as String;
    }

    if (status != null) {
      return 'Request failed ($status).';
    }

    return 'Unexpected error.';
  }
}
