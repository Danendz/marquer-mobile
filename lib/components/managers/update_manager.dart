import 'dart:io';

import 'package:apk_sideload/install_apk.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:marquer/api/models/update/check_latest_request.dart';
import 'package:marquer/api/services/update_service.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:path_provider/path_provider.dart';

class UpdateManager extends StatefulWidget {
  const UpdateManager({
    super.key,
    required this.child,
    required this.rootNavKey,
  });

  final Widget child;
  final GlobalKey<NavigatorState> rootNavKey;

  @override
  State<UpdateManager> createState() => _UpdateManagerState();
}

class _UpdateManagerState extends State<UpdateManager> {
  bool _didRun = false;
  bool _dialogOpen = false;
  double? _downloadProgress;
  StateSetter? _dialogSetState;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_didRun) return;
    _didRun = true;

    WidgetsBinding.instance.addPostFrameCallback((_) => _checkAndPrompt());
  }

  Future<String> getAppVersion() async {
    final info = await PackageInfo.fromPlatform();
    return info.version;
  }

  Future<void> _checkAndPrompt() async {
    final updateService = UpdateService();
    final apiLatest = await updateService.checkLatest(
      CheckLatestRequest(platform: 'android', channel: 'stable'),
    );
    final appVersion = await getAppVersion();

    final updateAvailable = apiLatest.version != appVersion;

    if (!updateAvailable) return;

    final ctx = widget.rootNavKey.currentContext;
    if (ctx == null || _dialogOpen) return;

    _dialogOpen = true;
    final ok = await showDialog<bool>(
      barrierDismissible: true,
      context: ctx,
      builder: (_) => AlertDialog(
        title: const Text('Update available'),
        content: const Text('Download and install the update?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: const Text('Later'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(ctx, true),
            child: const Text('OK'),
          ),
        ],
      ),
    );
    _dialogOpen = false;

    if (ok == true) {
      await _downloadAndInstallApk(apiLatest.downloadUrl); // next section
    }
  }

  Future<void> _downloadAndInstallApk(String apkUrl) async {
    final dir = await getTemporaryDirectory();
    final savePath = '${dir.path}/app_update.apk';

    setState(() {
      _downloadProgress = 0.0;
    });

    final ctx = widget.rootNavKey.currentContext;
    if (ctx != null) {
      _showDownloadDialog();
    }

    try {
      await Dio().download(
        apkUrl,
        savePath,
        deleteOnError: true,
        onReceiveProgress: (received, total) {
          setState(() {
            final p = (total > 0) ? (received / total) : null;

            _downloadProgress = p;

            final ds = _dialogSetState;
            if (ds != null) ds(() {});
          });
        },
      );
    } finally {
      final dialogCtx = widget.rootNavKey.currentContext;
      if (dialogCtx != null && Navigator.of(dialogCtx).canPop()) {
        Navigator.of(dialogCtx).pop();
      }
    }

    if (!File(savePath).existsSync()) return;

    await InstallApk().installApk(savePath);
  }

  Future<void> _showDownloadDialog() async {
    final ctx = widget.rootNavKey.currentContext;
    if (ctx == null) return;

    await showDialog(
      context: ctx,
      barrierDismissible: false,
      builder: (_) {
        return StatefulBuilder(
          builder: (context, setLocalState) {
            _dialogSetState = setLocalState;
            return AlertDialog(
              title: const Text('Downloading update'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  LinearProgressIndicator(value: _downloadProgress),
                  const SizedBox(height: 12),
                  Text(
                    _downloadProgress == null
                        ? 'Downloading...'
                        : '${(_downloadProgress! * 100).toStringAsFixed(0)}%',
                  ),
                ],
              ),
            );
          },
        );
      },
    );

    _dialogSetState = null;
  }

  @override
  Widget build(BuildContext context) => widget.child;
}
