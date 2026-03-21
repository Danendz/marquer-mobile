import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:marquer/api/models/profile/friendship.dart';
import 'package:marquer/api/services/profile_service.dart';
import 'package:marquer/providers/optimistic_mutation.dart';

final friendsProvider =
    AsyncNotifierProvider<FriendsNotifier, List<Friend>>(FriendsNotifier.new);

final pendingRequestsProvider =
    AsyncNotifierProvider<PendingRequestsNotifier, List<FriendRequest>>(
        PendingRequestsNotifier.new);

class FriendsNotifier extends AsyncNotifier<List<Friend>>
    with OptimisticMutation {
  final _service = ProfileService();

  @override
  Future<List<Friend>> build() => _service.getFriends();

  Future<void> removeFriend(int friendUserId) async {
    final current = currentValue;
    if (current == null) return;

    state = AsyncData([
      for (final f in current)
        if (f.userId != friendUserId) f,
    ]);

    await mutate(
      action: () async {
        await _service.removeFriend(friendUserId);
        return null;
      },
      errorMessage: 'Unable to remove friend',
      rollback: () => current,
    );
  }
}

class PendingRequestsNotifier extends AsyncNotifier<List<FriendRequest>>
    with OptimisticMutation {
  final _service = ProfileService();

  @override
  Future<List<FriendRequest>> build() => _service.getPendingRequests();

  Future<void> accept(int requestId) async {
    final current = currentValue;
    if (current == null) return;

    state = AsyncData([for (final r in current) if (r.id != requestId) r]);

    await mutate(
      action: () async {
        await _service.respondToFriendRequest(requestId, 'accept');
        return null;
      },
      errorMessage: 'Unable to accept request',
      rollback: () => current,
    );

    ref.invalidate(friendsProvider);
  }

  Future<void> reject(int requestId) async {
    final current = currentValue;
    if (current == null) return;

    state = AsyncData([for (final r in current) if (r.id != requestId) r]);

    await mutate(
      action: () async {
        await _service.respondToFriendRequest(requestId, 'reject');
        return null;
      },
      errorMessage: 'Unable to reject request',
      rollback: () => current,
    );
  }
}
