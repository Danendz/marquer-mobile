import 'package:flutter_foreground_task/flutter_foreground_task.dart';

// Top-level so it's accessible from both main and background isolates.
String _fmtTime(int seconds) {
  final h = seconds ~/ 3600;
  final m = (seconds % 3600) ~/ 60;
  final s = seconds % 60;
  if (h > 0) {
    return '${h.toString().padLeft(2, '0')}:${m.toString().padLeft(2, '0')}:${s.toString().padLeft(2, '0')}';
  }
  return '${m.toString().padLeft(2, '0')}:${s.toString().padLeft(2, '0')}';
}

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

@pragma('vm:entry-point')
void startTimerCallback() {
  FlutterForegroundTask.setTaskHandler(TimerTaskHandler());
}

class TimerTaskHandler extends TaskHandler {
  @override
  Future<void> onStart(DateTime timestamp, TaskStarter starter) async {}

  @override
  void onRepeatEvent(DateTime timestamp) async {
    final paused =
        await FlutterForegroundTask.getData<bool>(key: 'bg_paused') ?? true;
    if (paused) return;

    final mode =
        await FlutterForegroundTask.getData<String>(key: 'bg_mode') ??
        'countUp';
    final nowMs = DateTime.now().millisecondsSinceEpoch;

    String text;

    if (mode == 'countDown') {
      final virtualStartMs =
          await FlutterForegroundTask.getData<int>(
            key: 'bg_virtual_start_ms',
          ) ??
          nowMs;
      final targetS =
          await FlutterForegroundTask.getData<int>(key: 'bg_target_s') ?? 0;
      final elapsed = (nowMs - virtualStartMs) ~/ 1000;
      final remaining = (targetS - elapsed).clamp(0, targetS);
      text = 'Time remaining: ${_fmtTime(remaining)}';
    } else if (mode == 'pomodoro') {
      final phase =
          await FlutterForegroundTask.getData<String>(key: 'bg_phase') ??
          'work';
      final phaseVirtualStartMs =
          await FlutterForegroundTask.getData<int>(
            key: 'bg_phase_virtual_start_ms',
          ) ??
          nowMs;
      final phaseTotalS =
          await FlutterForegroundTask.getData<int>(key: 'bg_phase_total_s') ??
          1500;
      final phaseElapsed = (nowMs - phaseVirtualStartMs) ~/ 1000;
      final remaining = (phaseTotalS - phaseElapsed).clamp(0, phaseTotalS);
      switch (phase) {
        case 'work':
          text = 'Work \u2014 ${_fmtTime(remaining)} remaining';
          break;
        case 'shortBreak':
          text = 'Short Break \u2014 ${_fmtTime(remaining)}';
          break;
        case 'longBreak':
          text = 'Long Break \u2014 ${_fmtTime(remaining)}';
          break;
        default:
          text = 'Studying';
      }
    } else {
      // countUp
      final virtualStartMs =
          await FlutterForegroundTask.getData<int>(
            key: 'bg_virtual_start_ms',
          ) ??
          nowMs;
      final elapsed = (nowMs - virtualStartMs) ~/ 1000;
      text = 'Studying: ${_fmtTime(elapsed)}';
    }

    FlutterForegroundTask.updateService(
      notificationTitle: 'Study Timer',
      notificationText: text,
    );
  }

  @override
  Future<void> onDestroy(DateTime timestamp) async {}

  @override
  void onNotificationPressed() {
    FlutterForegroundTask.launchApp('/study/active');
  }
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

  try {
    if (await FlutterForegroundTask.isRunningService) {
      await FlutterForegroundTask.updateService(
        notificationTitle: 'Study Timer',
        notificationText: notificationText,
      );
      return;
    }
    await FlutterForegroundTask.startService(
      serviceId: 300,
      notificationTitle: 'Study Timer',
      notificationText: notificationText,
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

Future<void> updateTimerNotification(String text) async {
  try {
    if (await FlutterForegroundTask.isRunningService) {
      await FlutterForegroundTask.updateService(
        notificationTitle: 'Study Timer',
        notificationText: text,
      );
    }
  } catch (_) {}
}
