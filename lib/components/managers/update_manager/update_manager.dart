import 'package:flutter/material.dart';
import 'package:marquer/components/managers/update_manager/update_controller.dart';
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

    final downloadUrl = await _controller.checkForUpdate();
    _isChecking = false;

    if (downloadUrl == null) return;

    final context = widget.rootNavKey.currentContext;
    if (context == null || !context.mounted) return;

    final shouldUpdate = await showDialog<bool>(
      context: context,
      barrierDismissible: true,
      builder: (ctx) => AlertDialog(
        title: const Text('Update available'),
        content: const Text('A new version is available. Download now?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: const Text('Later'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(ctx, true),
            child: const Text('Update'),
          ),
        ],
      ),
    );

    if (shouldUpdate == true) {
      if (!context.mounted) return;
      _startDownloadFlow(context, downloadUrl);
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
