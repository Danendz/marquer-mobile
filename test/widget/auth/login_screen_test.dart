import 'package:flutter/material.dart';
import 'package:flutter_riverpod/misc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:marquer/api/models/api_response.dart';
import 'package:marquer/api/models/auth/auth_response.dart';
import 'package:marquer/api/models/auth/login_request.dart';
import 'package:marquer/providers/auth/auth_provider.dart';
import 'package:marquer/screens/auth/login.dart';
import 'package:mocktail/mocktail.dart';

import '../../helpers/mock_api_service.dart';
import '../../helpers/mock_router.dart';
import '../../helpers/riverpod_helpers.dart';
import '../../helpers/test_setup.dart';

class FakeAuthNotifier extends AuthNotifier {
  String? lastToken;

  @override
  Future<void> setToken(String token) async {
    lastToken = token;
    state = AuthState(status: AuthStatus.authenticated, token: token);
  }

  @override
  Future<void> loadFromStorage() async {}
}

void main() {
  late MockApiService mockAuthApi;
  late FakeAuthNotifier fakeAuthNotifier;
  late List<Override> overrides;

  setUpAll(() {
    registerFallbackValue(LoginRequest(email: '', password: ''));
  });

  setUp(() async {
    final env = await setUpTestEnvironment();
    mockAuthApi = env.authApi;
    fakeAuthNotifier = FakeAuthNotifier();
    overrides = [
      authProvider.overrideWith(() => fakeAuthNotifier),
    ];
  });

  tearDown(() async {
    await GetIt.instance.reset();
  });

  group('LoginPage', () {
    testWidgets('renders email field, password field, and login button',
        (tester) async {
      await pumpWithProviders(tester, const LoginPage(), overrides: overrides);
      await tester.pumpAndSettle();

      expect(find.widgetWithText(TextFormField, 'Email'), findsOneWidget);
      expect(find.widgetWithText(TextFormField, 'Password'), findsOneWidget);
      expect(find.widgetWithText(ElevatedButton, 'Login'), findsOneWidget);
    });

    testWidgets(
        'empty submit shows Email is required and Password is required',
        (tester) async {
      await pumpWithProviders(tester, const LoginPage(), overrides: overrides);
      await tester.pumpAndSettle();

      await tester.tap(find.widgetWithText(ElevatedButton, 'Login'));
      await tester.pumpAndSettle();

      expect(find.text('Email is required'), findsOneWidget);
      expect(find.text('Password is required'), findsOneWidget);
    });

    testWidgets('invalid email without @ shows Invalid email', (tester) async {
      await pumpWithProviders(tester, const LoginPage(), overrides: overrides);
      await tester.pumpAndSettle();

      await tester.enterText(
          find.widgetWithText(TextFormField, 'Email'), 'bademail');
      await tester.enterText(
          find.widgetWithText(TextFormField, 'Password'), 'password123');
      await tester.tap(find.widgetWithText(ElevatedButton, 'Login'));
      await tester.pumpAndSettle();

      expect(find.text('Invalid email'), findsOneWidget);
    });

    testWidgets('short password shows Min 6 chars', (tester) async {
      await pumpWithProviders(tester, const LoginPage(), overrides: overrides);
      await tester.pumpAndSettle();

      await tester.enterText(
          find.widgetWithText(TextFormField, 'Email'), 'test@test.com');
      await tester.enterText(
          find.widgetWithText(TextFormField, 'Password'), '12345');
      await tester.tap(find.widgetWithText(ElevatedButton, 'Login'));
      await tester.pumpAndSettle();

      expect(find.text('Min 6 chars'), findsOneWidget);
    });

    testWidgets('Create account button navigates to /register',
        (tester) async {
      final router = await pumpWithRouter(tester, const LoginPage(),
          overrides: overrides);
      await tester.pumpAndSettle();

      await tester.tap(find.widgetWithText(TextButton, 'Create account'));
      await tester.pumpAndSettle();

      verify(() => router.go('/register')).called(1);
    });

    testWidgets('successful login calls authApi.post with /login',
        (tester) async {
      when(() => mockAuthApi.post<AuthResponse>(
            '/login',
            body: any(named: 'body'),
            fromJsonT: any(named: 'fromJsonT'),
          )).thenAnswer((_) async => ApiResponse<AuthResponse>(
            status: 200,
            success: true,
            message: 'OK',
            data: AuthResponse(
              token: 'test-token',
              tokenType: 'bearer',
              expiresIn: 3600,
            ),
          ));

      await pumpWithProviders(tester, const LoginPage(), overrides: overrides);
      await tester.pumpAndSettle();

      await tester.enterText(
          find.widgetWithText(TextFormField, 'Email'), 'test@test.com');
      await tester.enterText(
          find.widgetWithText(TextFormField, 'Password'), 'password123');
      await tester.tap(find.widgetWithText(ElevatedButton, 'Login'));
      await tester.pumpAndSettle();

      verify(() => mockAuthApi.post<AuthResponse>(
            '/login',
            body: any(named: 'body'),
            fromJsonT: any(named: 'fromJsonT'),
          )).called(1);
      expect(fakeAuthNotifier.lastToken, 'test-token');
    });
  });
}
