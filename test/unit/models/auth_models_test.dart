import 'package:flutter_test/flutter_test.dart';
import 'package:marquer/api/models/auth/auth_response.dart';
import 'package:marquer/api/models/auth/login_request.dart';
import 'package:marquer/api/models/auth/register_request.dart';
import 'package:marquer/api/models/auth/user.dart';

void main() {
  group('AuthResponse', () {
    test('round-trip fromJson/toJson', () {
      final json = {'token': 'abc', 'token_type': 'bearer', 'expires_in': 3600};
      final obj = AuthResponse.fromJson(json);
      expect(obj.token, 'abc');
      expect(obj.tokenType, 'bearer');
      expect(obj.expiresIn, 3600);
      expect(AuthResponse.fromJson(obj.toJson()), obj);
    });
  });

  group('LoginRequest', () {
    test('round-trip', () {
      final obj = LoginRequest(email: 'a@b.com', password: 'pw');
      expect(LoginRequest.fromJson(obj.toJson()), obj);
    });
  });

  group('RegisterRequest', () {
    test('round-trip', () {
      final obj = RegisterRequest(name: 'Dan', email: 'a@b.com', password: 'pw');
      expect(RegisterRequest.fromJson(obj.toJson()), obj);
    });
  });

  group('User', () {
    test('fromJson parses snake_case keys', () {
      final json = {'id': 1, 'name': 'Dan', 'created_at': '2026-01-01'};
      final user = User.fromJson(json);
      expect(user.id, 1);
      expect(user.name, 'Dan');
      expect(user.createdAt, '2026-01-01');
      expect(User.fromJson(user.toJson()), user);
    });
  });
}
