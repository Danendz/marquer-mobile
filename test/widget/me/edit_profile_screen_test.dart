import 'package:flutter/material.dart';
import 'package:flutter_riverpod/misc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:marquer/api/models/auth/user.dart';
import 'package:marquer/api/models/profile/user_profile.dart';
import 'package:marquer/providers/auth/auth_provider.dart';
import 'package:marquer/providers/profile/profile_provider.dart';
import 'package:marquer/screens/me/edit_profile_screen.dart';

import '../../helpers/mock_router.dart';
import '../../helpers/test_setup.dart';

class _FakeAuthNotifier extends AuthNotifier {
  @override
  AuthState build() => AuthState(
        status: AuthStatus.authenticated,
        token: 'test-token',
        user: const User(
          id: 1,
          name: 'Test User',
          createdAt: '2026-01-15T10:00:00Z',
        ),
      );

  @override
  Future<void> loadFromStorage() async {}
}

class _LoadedProfileNotifier extends ProfileNotifier {
  @override
  Future<UserProfile> build() async => const UserProfile(
        username: 'test_user',
        status: 'Building stuff',
        location: 'San Francisco',
        bio: 'Developer and coffee lover',
        coverType: 'static',
      );
}

void main() {
  setUp(() async {
    await setUpTestEnvironment();
  });

  tearDown(() => GetIt.instance.reset());

  List<Override> overrides() => [
        authProvider.overrideWith(() => _FakeAuthNotifier()),
        profileProvider.overrideWith(() => _LoadedProfileNotifier()),
      ];

  group('EditProfileScreen', () {
    testWidgets('renders Edit Profile app bar with Save button',
        (tester) async {
      await pumpWithRouter(tester, const EditProfileScreen(),
          overrides: overrides());
      await tester.pumpAndSettle();

      expect(find.text('Edit Profile'), findsOneWidget);
      expect(find.text('Save'), findsOneWidget);
    });

    testWidgets('pre-fills name from auth and renders form fields',
        (tester) async {
      await pumpWithRouter(tester, const EditProfileScreen(),
          overrides: overrides());
      await tester.pumpAndSettle();

      // Name is pre-filled from authProvider (synchronous)
      final fields = tester.widgetList<TextFormField>(
        find.byType(TextFormField),
      );
      expect(fields.first.controller?.text, 'Test User');

      // At least 4 visible form fields (Bio may be below fold)
      expect(find.byType(TextFormField), findsAtLeast(4));

      // Labels are visible
      expect(find.text('Name'), findsOneWidget);
      expect(find.text('Username'), findsOneWidget);
      expect(find.text('Status'), findsOneWidget);
      expect(find.text('Location'), findsOneWidget);
    });

    testWidgets('name validates non-empty', (tester) async {
      await pumpWithRouter(tester, const EditProfileScreen(),
          overrides: overrides());
      await tester.pumpAndSettle();

      // Fields order: 0=Name, 1=Username, 2=Status, 3=Location, 4=Bio
      final nameField = find.byType(TextFormField).at(0);
      await tester.enterText(nameField, '');
      await tester.pumpAndSettle();

      await tester.tap(find.text('Save'));
      await tester.pumpAndSettle();

      expect(find.text('Name is required'), findsOneWidget);
    });

    testWidgets('username validates min 3 chars', (tester) async {
      await pumpWithRouter(tester, const EditProfileScreen(),
          overrides: overrides());
      await tester.pumpAndSettle();

      // Fields order: 0=Name, 1=Username, 2=Status, 3=Location, 4=Bio
      final usernameField = find.byType(TextFormField).at(1);
      await tester.enterText(usernameField, 'ab');
      await tester.pumpAndSettle();

      await tester.tap(find.text('Save'));
      await tester.pumpAndSettle();

      expect(find.text('At least 3 characters'), findsOneWidget);
    });

    testWidgets('username validates alphanumeric + underscore', (tester) async {
      await pumpWithRouter(tester, const EditProfileScreen(),
          overrides: overrides());
      await tester.pumpAndSettle();

      final usernameField = find.byType(TextFormField).at(1);
      await tester.enterText(usernameField, 'bad@name');
      await tester.pumpAndSettle();

      await tester.tap(find.text('Save'));
      await tester.pumpAndSettle();

      expect(
          find.text('Only letters, numbers, and underscores'), findsOneWidget);
    });

    testWidgets('renders camera icon on avatar', (tester) async {
      await pumpWithRouter(tester, const EditProfileScreen(),
          overrides: overrides());
      await tester.pumpAndSettle();

      expect(find.byIcon(Icons.camera_alt), findsOneWidget);
    });

    testWidgets('renders Change Cover button', (tester) async {
      await pumpWithRouter(tester, const EditProfileScreen(),
          overrides: overrides());
      await tester.pumpAndSettle();

      expect(find.text('Change Cover'), findsOneWidget);
    });
  });
}
