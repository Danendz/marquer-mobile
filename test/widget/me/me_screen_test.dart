import 'package:flutter_riverpod/misc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:marquer/api/models/auth/user.dart';
import 'package:marquer/api/models/profile/user_profile.dart';
import 'package:marquer/providers/auth/auth_provider.dart';
import 'package:marquer/providers/profile/profile_provider.dart';
import 'package:marquer/screens/me/me_screen.dart';
import 'package:mocktail/mocktail.dart';

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
        status: 'Building cool stuff',
        location: 'San Francisco',
        bio: 'Developer',
        coverType: 'static',
      );
}

class _NoStatusProfileNotifier extends ProfileNotifier {
  @override
  Future<UserProfile> build() async => const UserProfile(
        username: 'test_user',
        coverType: 'static',
      );
}

void main() {
  setUp(() async {
    await setUpTestEnvironment();
  });

  tearDown(() => GetIt.instance.reset());

  List<Override> overrides({ProfileNotifier? profileNotifier}) => [
        authProvider.overrideWith(() => _FakeAuthNotifier()),
        profileProvider
            .overrideWith(() => profileNotifier ?? _LoadedProfileNotifier()),
      ];

  group('MeScreen', () {
    testWidgets('renders section tiles', (tester) async {
      await pumpWithRouter(tester, const MeScreen(),
          overrides: overrides());
      await tester.pumpAndSettle();

      expect(find.text('FRIENDS'), findsOneWidget);
      expect(find.text('COLLECTIONS'), findsOneWidget);
      expect(find.text('ACHIEVEMENTS'), findsOneWidget);
      expect(find.text('SETTINGS'), findsOneWidget);
      expect(find.text('LABORATORY'), findsOneWidget);
    });

    testWidgets('renders user name from auth', (tester) async {
      await pumpWithRouter(tester, const MeScreen(),
          overrides: overrides());
      await tester.pumpAndSettle();

      expect(find.text('Test User'), findsOneWidget);
    });

    testWidgets('renders status badge when profile has status', (tester) async {
      await pumpWithRouter(tester, const MeScreen(),
          overrides: overrides());
      await tester.pumpAndSettle();

      expect(find.text('Building cool stuff'), findsOneWidget);
    });

    testWidgets('renders + Status when no status', (tester) async {
      await pumpWithRouter(tester, const MeScreen(),
          overrides: overrides(profileNotifier: _NoStatusProfileNotifier()));
      await tester.pumpAndSettle();

      expect(find.text('+ Status'), findsOneWidget);
    });

    testWidgets('renders logout button', (tester) async {
      await pumpWithRouter(tester, const MeScreen(),
          overrides: overrides());
      await tester.pumpAndSettle();

      expect(find.text('Logout'), findsOneWidget);
    });

    testWidgets('renders location and join date', (tester) async {
      await pumpWithRouter(tester, const MeScreen(),
          overrides: overrides());
      await tester.pumpAndSettle();

      // Location + join date are joined with middot
      expect(find.textContaining('San Francisco'), findsOneWidget);
      expect(find.textContaining('Joined Jan 2026'), findsOneWidget);
    });

    testWidgets('Friends tile taps navigate', (tester) async {
      final router = await pumpWithRouter(tester, const MeScreen(),
          overrides: overrides());
      await tester.pumpAndSettle();

      await tester.tap(find.text('FRIENDS'));
      await tester.pumpAndSettle();

      verify(() => router.push('/me/friends')).called(1);
    });

    testWidgets('edit profile card taps navigate', (tester) async {
      final router = await pumpWithRouter(tester, const MeScreen(),
          overrides: overrides());
      await tester.pumpAndSettle();

      // Tap on the InkWell card with the user info
      await tester.tap(find.text('Test User'));
      await tester.pumpAndSettle();

      verify(() => router.push('/me/edit-profile')).called(1);
    });
  });
}
