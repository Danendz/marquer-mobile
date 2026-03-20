import 'package:json_annotation/json_annotation.dart';

enum TimerMode {
  @JsonValue('count_up')
  countUp,
  @JsonValue('count_down')
  countDown,
  @JsonValue('pomodoro')
  pomodoro;

  String get value {
    return switch (this) {
      TimerMode.countUp => 'count_up',
      TimerMode.countDown => 'count_down',
      TimerMode.pomodoro => 'pomodoro',
    };
  }

  static TimerMode fromString(String v) {
    return switch (v) {
      'count_up' => TimerMode.countUp,
      'count_down' => TimerMode.countDown,
      'pomodoro' => TimerMode.pomodoro,
      _ => TimerMode.countUp,
    };
  }
}
