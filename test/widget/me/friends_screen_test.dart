import 'package:flutter/material.dart';
import 'package:flutter_riverpod/misc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:marquer/api/models/profile/friendship.dart';
import 'package:marquer/providers/profile/friends_provider.dart';
import 'package:marquer/screens/me/friends_screen.dart';

import '../../helpers/mock_router.dart';
import '../../helpers/test_setup.dart';

class _LoadedFriendsNotifier extends FriendsNotifier {
  @override
  Future<List<Friend>> build() async => const [
        Friend(userId: 2, username: 'alice', status: 'Online'),
        Friend(userId: 3, username: 'bob'),
      ];
}

class _EmptyFriendsNotifier extends FriendsNotifier {
  @override
  Future<List<Friend>> build() async => [];
}

class _LoadedRequestsNotifier extends PendingRequestsNotifier {
  @override
  Future<List<FriendRequest>> build() async => const [
        FriendRequest(id: 10, userId: 4, username: 'charlie'),
        FriendRequest(id: 11, userId: 5, username: 'diana'),
      ];
}

class _EmptyRequestsNotifier extends PendingRequestsNotifier {
  @override
  Future<List<FriendRequest>> build() async => [];
}

void main() {
  setUp(() async {
    await setUpTestEnvironment();
  });

  tearDown(() => GetIt.instance.reset());

  List<Override> overrides({
    FriendsNotifier? friendsNotifier,
    PendingRequestsNotifier? requestsNotifier,
  }) =>
      [
        friendsProvider
            .overrideWith(() => friendsNotifier ?? _LoadedFriendsNotifier()),
        pendingRequestsProvider
            .overrideWith(() => requestsNotifier ?? _LoadedRequestsNotifier()),
      ];

  group('FriendsScreen', () {
    testWidgets('renders 2 tabs', (tester) async {
      await pumpWithRouter(tester, const FriendsScreen(),
          overrides: overrides());
      await tester.pumpAndSettle();

      expect(find.text('Friends'), findsAtLeast(1));
      expect(find.text('Requests'), findsOneWidget);
    });

    testWidgets('Friends tab shows usernames', (tester) async {
      await pumpWithRouter(tester, const FriendsScreen(),
          overrides: overrides());
      await tester.pumpAndSettle();

      expect(find.text('alice'), findsOneWidget);
      expect(find.text('bob'), findsOneWidget);
    });

    testWidgets('Friends tab empty shows message', (tester) async {
      await pumpWithRouter(tester, const FriendsScreen(),
          overrides: overrides(friendsNotifier: _EmptyFriendsNotifier()));
      await tester.pumpAndSettle();

      expect(find.text('No friends yet'), findsOneWidget);
    });

    testWidgets('Requests tab shows usernames', (tester) async {
      await pumpWithRouter(tester, const FriendsScreen(),
          overrides: overrides());
      await tester.pumpAndSettle();

      // Tap the Requests tab
      await tester.tap(find.text('Requests'));
      await tester.pumpAndSettle();

      expect(find.text('charlie'), findsOneWidget);
      expect(find.text('diana'), findsOneWidget);
    });

    testWidgets('Requests tab empty shows message', (tester) async {
      await pumpWithRouter(tester, const FriendsScreen(),
          overrides: overrides(requestsNotifier: _EmptyRequestsNotifier()));
      await tester.pumpAndSettle();

      await tester.tap(find.text('Requests'));
      await tester.pumpAndSettle();

      expect(find.text('No pending requests'), findsOneWidget);
    });

    testWidgets('Friends tab has remove button', (tester) async {
      await pumpWithRouter(tester, const FriendsScreen(),
          overrides: overrides());
      await tester.pumpAndSettle();

      expect(find.byIcon(Icons.person_remove), findsNWidgets(2));
    });

    testWidgets('Requests tab has accept and reject icons', (tester) async {
      await pumpWithRouter(tester, const FriendsScreen(),
          overrides: overrides());
      await tester.pumpAndSettle();

      await tester.tap(find.text('Requests'));
      await tester.pumpAndSettle();

      expect(find.byIcon(Icons.check), findsNWidgets(2));
      expect(find.byIcon(Icons.close), findsNWidgets(2));
    });
  });
}
