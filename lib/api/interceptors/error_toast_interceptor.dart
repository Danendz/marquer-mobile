import 'dart:io';
import 'package:dio/dio.dart';

import '../../services/toast_service.dart';

class ErrorToastInterceptor extends Interceptor {
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    final msg = _toMessage(err);
    ToastService.showError(msg);
    handler.next(err);
  }

  String _toMessage(DioException e) {
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
