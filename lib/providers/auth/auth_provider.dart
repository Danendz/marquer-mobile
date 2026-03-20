import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:marquer/api/models/auth/user.dart';
import 'package:marquer/api/services/auth_service.dart';

enum AuthStatus { unknown, unauthenticated, authenticated }

final authProvider = NotifierProvider<AuthNotifier, AuthState>(
  AuthNotifier.new,
);

class AuthState {
  final AuthStatus status;
  final String? token;
  final User? user;

  const AuthState({
    this.status = AuthStatus.unknown,
    this.token,
    this.user,
  });

  AuthState copyWith({AuthStatus? status, String? token, User? user}) =>
      AuthState(
        status: status ?? this.status,
        token: token ?? this.token,
        user: user ?? this.user,
      );
}

class AuthNotifier extends Notifier<AuthState> {
  static const _tokenKey = 'access_token';
  final _storage = const FlutterSecureStorage();
  final _authService = AuthService();

  @override
  AuthState build() => const AuthState();

  Future<void> loadFromStorage() async {
    final token = await _storage.read(key: _tokenKey);
    if (token == null) {
      state = const AuthState(status: AuthStatus.unauthenticated);
      return;
    }

    state = AuthState(status: AuthStatus.unknown, token: token);
    try {
      final user = await _authService.me();
      state = AuthState(
        status: AuthStatus.authenticated,
        token: token,
        user: user,
      );
    } catch (e) {
      debugPrint('Failed to fetch user: $e');
      // On 401, AuthInterceptor already handled refresh/logout.
      // On network errors, keep token for retry on next app open.
      state = AuthState(status: AuthStatus.authenticated, token: token);
    }
  }

  Future<void> setToken(String token) async {
    await _storage.write(key: _tokenKey, value: token);
    try {
      final user = await _authService.me();
      state = AuthState(
        status: AuthStatus.authenticated,
        token: token,
        user: user,
      );
    } catch (e) {
      state = AuthState(status: AuthStatus.authenticated, token: token);
    }
  }

  Future<void> logout() async {
    await _storage.delete(key: _tokenKey);
    state = const AuthState(status: AuthStatus.unauthenticated);
  }
}

/// Bridges Riverpod [authProvider] to a [ChangeNotifier] so GoRouter's
/// [refreshListenable] can trigger navigation on auth state changes.
class AuthRefreshNotifier extends ChangeNotifier {
  late final ProviderSubscription<AuthState> _subscription;

  AuthRefreshNotifier(WidgetRef ref) {
    _subscription =
        ref.listenManual(authProvider, (_, _) => notifyListeners());
  }

  @override
  void dispose() {
    _subscription.close();
    super.dispose();
  }
}
