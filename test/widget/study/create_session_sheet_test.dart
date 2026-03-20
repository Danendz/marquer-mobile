import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/misc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:marquer/api/models/study/study_subject.dart';
import 'package:marquer/api/models/study/user_study_settings.dart';
import 'package:marquer/providers/study/study_settings_provider.dart';
import 'package:marquer/providers/study/study_subjects_provider.dart';
import 'package:marquer/screens/study/create_session_sheet.dart';
import 'package:marquer/services/toast_service.dart';

import '../../helpers/test_setup.dart';

void main() {
  setUp(() async {
    await setUpTestEnvironment();
  });

  tearDown(() => GetIt.instance.reset());

  Future<void> pumpSheet(
    WidgetTester tester, {
    List<Override> overrides = const [],
  }) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          studySubjectsProvider.overrideWith(() => _EmptySubjectsNotifier()),
          studySettingsProvider.overrideWith(() => _DefaultSettingsNotifier()),
          ...overrides,
        ],
        child: MaterialApp(
          scaffoldMessengerKey: ToastService.messengerKey,
          home: const Scaffold(
            body: CreateSessionSheet(),
          ),
        ),
      ),
    );
  }

  group('CreateSessionSheet', () {
    testWidgets('renders title and session name field', (tester) async {
      await pumpSheet(tester);
      await tester.pump();

      expect(find.text('New Study Session'), findsOneWidget);
      expect(find.text('Set up your focus session'), findsOneWidget);
      expect(find.widgetWithText(TextField, 'Session name'), findsOneWidget);
    });

    testWidgets('renders timer mode selector with 3 options', (tester) async {
      await pumpSheet(tester);
      await tester.pump();

      expect(find.text('Count-up'), findsOneWidget);
      expect(find.text('Count-down'), findsOneWidget);
      expect(find.text('Pomodoro'), findsOneWidget);
    });

    testWidgets('renders start session button', (tester) async {
      await pumpSheet(tester);
      await tester.pump();

      expect(find.text('Start Session'), findsOneWidget);
    });

    testWidgets('renders subject dropdown with No subject option', (tester) async {
      await pumpSheet(tester);
      await tester.pumpAndSettle();

      expect(find.text('No subject'), findsOneWidget);
    });

    testWidgets('default mode is count-up (no config section)', (tester) async {
      await pumpSheet(tester);
      await tester.pump();

      expect(find.byKey(const ValueKey('none')), findsOneWidget);
    });

    testWidgets('selecting count-down hides count-up config', (tester) async {
      await pumpSheet(tester);
      await tester.pump();

      await tester.tap(find.text('Count-down'));
      await tester.pumpAndSettle();

      expect(find.byKey(const ValueKey('none')), findsNothing);
    });

    testWidgets('selecting pomodoro hides count-up config', (tester) async {
      await pumpSheet(tester);
      await tester.pump();

      await tester.tap(find.text('Pomodoro'));
      await tester.pumpAndSettle();

      expect(find.byKey(const ValueKey('none')), findsNothing);
    });
  });
}

class _EmptySubjectsNotifier extends StudySubjectsNotifier {
  @override
  Future<List<StudySubject>> build() async => [];
}

class _DefaultSettingsNotifier extends StudySettingsNotifier {
  @override
  Future<UserStudySettings> build() async => const UserStudySettings(
        defaultWorkMinutes: 25,
        defaultShortBreakMinutes: 5,
        defaultLongBreakMinutes: 15,
        defaultCycles: 4,
      );
}
