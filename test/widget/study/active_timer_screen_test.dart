import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:marquer/api/models/study/study_session.dart';
import 'package:marquer/api/models/study/study_session_status.dart';
import 'package:marquer/api/models/study/timer_mode.dart';
import 'package:marquer/providers/study/timer_provider.dart';
import 'package:marquer/providers/study/timer_state.dart';
import 'package:marquer/screens/study/active_timer_screen.dart';

import '../../helpers/mock_router.dart';
import '../../helpers/test_setup.dart';

/// A fake [TimerNotifier] that holds a pre-configured state and records calls.
class FakeTimerNotifier extends TimerNotifier {
  final TimerState initialState;
  bool pauseCalled = false;
  bool resumeCalled = false;
  bool completeCalled = false;

  FakeTimerNotifier(this.initialState);

  @override
  TimerState build() => initialState;

  @override
  Future<void> pause() async {
    pauseCalled = true;
    state = state.copyWith(isRunning: false);
  }

  @override
  Future<void> resume() async {
    resumeCalled = true;
    state = state.copyWith(isRunning: true);
  }

  @override
  Future<void> complete() async {
    completeCalled = true;
  }

  @override
  Future<void> loadFromSession(StudySession session) async {}

  @override
  void recoverFromBackground() {}

  @override
  void pauseTicker() {}

  @override
  void clearStopRequest() {}
}

final _testSession = StudySession(
  id: 1,
  userId: 1,
  name: 'Math Study',
  timerMode: TimerMode.countUp,
  status: StudySessionStatus.active,
  actualDurationSeconds: 125,
  startedAt: '2026-03-20T10:00:00Z',
  createdAt: '2026-03-20T10:00:00Z',
  updatedAt: '2026-03-20T10:00:00Z',
);

void main() {
  setUp(() async {
    await setUpTestEnvironment();
  });

  tearDown(() => GetIt.instance.reset());

  group('ActiveTimerScreen', () {
    testWidgets('renders session name in AppBar', (tester) async {
      final notifier = FakeTimerNotifier(
        TimerState(
          isRunning: true,
          mode: TimerMode.countUp,
          elapsedSeconds: 125,
          serverSession: _testSession,
        ),
      );

      await pumpWithRouter(
        tester,
        ActiveTimerScreen(session: _testSession),
        overrides: [timerProvider.overrideWith(() => notifier)],
      );
      await tester.pump();

      expect(find.text('Math Study'), findsOneWidget);
    });

    testWidgets('shows Pause button when running', (tester) async {
      final notifier = FakeTimerNotifier(
        TimerState(
          isRunning: true,
          mode: TimerMode.countUp,
          elapsedSeconds: 60,
          serverSession: _testSession,
        ),
      );

      await pumpWithRouter(
        tester,
        ActiveTimerScreen(session: _testSession),
        overrides: [timerProvider.overrideWith(() => notifier)],
      );
      await tester.pump();

      expect(find.text('Pause'), findsOneWidget);
      expect(find.text('Resume'), findsNothing);
    });

    testWidgets('shows Resume button when paused', (tester) async {
      final notifier = FakeTimerNotifier(
        TimerState(
          isRunning: false,
          mode: TimerMode.countUp,
          elapsedSeconds: 60,
          serverSession: _testSession,
        ),
      );

      await pumpWithRouter(
        tester,
        ActiveTimerScreen(session: _testSession),
        overrides: [timerProvider.overrideWith(() => notifier)],
      );
      await tester.pump();

      expect(find.text('Resume'), findsOneWidget);
      expect(find.text('Pause'), findsNothing);
    });

    testWidgets('shows End Session button', (tester) async {
      final notifier = FakeTimerNotifier(
        TimerState(
          isRunning: true,
          mode: TimerMode.countUp,
          elapsedSeconds: 60,
          serverSession: _testSession,
        ),
      );

      await pumpWithRouter(
        tester,
        ActiveTimerScreen(session: _testSession),
        overrides: [timerProvider.overrideWith(() => notifier)],
      );
      await tester.pump();

      expect(find.text('End Session'), findsOneWidget);
    });

    testWidgets('shows close icon in AppBar', (tester) async {
      final notifier = FakeTimerNotifier(
        TimerState(
          isRunning: true,
          mode: TimerMode.countUp,
          elapsedSeconds: 0,
          serverSession: _testSession,
        ),
      );

      await pumpWithRouter(
        tester,
        ActiveTimerScreen(session: _testSession),
        overrides: [timerProvider.overrideWith(() => notifier)],
      );
      await tester.pump();

      expect(find.byIcon(Icons.close), findsOneWidget);
    });

    testWidgets('End Session button shows confirmation dialog', (tester) async {
      final notifier = FakeTimerNotifier(
        TimerState(
          isRunning: true,
          mode: TimerMode.countUp,
          elapsedSeconds: 60,
          serverSession: _testSession,
        ),
      );

      await pumpWithRouter(
        tester,
        ActiveTimerScreen(session: _testSession),
        overrides: [timerProvider.overrideWith(() => notifier)],
      );
      await tester.pump();

      await tester.tap(find.text('End Session'));
      // Can't use pumpAndSettle due to repeating breath animation.
      // Pump a few frames to let the dialog appear.
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 100));

      expect(find.text('End Session?'), findsOneWidget);
      expect(find.text('Complete the current study session?'), findsOneWidget);
      expect(find.text('Cancel'), findsOneWidget);
      expect(find.text('Complete'), findsOneWidget);
    });
  });
}
