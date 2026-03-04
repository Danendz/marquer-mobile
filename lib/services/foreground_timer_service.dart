import 'dart:io';

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

const _kRunningButtons = [
  NotificationButton(id: 'btn_pause', text: 'Pause'),
  NotificationButton(id: 'btn_stop', text: 'Stop'),
];

const _kPausedButtons = [
  NotificationButton(id: 'btn_resume', text: 'Resume'),
  NotificationButton(id: 'btn_stop', text: 'Stop'),
];

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
      if (remaining <= 0) {
        await FlutterForegroundTask.updateService(
          notificationTitle: 'Study Timer',
          notificationText: 'Session complete!',
          notificationButtons: [],
        );
        await FlutterForegroundTask.saveData(key: 'bg_paused', value: true);
        await FlutterForegroundTask.saveData(key: 'bg_countdown_completed', value: true);
        await FlutterForegroundTask.saveData(key: 'bg_elapsed_snapshot_s', value: targetS);
        FlutterForegroundTask.sendDataToMain({'action': 'countdown_complete', 'elapsed': targetS});
        return;
      }
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
      notificationButtons: _kRunningButtons,
    );
  }

  @override
  Future<void> onDestroy(DateTime timestamp) async {}

  @override
  void onNotificationButtonPressed(String id) {
    _handleButtonPress(id);
  }

  Future<void> _handleButtonPress(String id) async {
    if (id == 'btn_pause') {
      final nowMs = DateTime.now().millisecondsSinceEpoch;
      final mode =
          await FlutterForegroundTask.getData<String>(key: 'bg_mode') ??
          'countUp';
      final bgPhase =
          await FlutterForegroundTask.getData<String>(key: 'bg_phase');
      final isInBreak = mode == 'pomodoro' &&
          (bgPhase == 'shortBreak' || bgPhase == 'longBreak');
      int elapsed;
      if (isInBreak) {
        elapsed =
            await FlutterForegroundTask.getData<int>(
              key: 'bg_study_elapsed_s',
            ) ??
            0;
      } else {
        final virtualStartMs =
            await FlutterForegroundTask.getData<int>(
              key: 'bg_virtual_start_ms',
            ) ??
            nowMs;
        elapsed = (nowMs - virtualStartMs) ~/ 1000;
      }
      await FlutterForegroundTask.saveData(
        key: 'bg_elapsed_snapshot_s',
        value: elapsed,
      );
      await FlutterForegroundTask.saveData(key: 'bg_paused', value: true);
      await FlutterForegroundTask.updateService(
        notificationTitle: 'Study Timer',
        notificationText: 'Paused \u2014 ${_fmtTime(elapsed)}',
        notificationButtons: _kPausedButtons,
      );
      FlutterForegroundTask.sendDataToMain({'action': 'pause', 'elapsed': elapsed});
    } else if (id == 'btn_resume') {
      final snapshot =
          await FlutterForegroundTask.getData<int>(
            key: 'bg_elapsed_snapshot_s',
          ) ??
          0;
      final nowMs = DateTime.now().millisecondsSinceEpoch;
      final newVirtualStartMs = nowMs - snapshot * 1000;
      await FlutterForegroundTask.saveData(
        key: 'bg_virtual_start_ms',
        value: newVirtualStartMs,
      );
      await FlutterForegroundTask.saveData(key: 'bg_paused', value: false);
      await FlutterForegroundTask.updateService(
        notificationTitle: 'Study Timer',
        notificationText: 'Studying: ${_fmtTime(snapshot)}',
        notificationButtons: _kRunningButtons,
      );
      FlutterForegroundTask.sendDataToMain({'action': 'resume', 'elapsed': snapshot});
    } else if (id == 'btn_stop') {
      final nowMs = DateTime.now().millisecondsSinceEpoch;
      final alreadyPaused =
          await FlutterForegroundTask.getData<bool>(key: 'bg_paused') ?? false;
      int elapsed;
      if (alreadyPaused) {
        elapsed =
            await FlutterForegroundTask.getData<int>(
              key: 'bg_elapsed_snapshot_s',
            ) ??
            0;
      } else {
        final mode =
            await FlutterForegroundTask.getData<String>(key: 'bg_mode') ??
            'countUp';
        final bgPhase =
            await FlutterForegroundTask.getData<String>(key: 'bg_phase');
        final isInBreak = mode == 'pomodoro' &&
            (bgPhase == 'shortBreak' || bgPhase == 'longBreak');
        if (isInBreak) {
          elapsed =
              await FlutterForegroundTask.getData<int>(
                key: 'bg_study_elapsed_s',
              ) ??
              0;
        } else {
          final virtualStartMs =
              await FlutterForegroundTask.getData<int>(
                key: 'bg_virtual_start_ms',
              ) ??
              nowMs;
          elapsed = (nowMs - virtualStartMs) ~/ 1000;
        }
        await FlutterForegroundTask.saveData(
          key: 'bg_elapsed_snapshot_s',
          value: elapsed,
        );
      }
      await FlutterForegroundTask.saveData(
        key: 'bg_stop_requested',
        value: true,
      );
      await FlutterForegroundTask.saveData(key: 'bg_paused', value: true);
      await FlutterForegroundTask.updateService(
        notificationTitle: 'Study Timer',
        notificationText: 'Stopping...',
      );
      FlutterForegroundTask.sendDataToMain({'action': 'stop', 'elapsed': elapsed});
      FlutterForegroundTask.launchApp('/study/active');
    }
  }

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
        notificationButtons: _kRunningButtons,
      );
      return;
    }
    await FlutterForegroundTask.startService(
      serviceId: 300,
      notificationTitle: 'Study Timer',
      notificationText: notificationText,
      notificationButtons: _kRunningButtons,
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
        notificationButtons: paused ? _kPausedButtons : _kRunningButtons,
      );
    }
  } catch (_) {}
}
