import 'package:flutter/material.dart';
import 'package:marquer/components/managers/update_manager/update_controller.dart';
import 'package:marquer/components/managers/update_manager/update_info.dart';
import 'package:marquer/components/managers/update_manager/progress_dialog.dart';

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
  final UpdateController _controller = UpdateController();
  bool _isChecking = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _initCheck());
  }

  Future<void> _initCheck() async {
    if (_isChecking) return;
    _isChecking = true;

    final updateInfo = await _controller.checkForUpdate();
    _isChecking = false;

    if (updateInfo == null) return;

    final context = widget.rootNavKey.currentContext;
    if (context == null || !context.mounted) return;

    final shouldUpdate = await showDialog<bool>(
      context: context,
      barrierDismissible: true,
      builder: (ctx) => _UpdateDialog(updateInfo: updateInfo),
    );

    if (shouldUpdate == true) {
      if (!context.mounted) return;
      _startDownloadFlow(context, updateInfo.downloadUrl);
    }
  }

  Future<void> _startDownloadFlow(BuildContext context, String url) async {
    final progressNotifier = ValueNotifier<double>(0.0);

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => DownloadProgressDialog(progressNotifier: progressNotifier),
    );

    final filePath = await _controller.downloadApk(
      url,
      progressNotifier: progressNotifier,
    );

    if (context.mounted && Navigator.canPop(context)) {
      Navigator.pop(context);
    }

    if (filePath != null) {
      await _controller.installApk(filePath);
    }
  }

  @override
  Widget build(BuildContext context) => widget.child;
}

class _UpdateDialog extends StatelessWidget {
  const _UpdateDialog({required this.updateInfo});

  final UpdateInfo updateInfo;

  @override
  Widget build(BuildContext context) {
    final version = updateInfo.versionFull;
    final changelog = updateInfo.changelog;

    return AlertDialog(
      title: Text(version != null ? 'Update available (v$version)' : 'Update available'),
      content: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            if (changelog != null && changelog.isNotEmpty) ...[
              const Text(
                "What's new:",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Text(changelog),
            ] else
              const Text('A new version is available. Download now?'),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context, false),
          child: const Text('Later'),
        ),
        ElevatedButton(
          onPressed: () => Navigator.pop(context, true),
          child: const Text('Update'),
        ),
      ],
    );
  }
}
