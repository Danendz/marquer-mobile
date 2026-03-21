import 'dart:io';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
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

  Future<void> uploadAvatar(File file) async {
    final current = currentValue;
    if (current == null) return;

    await mutate(
      action: () async {
        final bytes = await _compressImage(file.path, 512, 512);
        final contentType = file.path.endsWith('.png') ? 'image/png' : 'image/jpeg';
        final urlResp = await _service.getAvatarUploadUrl(contentType);
        await _putToS3(urlResp.uploadUrl, bytes, contentType);
        return _service.upsertProfile(
          UpsertProfileRequest(avatarUrl: urlResp.publicUrl),
        );
      },
      errorMessage: 'Unable to upload avatar! Try again later',
      rollback: () => current,
      onSuccess: (_, updated) => updated,
    );
  }

  Future<void> uploadCover(File file) async {
    final current = currentValue;
    if (current == null) return;

    await mutate(
      action: () async {
        final bytes = await _compressImage(file.path, 1200, 600);
        final contentType = file.path.endsWith('.png') ? 'image/png' : 'image/jpeg';
        final urlResp = await _service.getCoverUploadUrl(contentType);
        await _putToS3(urlResp.uploadUrl, bytes, contentType);
        return _service.upsertProfile(
          UpsertProfileRequest(
            coverUrl: urlResp.publicUrl,
            coverType: 'custom',
          ),
        );
      },
      errorMessage: 'Unable to upload cover! Try again later',
      rollback: () => current,
      onSuccess: (_, updated) => updated,
    );
  }

  Future<void> setStaticCover(String assetName) async {
    final current = currentValue;
    if (current == null) return;

    state = AsyncData(current.copyWith(
      coverUrl: null,
      coverType: 'static',
    ));

    await mutate(
      action: () => _service.upsertProfile(
        UpsertProfileRequest(coverUrl: null, coverType: 'static'),
      ),
      errorMessage: 'Unable to update cover! Try again later',
      rollback: () => current,
      onSuccess: (_, updated) => updated,
    );
  }

  Future<Uint8List> _compressImage(String path, int width, int height) async {
    final result = await FlutterImageCompress.compressWithFile(
      path,
      minWidth: width,
      minHeight: height,
      quality: 85,
    );
    return result ?? await File(path).readAsBytes();
  }

  Future<void> _putToS3(String url, Uint8List bytes, String contentType) async {
    final dio = Dio();
    await dio.put(
      url,
      data: Stream.fromIterable([bytes]),
      options: Options(
        headers: {
          'Content-Type': contentType,
          'Content-Length': bytes.length,
        },
      ),
    );
  }
}
