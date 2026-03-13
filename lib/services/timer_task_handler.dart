import 'package:flutter_foreground_task/flutter_foreground_task.dart';

// Top-level so it's accessible from both main and background isolates.
String fmtTimerTime(int seconds) {
  final h = seconds ~/ 3600;
  final m = (seconds % 3600) ~/ 60;
  final s = seconds % 60;
  if (h > 0) {
    return '${h.toString().padLeft(2, '0')}:${m.toString().padLeft(2, '0')}:${s.toString().padLeft(2, '0')}';
  }
  return '${m.toString().padLeft(2, '0')}:${s.toString().padLeft(2, '0')}';
}

const kTimerRunningButtons = [
  NotificationButton(id: 'btn_pause', text: 'Pause'),
  NotificationButton(id: 'btn_stop', text: 'Stop'),
];

const kTimerPausedButtons = [
  NotificationButton(id: 'btn_resume', text: 'Resume'),
  NotificationButton(id: 'btn_stop', text: 'Stop'),
];

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
        FlutterForegroundTask.launchApp('/study/active');
        return;
      }
      text = 'Time remaining: ${fmtTimerTime(remaining)}';
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
          text = 'Work \u2014 ${fmtTimerTime(remaining)} remaining';
          break;
        case 'shortBreak':
          text = 'Short Break \u2014 ${fmtTimerTime(remaining)}';
          break;
        case 'longBreak':
          text = 'Long Break \u2014 ${fmtTimerTime(remaining)}';
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
      text = 'Studying: ${fmtTimerTime(elapsed)}';
    }

    FlutterForegroundTask.updateService(
      notificationTitle: 'Study Timer',
      notificationText: text,
      notificationButtons: kTimerRunningButtons,
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
      // Save phase snapshot so btn_resume can re-anchor bg_phase_virtual_start_ms.
      if (mode == 'pomodoro') {
        final phaseVirtualStartMs = await FlutterForegroundTask.getData<int>(
          key: 'bg_phase_virtual_start_ms',
        );
        if (phaseVirtualStartMs != null) {
          final phaseTotalS =
              await FlutterForegroundTask.getData<int>(
                key: 'bg_phase_total_s',
              ) ??
              0;
          final phaseElapsed =
              ((nowMs - phaseVirtualStartMs) ~/ 1000).clamp(0, phaseTotalS);
          await FlutterForegroundTask.saveData(
            key: 'bg_phase_elapsed_s',
            value: phaseElapsed,
          );
        }
      }
      await FlutterForegroundTask.saveData(key: 'bg_paused', value: true);
      await FlutterForegroundTask.updateService(
        notificationTitle: 'Study Timer',
        notificationText: 'Paused \u2014 ${fmtTimerTime(elapsed)}',
        notificationButtons: kTimerPausedButtons,
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
      // Re-anchor phase virtual start so break/work timer resumes correctly.
      final phaseSnapshot = await FlutterForegroundTask.getData<int>(
        key: 'bg_phase_elapsed_s',
      );
      if (phaseSnapshot != null) {
        await FlutterForegroundTask.saveData(
          key: 'bg_phase_virtual_start_ms',
          value: nowMs - phaseSnapshot * 1000,
        );
      }
      await FlutterForegroundTask.saveData(key: 'bg_paused', value: false);
      await FlutterForegroundTask.updateService(
        notificationTitle: 'Study Timer',
        notificationText: 'Studying: ${fmtTimerTime(snapshot)}',
        notificationButtons: kTimerRunningButtons,
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
