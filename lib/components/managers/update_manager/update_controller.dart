import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:path_provider/path_provider.dart';
import 'package:marquer/api/models/update/check_latest_request.dart';
import 'package:marquer/api/services/update_service.dart';
import 'package:marquer/components/managers/update_manager/update_info.dart';
import 'package:apk_sideload/install_apk.dart';

class UpdateController {
  final UpdateService _updateService = UpdateService();
  final Dio _dio = Dio();

  Future<UpdateInfo?> checkForUpdate() async {
    if (kDebugMode) return null;

    try {
      final appInfo = await PackageInfo.fromPlatform();
      final currentVersion = appInfo.version;

      final apiLatest = await _updateService.checkLatest(
        CheckLatestRequest(platform: 'android', channel: 'stable'),
      );

      if (apiLatest.version != currentVersion) {
        return UpdateInfo(
          downloadUrl: apiLatest.downloadUrl,
          changelog: apiLatest.changelog,
          versionFull: apiLatest.versionFull,
        );
      }
    } catch (e) {
      debugPrint('Update check failed: $e');
    }
    return null;
  }

  Future<String?> downloadApk(
      String url, {
        required ValueNotifier<double> progressNotifier,
      }) async {
    try {
      final dir = await getTemporaryDirectory();
      final savePath = '${dir.path}/app_update.apk';

      final file = File(savePath);
      if (await file.exists()) await file.delete();

      await _dio.download(
        url,
        savePath,
        deleteOnError: true,
        onReceiveProgress: (received, total) {
          if (total > 0) {
            progressNotifier.value = received / total;
          }
        },
      );
      return savePath;
    } catch (e) {
      debugPrint('Download failed: $e');
      return null;
    }
  }

  Future<void> installApk(String filePath) async {
    if (await File(filePath).exists()) {
      await InstallApk().installApk(filePath);
    }
  }
}
