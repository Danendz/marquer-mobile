import 'dart:io';

import 'package:flutter_foreground_task/flutter_foreground_task.dart';

import 'timer_task_handler.dart';

void initForegroundService() {
  FlutterForegroundTask.init(
    androidNotificationOptions: AndroidNotificationOptions(
      channelId: 'timer_channel',
      channelName: 'Study Timer',
      channelDescription: 'Shows the current study timer.',
      channelImportance: NotificationChannelImportance.LOW,
      priority: NotificationPriority.LOW,
      onlyAlertOnce: true,
    ),
    iosNotificationOptions: const IOSNotificationOptions(
      showNotification: false,
      playSound: false,
    ),
    foregroundTaskOptions: ForegroundTaskOptions(
      eventAction: ForegroundTaskEventAction.repeat(1000),
      autoRunOnBoot: false,
      allowWakeLock: true,
    ),
  );
}

/// Persists timer state for the background isolate using virtual-start anchoring.
/// virtualStartMs = now - elapsedSeconds * 1000, so the background isolate can
/// compute elapsed = (now - virtualStartMs) ~/ 1000 without needing per-tick updates.
Future<void> saveTimerBgState({
  required String mode,
  required int elapsedSeconds,
  bool paused = false,
  int? targetSeconds,
  String? phase,
  int? phaseElapsedSeconds,
  int? phaseTotalSeconds,
}) async {
  final nowMs = DateTime.now().millisecondsSinceEpoch;
  final virtualStartMs = nowMs - elapsedSeconds * 1000;

  await FlutterForegroundTask.saveData(key: 'bg_mode', value: mode);
  await FlutterForegroundTask.saveData(key: 'bg_paused', value: paused);
  await FlutterForegroundTask.saveData(
    key: 'bg_virtual_start_ms',
    value: virtualStartMs,
  );

  if (targetSeconds != null) {
    await FlutterForegroundTask.saveData(
      key: 'bg_target_s',
      value: targetSeconds,
    );
  }
  if (phase != null) {
    await FlutterForegroundTask.saveData(key: 'bg_phase', value: phase);
  }
  // Snapshot of pure study elapsed (unchanged during pomodoro breaks).
  await FlutterForegroundTask.saveData(key: 'bg_study_elapsed_s', value: elapsedSeconds);
  // Reset one-shot flags so a new/resumed session doesn't inherit stale state.
  await FlutterForegroundTask.saveData(key: 'bg_stop_requested', value: false);
  await FlutterForegroundTask.saveData(key: 'bg_countdown_completed', value: false);
  await FlutterForegroundTask.saveData(key: 'bg_elapsed_snapshot_s', value: 0);
  if (phaseElapsedSeconds != null && phaseTotalSeconds != null) {
    final phaseVirtualStartMs = nowMs - phaseElapsedSeconds * 1000;
    await FlutterForegroundTask.saveData(
      key: 'bg_phase_virtual_start_ms',
      value: phaseVirtualStartMs,
    );
    await FlutterForegroundTask.saveData(
      key: 'bg_phase_total_s',
      value: phaseTotalSeconds,
    );
  }
}

/// Signals the background isolate to stop updating the notification.
Future<void> clearTimerBgState() async {
  await FlutterForegroundTask.saveData(key: 'bg_paused', value: true);
}

Future<void> startTimerForegroundService(String notificationText) async {
  // Android 13+: request POST_NOTIFICATIONS permission if not yet granted.
  final permission = await FlutterForegroundTask.checkNotificationPermission();
  if (permission != NotificationPermission.granted) {
    await FlutterForegroundTask.requestNotificationPermission();
  }

  // SYSTEM_ALERT_WINDOW: required for launchApp() to bring app to foreground.
  if (Platform.isAndroid) {
    if (!await FlutterForegroundTask.canDrawOverlays) {
      await FlutterForegroundTask.openSystemAlertWindowSettings();
    }
  }

  try {
    if (await FlutterForegroundTask.isRunningService) {
      await FlutterForegroundTask.updateService(
        notificationTitle: 'Study Timer',
        notificationText: notificationText,
        notificationButtons: kTimerRunningButtons,
      );
      return;
    }
    await FlutterForegroundTask.startService(
      serviceId: 300,
      notificationTitle: 'Study Timer',
      notificationText: notificationText,
      notificationButtons: kTimerRunningButtons,
      callback: startTimerCallback,
    );
  } catch (_) {
    // Service start failures are non-critical — timer continues in-process.
  }
}

Future<void> stopTimerForegroundService() async {
  try {
    await FlutterForegroundTask.stopService();
  } catch (_) {}
}

Future<void> updateTimerNotification(
  String text, {
  bool paused = false,
}) async {
  try {
    if (await FlutterForegroundTask.isRunningService) {
      await FlutterForegroundTask.updateService(
        notificationTitle: 'Study Timer',
        notificationText: text,
        notificationButtons: paused ? kTimerPausedButtons : kTimerRunningButtons,
      );
    }
  } catch (_) {}
}
