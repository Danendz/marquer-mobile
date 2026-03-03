import 'package:flutter/material.dart';

class ToastService {
  static final messengerKey = GlobalKey<ScaffoldMessengerState>();

  static void showError(String message) {
    final state = messengerKey.currentState;
    if (state == null) return;

    state
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text(message),
          behavior: SnackBarBehavior.floating,
        ),
      );
  }

  static void showSuccess(String message) {
    final state = messengerKey.currentState;
    if (state == null) return;

    state
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Row(
            children: [
              const Icon(Icons.check_circle, color: Colors.white, size: 20),
              const SizedBox(width: 8),
              Expanded(child: Text(message)),
            ],
          ),
          backgroundColor: Colors.green,
          behavior: SnackBarBehavior.floating,
        ),
      );
  }
}
