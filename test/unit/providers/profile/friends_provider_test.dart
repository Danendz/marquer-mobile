import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mocktail/mocktail.dart';
import 'package:marquer/api/models/api_response.dart';
import 'package:marquer/api/models/profile/friendship.dart';
import 'package:marquer/providers/profile/friends_provider.dart';

import '../../../helpers/mock_api_service.dart';
import '../../../helpers/riverpod_helpers.dart';
import '../../../helpers/test_setup.dart';

void main() {
  late MockApiService mockApi;

  setUp(() async {
    final env = await setUpTestEnvironment();
    mockApi = env.api;
  });

  tearDown(() => GetIt.instance.reset());

  void stubGetFriends(List<Map<String, dynamic>> friends) {
    when(
      () => mockApi.get<List<Friend>>(
        '/friends',
        fromJsonT: any(named: 'fromJsonT'),
      ),
    ).thenAnswer((inv) async {
      final fromJsonT =
          inv.namedArguments[#fromJsonT] as List<Friend> Function(Object?);
      return ApiResponse<List<Friend>>(
        status: 200,
        success: true,
        message: 'OK',
        data: fromJsonT(friends),
      );
    });
  }

  void stubGetPendingRequests(List<Map<String, dynamic>> requests) {
    when(
      () => mockApi.get<List<FriendRequest>>(
        '/friends/requests',
        fromJsonT: any(named: 'fromJsonT'),
      ),
    ).thenAnswer((inv) async {
      final fromJsonT = inv.namedArguments[#fromJsonT]
          as List<FriendRequest> Function(Object?);
      return ApiResponse<List<FriendRequest>>(
        status: 200,
        success: true,
        message: 'OK',
        data: fromJsonT(requests),
      );
    });
  }

  void stubDeleteFriend(int friendUserId) {
    when(() => mockApi.delete('/friends/$friendUserId')).thenAnswer(
      (_) async => ApiResponse<Null>(
        status: 200,
        success: true,
        message: 'Deleted',
        data: null,
      ),
    );
  }

  void stubRespondToRequest(int requestId) {
    when(
      () => mockApi.put<Map<String, dynamic>>(
        '/friends/request/$requestId',
        body: any(named: 'body'),
        fromJsonT: any(named: 'fromJsonT'),
      ),
    ).thenAnswer((inv) async {
      final fromJsonT = inv.namedArguments[#fromJsonT]
          as Map<String, dynamic> Function(Object?);
      return ApiResponse<Map<String, dynamic>>(
        status: 200,
        success: true,
        message: 'OK',
        data: fromJsonT(<String, dynamic>{}),
      );
    });
  }

  group('friendsProvider', () {
    test('build fetches friends list', () async {
      stubGetFriends([
        {'user_id': 2, 'username': 'alice'},
        {'user_id': 3, 'username': 'bob'},
      ]);

      final container = createTestContainer();
      final friends = await container.read(friendsProvider.future);

      expect(friends, hasLength(2));
      expect(friends[0].username, 'alice');
    });

    test('removeFriend optimistically removes from list', () async {
      stubGetFriends([
        {'user_id': 2, 'username': 'alice'},
        {'user_id': 3, 'username': 'bob'},
      ]);
      stubDeleteFriend(2);

      final container = createTestContainer();
      await container.read(friendsProvider.future);
      expect(container.read(friendsProvider).value, hasLength(2));

      await container.read(friendsProvider.notifier).removeFriend(2);

      expect(container.read(friendsProvider).value, hasLength(1));
      expect(container.read(friendsProvider).value![0].username, 'bob');
    });
  });

  group('pendingRequestsProvider', () {
    test('build fetches requests', () async {
      // Need friends stub too since providers may be read together
      stubGetFriends([]);
      stubGetPendingRequests([
        {'id': 10, 'user_id': 4, 'username': 'charlie'},
        {'id': 11, 'user_id': 5, 'username': 'diana'},
      ]);

      final container = createTestContainer();
      final requests = await container.read(pendingRequestsProvider.future);

      expect(requests, hasLength(2));
      expect(requests[0].username, 'charlie');
    });

    test('accept removes from list', () async {
      stubGetFriends([]);
      stubGetPendingRequests([
        {'id': 10, 'user_id': 4, 'username': 'charlie'},
        {'id': 11, 'user_id': 5, 'username': 'diana'},
      ]);
      stubRespondToRequest(10);

      final container = createTestContainer();
      await container.read(pendingRequestsProvider.future);
      expect(container.read(pendingRequestsProvider).value, hasLength(2));

      await container.read(pendingRequestsProvider.notifier).accept(10);

      expect(container.read(pendingRequestsProvider).value, hasLength(1));
      expect(
          container.read(pendingRequestsProvider).value![0].username, 'diana');
    });

    test('reject removes from list', () async {
      stubGetFriends([]);
      stubGetPendingRequests([
        {'id': 10, 'user_id': 4, 'username': 'charlie'},
        {'id': 11, 'user_id': 5, 'username': 'diana'},
      ]);
      stubRespondToRequest(11);

      final container = createTestContainer();
      await container.read(pendingRequestsProvider.future);

      await container.read(pendingRequestsProvider.notifier).reject(11);

      expect(container.read(pendingRequestsProvider).value, hasLength(1));
      expect(container.read(pendingRequestsProvider).value![0].username,
          'charlie');
    });
  });
}
