import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mocktail/mocktail.dart';
import 'package:marquer/api/models/api_response.dart';
import 'package:marquer/api/models/profile/user_profile.dart';
import 'package:marquer/api/models/profile/upsert_profile_request.dart';
import 'package:marquer/providers/profile/profile_provider.dart';

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

  void stubGetProfile(Map<String, dynamic> json) {
    when(
      () => mockApi.get<UserProfile>(
        '/profile',
        fromJsonT: any(named: 'fromJsonT'),
      ),
    ).thenAnswer((inv) async {
      final fromJsonT =
          inv.namedArguments[#fromJsonT] as UserProfile Function(Object?);
      return ApiResponse<UserProfile>(
        status: 200,
        success: true,
        message: 'OK',
        data: fromJsonT(json),
      );
    });
  }

  void stubUpsertProfile(Map<String, dynamic> responseJson) {
    when(
      () => mockApi.put<UserProfile>(
        '/profile',
        body: any(named: 'body'),
        fromJsonT: any(named: 'fromJsonT'),
      ),
    ).thenAnswer((inv) async {
      final fromJsonT =
          inv.namedArguments[#fromJsonT] as UserProfile Function(Object?);
      return ApiResponse<UserProfile>(
        status: 200,
        success: true,
        message: 'OK',
        data: fromJsonT(responseJson),
      );
    });
  }

  group('profileProvider', () {
    test('build fetches profile from API', () async {
      stubGetProfile({
        'username': 'john_doe',
        'status': 'Working',
        'location': 'SF',
        'bio': 'Hello',
        'avatar_url': null,
        'cover_url': null,
        'cover_type': 'static',
      });

      final container = createTestContainer();
      final profile = await container.read(profileProvider.future);

      expect(profile.username, 'john_doe');
      expect(profile.status, 'Working');
      expect(profile.coverType, 'static');
    });

    test('updateProfile applies server response', () async {
      stubGetProfile({
        'username': 'old_user',
        'status': null,
        'cover_type': 'static',
      });
      stubUpsertProfile({
        'username': 'new_user',
        'status': 'Updated',
        'cover_type': 'static',
      });

      final container = createTestContainer();
      await container.read(profileProvider.future);

      await container.read(profileProvider.notifier).updateProfile(
            const UpsertProfileRequest(username: 'new_user', status: 'Updated'),
          );

      final updated = container.read(profileProvider).value!;
      expect(updated.username, 'new_user');
      expect(updated.status, 'Updated');
    });

    test('setStaticCover sets coverType and clears coverUrl', () async {
      stubGetProfile({
        'username': 'user1',
        'cover_url': 'https://example.com/custom.jpg',
        'cover_type': 'custom',
      });
      stubUpsertProfile({
        'username': 'user1',
        'cover_url': null,
        'cover_type': 'static',
      });

      final container = createTestContainer();
      await container.read(profileProvider.future);

      await container
          .read(profileProvider.notifier)
          .setStaticCover('bg_warm_01');

      final updated = container.read(profileProvider).value!;
      expect(updated.coverType, 'static');
      expect(updated.coverUrl, isNull);
    });
  });
}
