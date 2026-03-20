import 'package:flutter/material.dart';
import 'package:flutter_riverpod/misc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:marquer/api/models/api_response.dart';
import 'package:marquer/api/models/auth/auth_response.dart';
import 'package:marquer/api/models/auth/register_request.dart';
import 'package:marquer/providers/auth/auth_provider.dart';
import 'package:marquer/screens/auth/register.dart';
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
    registerFallbackValue(RegisterRequest(name: '', email: '', password: ''));
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

  group('RegisterPage', () {
    testWidgets('renders all 4 fields and register button', (tester) async {
      await pumpWithProviders(tester, const RegisterPage(),
          overrides: overrides);
      await tester.pumpAndSettle();

      expect(find.widgetWithText(TextFormField, 'Name'), findsOneWidget);
      expect(find.widgetWithText(TextFormField, 'Email'), findsOneWidget);
      expect(find.widgetWithText(TextFormField, 'Password'), findsOneWidget);
      expect(find.widgetWithText(TextFormField, 'Password confirmation'),
          findsOneWidget);
      expect(
          find.widgetWithText(ElevatedButton, 'Register'), findsOneWidget);
    });

    testWidgets('empty submit shows validation errors for all fields',
        (tester) async {
      await pumpWithProviders(tester, const RegisterPage(),
          overrides: overrides);
      await tester.pumpAndSettle();

      await tester.tap(find.widgetWithText(ElevatedButton, 'Register'));
      await tester.pumpAndSettle();

      expect(find.text('Name is required'), findsOneWidget);
      expect(find.text('Email is required'), findsOneWidget);
      expect(find.text('Password is required'), findsOneWidget);
      expect(find.text('Confirm password'), findsOneWidget);
    });

    testWidgets('password mismatch shows Passwords do not match',
        (tester) async {
      await pumpWithProviders(tester, const RegisterPage(),
          overrides: overrides);
      await tester.pumpAndSettle();

      await tester.enterText(
          find.widgetWithText(TextFormField, 'Name'), 'Test User');
      await tester.enterText(
          find.widgetWithText(TextFormField, 'Email'), 'test@test.com');
      await tester.enterText(
          find.widgetWithText(TextFormField, 'Password'), 'password123');
      await tester.enterText(
          find.widgetWithText(TextFormField, 'Password confirmation'),
          'differentpassword');
      await tester.tap(find.widgetWithText(ElevatedButton, 'Register'));
      await tester.pumpAndSettle();

      expect(find.text('Passwords do not match'), findsOneWidget);
    });

    testWidgets('I already have an account button navigates to /login',
        (tester) async {
      final router = await pumpWithRouter(tester, const RegisterPage(),
          overrides: overrides);
      await tester.pumpAndSettle();

      await tester.tap(
          find.widgetWithText(TextButton, 'I already have an account'));
      await tester.pumpAndSettle();

      verify(() => router.go('/login')).called(1);
    });

    testWidgets('successful register calls authApi.post with /register',
        (tester) async {
      when(() => mockAuthApi.post<AuthResponse>(
            '/register',
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

      await pumpWithProviders(tester, const RegisterPage(),
          overrides: overrides);
      await tester.pumpAndSettle();

      await tester.enterText(
          find.widgetWithText(TextFormField, 'Name'), 'Test User');
      await tester.enterText(
          find.widgetWithText(TextFormField, 'Email'), 'test@test.com');
      await tester.enterText(
          find.widgetWithText(TextFormField, 'Password'), 'password123');
      await tester.enterText(
          find.widgetWithText(TextFormField, 'Password confirmation'),
          'password123');
      await tester.tap(find.widgetWithText(ElevatedButton, 'Register'));
      await tester.pumpAndSettle();

      verify(() => mockAuthApi.post<AuthResponse>(
            '/register',
            body: any(named: 'body'),
            fromJsonT: any(named: 'fromJsonT'),
          )).called(1);
      expect(fakeAuthNotifier.lastToken, 'test-token');
    });
  });
}
