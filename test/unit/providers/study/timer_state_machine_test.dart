import 'package:flutter_test/flutter_test.dart';
import 'package:marquer/api/models/study/timer_mode.dart';
import 'package:marquer/providers/study/timer_state.dart';
import 'package:marquer/providers/study/timer_state_machine.dart';

void main() {
  const sm = TimerStateMachine();

  TimerState running(TimerMode mode, {
    int elapsed = 0,
    int? target,
    TimerPhase phase = TimerPhase.idle,
    int phaseElapsed = 0,
    int completedCycles = 0,
    int totalCycles = 4,
    int workMinutes = 25,
    int shortBreakMinutes = 5,
    int longBreakMinutes = 15,
  }) => TimerState(
    isRunning: true,
    mode: mode,
    elapsedSeconds: elapsed,
    targetSeconds: target,
    phase: phase,
    phaseElapsedSeconds: phaseElapsed,
    completedCycles: completedCycles,
    totalCycles: totalCycles,
    workMinutes: workMinutes,
    shortBreakMinutes: shortBreakMinutes,
    longBreakMinutes: longBreakMinutes,
  );

  group('count-up', () {
    test('tick increments elapsed', () {
      final s = running(TimerMode.countUp, elapsed: 10);
      final r = sm.tick(s);
      expect(r.state.elapsedSeconds, 11);
      expect(r.timerCompleted, false);
    });

    test('does nothing when not running', () {
      final s = TimerState(mode: TimerMode.countUp);
      final r = sm.tick(s);
      expect(r.state.elapsedSeconds, 0);
    });
  });

  group('count-down', () {
    test('tick increments elapsed', () {
      final s = running(TimerMode.countDown, elapsed: 5, target: 300);
      final r = sm.tick(s);
      expect(r.state.elapsedSeconds, 6);
      expect(r.timerCompleted, false);
    });

    test('completes at target', () {
      final s = running(TimerMode.countDown, elapsed: 299, target: 300);
      final r = sm.tick(s);
      expect(r.state.elapsedSeconds, 300);
      expect(r.state.isRunning, false);
      expect(r.timerCompleted, true);
    });

    test('remainingSeconds computes correctly', () {
      final s = running(TimerMode.countDown, elapsed: 100, target: 300);
      expect(s.remainingSeconds, 200);
    });
  });

  group('pomodoro', () {
    test('work phase: tick increments both elapsed and phase elapsed', () {
      final s = running(TimerMode.pomodoro, phase: TimerPhase.work,
          elapsed: 10, phaseElapsed: 5, workMinutes: 1);
      final r = sm.tick(s);
      expect(r.state.elapsedSeconds, 11);
      expect(r.state.phaseElapsedSeconds, 6);
      expect(r.phaseCompleted, false);
    });

    test('break phase: tick does NOT increment study elapsed', () {
      final s = running(TimerMode.pomodoro, phase: TimerPhase.shortBreak,
          elapsed: 100, phaseElapsed: 2, shortBreakMinutes: 1);
      final r = sm.tick(s);
      expect(r.state.elapsedSeconds, 100); // unchanged
      expect(r.state.phaseElapsedSeconds, 3);
    });

    test('work → short break after work phase completes (not last cycle)', () {
      final s = running(TimerMode.pomodoro, phase: TimerPhase.work,
          elapsed: 59, phaseElapsed: 59, workMinutes: 1,
          completedCycles: 0, totalCycles: 4);
      final r = sm.tick(s);
      expect(r.state.phase, TimerPhase.shortBreak);
      expect(r.state.completedCycles, 1);
      expect(r.state.phaseElapsedSeconds, 0);
      expect(r.phaseCompleted, true);
    });

    test('work → long break after last work cycle', () {
      final s = running(TimerMode.pomodoro, phase: TimerPhase.work,
          elapsed: 59, phaseElapsed: 59, workMinutes: 1,
          completedCycles: 3, totalCycles: 4);
      final r = sm.tick(s);
      expect(r.state.phase, TimerPhase.longBreak);
      expect(r.state.completedCycles, 4);
      expect(r.phaseCompleted, true);
    });

    test('short break → work', () {
      final s = running(TimerMode.pomodoro, phase: TimerPhase.shortBreak,
          phaseElapsed: 299, shortBreakMinutes: 5,
          completedCycles: 1, totalCycles: 4);
      final r = sm.tick(s);
      expect(r.state.phase, TimerPhase.work);
      expect(r.state.phaseElapsedSeconds, 0);
      expect(r.phaseCompleted, true);
    });

    test('long break completes → timer stops', () {
      final s = running(TimerMode.pomodoro, phase: TimerPhase.longBreak,
          phaseElapsed: 899, longBreakMinutes: 15,
          completedCycles: 4, totalCycles: 4);
      final r = sm.tick(s);
      expect(r.state.isRunning, false);
      expect(r.timerCompleted, true);
      expect(r.phaseCompleted, true);
    });

    test('full cycle: work → short break → work → long break → done', () {
      // 1-second phases for easy testing
      var s = running(TimerMode.pomodoro, phase: TimerPhase.work,
          workMinutes: 0, shortBreakMinutes: 0, longBreakMinutes: 0,
          completedCycles: 0, totalCycles: 2);
      // Override currentPhaseTotalSeconds by using 1-second = 0 minutes
      // Since workMinutes=0, currentPhaseTotalSeconds=0, phase completes immediately
      // Let's use 1-minute phases with phaseElapsed at boundary
      s = running(TimerMode.pomodoro, phase: TimerPhase.work,
          phaseElapsed: 59, workMinutes: 1, shortBreakMinutes: 1, longBreakMinutes: 1,
          completedCycles: 0, totalCycles: 2);

      // Cycle 1: work completes → short break
      var r = sm.tick(s);
      expect(r.state.phase, TimerPhase.shortBreak);
      expect(r.state.completedCycles, 1);

      // Short break completes → work
      s = r.state.copyWith(phaseElapsedSeconds: 59);
      r = sm.tick(s);
      expect(r.state.phase, TimerPhase.work);

      // Cycle 2: work completes → long break
      s = r.state.copyWith(phaseElapsedSeconds: 59);
      r = sm.tick(s);
      expect(r.state.phase, TimerPhase.longBreak);
      expect(r.state.completedCycles, 2);

      // Long break completes → done
      s = r.state.copyWith(phaseElapsedSeconds: 59);
      r = sm.tick(s);
      expect(r.state.isRunning, false);
      expect(r.timerCompleted, true);
    });
  });

  group('recoverMissedTime', () {
    test('count-up: adds missed seconds', () {
      final s = running(TimerMode.countUp, elapsed: 100);
      final r = sm.recoverMissedTime(s, 30);
      expect(r.state.elapsedSeconds, 130);
    });

    test('count-down: clamps to target', () {
      final s = running(TimerMode.countDown, elapsed: 280, target: 300);
      final r = sm.recoverMissedTime(s, 50);
      expect(r.state.elapsedSeconds, 300);
      expect(r.timerCompleted, true);
      expect(r.state.isRunning, false);
    });

    test('pomodoro: crosses phase boundary', () {
      // 60s work, 10 seconds into it, missed 60 seconds
      final s = running(TimerMode.pomodoro, phase: TimerPhase.work,
          elapsed: 10, phaseElapsed: 10, workMinutes: 1,
          shortBreakMinutes: 1, completedCycles: 0, totalCycles: 4);
      final r = sm.recoverMissedTime(s, 60);
      // Should have crossed the work phase boundary (50s remaining)
      // and be 10s into short break
      expect(r.state.completedCycles, 1);
      expect(r.state.phase, TimerPhase.shortBreak);
      expect(r.state.phaseElapsedSeconds, 10);
      expect(r.phaseCompleted, true);
    });

    test('ignores <=1 missed second', () {
      final s = running(TimerMode.countUp, elapsed: 100);
      final r = sm.recoverMissedTime(s, 1);
      expect(r.state.elapsedSeconds, 100);
    });
  });

  group('formatTime', () {
    test('MM:SS under an hour', () {
      expect(TimerStateMachine.formatTime(65), '01:05');
    });

    test('HH:MM:SS at an hour+', () {
      expect(TimerStateMachine.formatTime(3661), '01:01:01');
    });

    test('zero', () {
      expect(TimerStateMachine.formatTime(0), '00:00');
    });
  });
}
