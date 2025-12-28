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
}
