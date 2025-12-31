import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:marquer/stores/user_store.dart';

enum AuthStatus { unknown, unauthenticated, authenticated }

class AuthStore extends ChangeNotifier {
  AuthStatus _status = AuthStatus.unknown;
  AuthStatus get status => _status;

  final FlutterSecureStorage _storage = const FlutterSecureStorage();
  static const _tokenKey = 'access_token';

  String? _token;
  String? get token => _token;

  late final UserStore userStore = GetIt.instance<UserStore>();

  Future<void> loadFromStorage() async {
    _token = await _storage.read(key: _tokenKey);
    if (_token == null) {
      _status = AuthStatus.unauthenticated;
      notifyListeners();
      return;
    }

    await userStore.fetchMe();
    _status = AuthStatus.authenticated;
    notifyListeners();
  }

  Future<void> setToken(String token) async {
    _token = token;
    _status = AuthStatus.authenticated;
    await _storage.write(key: _tokenKey, value: token);
    notifyListeners();
  }

  Future<void> logout() async {
    _token = null;
    _status = AuthStatus.unauthenticated;
    await _storage.delete(key: _tokenKey);
    userStore.clear();
    notifyListeners();
  }
}
