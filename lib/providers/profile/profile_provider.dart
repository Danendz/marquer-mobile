import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:marquer/api/models/profile/user_profile.dart';
import 'package:marquer/api/models/profile/upsert_profile_request.dart';
import 'package:marquer/api/services/profile_service.dart';
import 'package:marquer/providers/optimistic_mutation.dart';

final profileProvider =
    AsyncNotifierProvider<ProfileNotifier, UserProfile>(ProfileNotifier.new);

class ProfileNotifier extends AsyncNotifier<UserProfile>
    with OptimisticMutation {
  final _service = ProfileService();

  @override
  Future<UserProfile> build() => _service.getProfile();

  Future<void> updateProfile(UpsertProfileRequest request) async {
    final current = currentValue;
    if (current == null) return;

    state = AsyncData(current.copyWith(
      username: request.username ?? current.username,
      status: request.status ?? current.status,
      location: request.location ?? current.location,
      bio: request.bio ?? current.bio,
    ));

    await mutate(
      action: () => _service.upsertProfile(request),
      errorMessage: 'Unable to update profile! Try again later',
      rollback: () => current,
      onSuccess: (_, updated) => updated,
    );
  }
}
