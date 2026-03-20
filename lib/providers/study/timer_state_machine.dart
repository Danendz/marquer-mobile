import 'package:marquer/api/models/study/timer_mode.dart';
import 'package:marquer/providers/study/timer_state.dart';

/// Result of a tick or recovery operation.
class TickResult {
  final TimerState state;
  /// True if a pomodoro phase boundary was crossed (play feedback).
  final bool phaseCompleted;
  /// True if the timer completed (count-down reached zero or all pomodoro cycles done).
  final bool timerCompleted;

  const TickResult(this.state, {this.phaseCompleted = false, this.timerCompleted = false});
}

/// Pure state machine for the study timer.
///
/// All methods are side-effect-free — they take a [TimerState] and return a new
/// [TimerState] (or [TickResult]). The caller (TimerNotifier) is responsible for
/// I/O side effects like wakelock, notifications, persistence, and API sync.
class TimerStateMachine {
  const TimerStateMachine();

  /// Advance the timer by one second.
  TickResult tick(TimerState s) {
    if (!s.isRunning) return TickResult(s);

    if (s.mode == TimerMode.pomodoro) {
      return _tickPomodoro(s);
    }

    final newElapsed = s.elapsedSeconds + 1;

    // Count-down: auto-complete when done
    if (s.mode == TimerMode.countDown &&
        s.targetSeconds != null &&
        newElapsed >= s.targetSeconds!) {
      return TickResult(
        s.copyWith(elapsedSeconds: s.targetSeconds, isRunning: false),
        timerCompleted: true,
      );
    }

    return TickResult(s.copyWith(elapsedSeconds: newElapsed));
  }

  TickResult _tickPomodoro(TimerState s) {
    final newPhaseElapsed = s.phaseElapsedSeconds + 1;
    final phaseTotal = s.currentPhaseTotalSeconds;

    if (newPhaseElapsed >= phaseTotal) {
      return _handlePomodoroPhaseComplete(s);
    }

    // Only count study seconds during work phase
    final newStudyElapsed =
        s.phase == TimerPhase.work ? s.elapsedSeconds + 1 : s.elapsedSeconds;
    return TickResult(
      s.copyWith(elapsedSeconds: newStudyElapsed, phaseElapsedSeconds: newPhaseElapsed),
    );
  }

  TickResult _handlePomodoroPhaseComplete(TimerState s) {
    if (s.phase == TimerPhase.work) {
      final newCycles = s.completedCycles + 1;
      final nextPhase = newCycles >= s.totalCycles
          ? TimerPhase.longBreak
          : TimerPhase.shortBreak;
      return TickResult(
        s.copyWith(
          phase: nextPhase,
          phaseElapsedSeconds: 0,
          completedCycles: newCycles,
          elapsedSeconds: s.elapsedSeconds + 1,
        ),
        phaseCompleted: true,
      );
    }

    // Break complete
    if (s.phase == TimerPhase.longBreak && s.completedCycles >= s.totalCycles) {
      // All cycles done
      return TickResult(
        s.copyWith(
          isRunning: false,
          phaseElapsedSeconds: s.currentPhaseTotalSeconds,
        ),
        phaseCompleted: true,
        timerCompleted: true,
      );
    }

    // Short break (or unfinished long break) → back to work
    return TickResult(
      s.copyWith(phase: TimerPhase.work, phaseElapsedSeconds: 0),
      phaseCompleted: true,
    );
  }

  /// Recover from [missedSeconds] of background time (e.g. app was suspended).
  TickResult recoverMissedTime(TimerState s, int missedSeconds) {
    if (missedSeconds <= 1 || !s.isRunning) return TickResult(s);

    if (s.mode == TimerMode.countDown && s.targetSeconds != null) {
      final newElapsed = (s.elapsedSeconds + missedSeconds).clamp(0, s.targetSeconds!);
      if (newElapsed >= s.targetSeconds!) {
        return TickResult(
          s.copyWith(elapsedSeconds: s.targetSeconds, isRunning: false),
          timerCompleted: true,
        );
      }
      return TickResult(s.copyWith(elapsedSeconds: newElapsed));
    }

    if (s.mode == TimerMode.pomodoro) {
      return _recoverPomodoro(s, missedSeconds);
    }

    // countUp: just add missed seconds
    return TickResult(s.copyWith(elapsedSeconds: s.elapsedSeconds + missedSeconds));
  }

  TickResult _recoverPomodoro(TimerState s, int missedSeconds) {
    var current = s;
    int remaining = missedSeconds;
    bool anyPhaseCompleted = false;

    while (remaining > 0 && current.isRunning) {
      final phaseRemaining =
          current.currentPhaseTotalSeconds - current.phaseElapsedSeconds;

      if (remaining < phaseRemaining) {
        // Still within current phase
        final newElapsed = current.phase == TimerPhase.work
            ? current.elapsedSeconds + remaining
            : current.elapsedSeconds;
        current = current.copyWith(
          elapsedSeconds: newElapsed,
          phaseElapsedSeconds: current.phaseElapsedSeconds + remaining,
        );
        break;
      }

      // Current phase completes — consume and advance
      remaining -= phaseRemaining;
      final newElapsed = current.phase == TimerPhase.work
          ? current.elapsedSeconds + phaseRemaining
          : current.elapsedSeconds;

      if (current.phase == TimerPhase.work) {
        final newCycles = current.completedCycles + 1;
        current = current.copyWith(
          phase: newCycles >= current.totalCycles
              ? TimerPhase.longBreak
              : TimerPhase.shortBreak,
          phaseElapsedSeconds: 0,
          completedCycles: newCycles,
          elapsedSeconds: newElapsed,
        );
        anyPhaseCompleted = true;
      } else if (current.phase == TimerPhase.longBreak &&
          current.completedCycles >= current.totalCycles) {
        // All cycles done
        return TickResult(
          current.copyWith(
            isRunning: false,
            phaseElapsedSeconds: current.currentPhaseTotalSeconds,
            elapsedSeconds: newElapsed,
          ),
          phaseCompleted: true,
          timerCompleted: true,
        );
      } else {
        // Break → back to work
        current = current.copyWith(
          phase: TimerPhase.work,
          phaseElapsedSeconds: 0,
          elapsedSeconds: newElapsed,
        );
        anyPhaseCompleted = true;
      }
    }

    return TickResult(current, phaseCompleted: anyPhaseCompleted);
  }

  /// Format seconds as HH:MM:SS or MM:SS.
  static String formatTime(int seconds) {
    final h = seconds ~/ 3600;
    final m = (seconds % 3600) ~/ 60;
    final s = seconds % 60;
    if (h > 0) {
      return '${h.toString().padLeft(2, '0')}:${m.toString().padLeft(2, '0')}:${s.toString().padLeft(2, '0')}';
    }
    return '${m.toString().padLeft(2, '0')}:${s.toString().padLeft(2, '0')}';
  }
}
