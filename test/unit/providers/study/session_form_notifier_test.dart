import 'package:flutter_test/flutter_test.dart';
import 'package:marquer/api/models/study/timer_mode.dart';
import 'package:marquer/providers/study/session_form_notifier.dart';

void main() {
  group('SessionFormState.validate', () {
    test('returns error when name is empty', () {
      const form = SessionFormState(name: '');
      expect(form.validate(), 'Session name is required');
    });

    test('returns error when name is whitespace only', () {
      const form = SessionFormState(name: '   ');
      expect(form.validate(), 'Session name is required');
    });

    test('returns null for valid countUp session', () {
      const form = SessionFormState(name: 'Study', mode: TimerMode.countUp);
      expect(form.validate(), isNull);
    });

    test('returns error when countdown duration < 1 minute', () {
      const form = SessionFormState(
        name: 'Study',
        mode: TimerMode.countDown,
        countDownMinutes: 0,
      );
      expect(form.validate(), contains('at least 1 minute'));
    });

    test('returns null for valid countdown', () {
      const form = SessionFormState(
        name: 'Study',
        mode: TimerMode.countDown,
        countDownMinutes: 30,
      );
      expect(form.validate(), isNull);
    });

    test('returns error when pomodoro work < 1 minute', () {
      const form = SessionFormState(
        name: 'Study',
        mode: TimerMode.pomodoro,
        workMinutes: 0,
      );
      expect(form.validate(), contains('Work'));
    });

    test('returns error when pomodoro cycles < 1', () {
      const form = SessionFormState(
        name: 'Study',
        mode: TimerMode.pomodoro,
        cycles: 0,
      );
      expect(form.validate(), contains('cycle'));
    });

    test('returns null for valid pomodoro config', () {
      const form = SessionFormState(
        name: 'Study',
        mode: TimerMode.pomodoro,
        workMinutes: 25,
        shortBreakMinutes: 5,
        longBreakMinutes: 15,
        cycles: 4,
      );
      expect(form.validate(), isNull);
    });
  });

  group('SessionFormState.toRequest', () {
    test('countUp: no duration or pomodoro fields', () {
      const form = SessionFormState(name: 'Study', mode: TimerMode.countUp);
      final req = form.toRequest();
      expect(req.name, 'Study');
      expect(req.timerMode, TimerMode.countUp);
      expect(req.plannedDurationSeconds, isNull);
      expect(req.pomodoroWorkMinutes, isNull);
    });

    test('countDown: includes planned duration', () {
      const form = SessionFormState(
        name: 'Focus',
        mode: TimerMode.countDown,
        countDownMinutes: 45,
      );
      final req = form.toRequest();
      expect(req.plannedDurationSeconds, 45 * 60);
      expect(req.pomodoroWorkMinutes, isNull);
    });

    test('pomodoro: includes all pomodoro fields', () {
      const form = SessionFormState(
        name: 'Deep Work',
        mode: TimerMode.pomodoro,
        workMinutes: 50,
        shortBreakMinutes: 10,
        longBreakMinutes: 30,
        cycles: 3,
      );
      final req = form.toRequest();
      expect(req.pomodoroWorkMinutes, 50);
      expect(req.pomodoroShortBreakMinutes, 10);
      expect(req.pomodoroLongBreakMinutes, 30);
      expect(req.pomodoroCycles, 3);
      expect(req.plannedDurationSeconds, isNull);
    });

    test('trims name whitespace', () {
      const form = SessionFormState(name: '  Study  ');
      expect(form.toRequest().name, 'Study');
    });
  });
}
