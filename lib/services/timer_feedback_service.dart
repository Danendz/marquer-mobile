import 'package:audioplayers/audioplayers.dart';
import 'package:vibration/vibration.dart';

class TimerFeedbackService {
  static final AudioPlayer _player = AudioPlayer();

  static const List<int> _completionPattern = [0, 500, 200, 500, 200, 500];

  static Future<void> playCompletionFeedback() async {
    await Future.wait([
      _vibrate(_completionPattern),
      _playSound(),
    ]);
  }

  static Future<void> playVibrationOnly() async {
    await _vibrate(_completionPattern);
  }

  static Future<void> stop() async {
    await _player.stop();
  }

  static void dispose() {
    _player.dispose();
  }

  static Future<void> _vibrate(List<int> pattern) async {
    final hasVibrator = await Vibration.hasVibrator();
    if (!hasVibrator) return;
    await Vibration.vibrate(pattern: pattern);
  }

  static Future<void> _playSound() async {
    await _player.play(AssetSource('sounds/timer_complete.mp3'));
  }
}
