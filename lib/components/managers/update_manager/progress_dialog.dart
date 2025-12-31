import 'package:flutter/material.dart';

class DownloadProgressDialog extends StatelessWidget {
  const DownloadProgressDialog({super.key, required this.progressNotifier});

  final ValueNotifier<double> progressNotifier;

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: AlertDialog(
        title: const Text('Downloading update...'),
        content: ValueListenableBuilder<double>(
          valueListenable: progressNotifier,
          builder: (context, progress, child) {
            final percentage = (progress * 100).toStringAsFixed(0);
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                LinearProgressIndicator(value: progress),
                const SizedBox(height: 12),
                Text('$percentage%'),
              ],
            );
          },
        ),
      ),
    );
  }
}
