enum TimerMode {
  countUp,
  countDown,
  pomodoro;

  String get value {
    switch (this) {
      case TimerMode.countUp:
        return 'count_up';
      case TimerMode.countDown:
        return 'count_down';
      case TimerMode.pomodoro:
        return 'pomodoro';
    }
  }

  static TimerMode fromString(String v) {
    switch (v) {
      case 'count_up':
        return TimerMode.countUp;
      case 'count_down':
        return TimerMode.countDown;
      case 'pomodoro':
        return TimerMode.pomodoro;
      default:
        return TimerMode.countUp;
    }
  }
}
