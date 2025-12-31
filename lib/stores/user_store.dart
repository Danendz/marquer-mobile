import 'package:flutter/foundation.dart';
import 'package:marquer/api/models/auth/user.dart';
import 'package:marquer/api/services/auth_service.dart';

class UserStore extends ChangeNotifier {
  User? _user;
  User? get user => _user;
  late final authService = AuthService();
  bool _loadingMe = false;

  Future<void> fetchMe() async {
    if (_loadingMe || user != null) return;

    _loadingMe = true;
    try {
      _user = await authService.me();
    } finally {
      _loadingMe = false;
    }
    notifyListeners();
  }

  void clear() {
    _user = null;
    notifyListeners();
  }
}
