import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:marquer/api/models/api_response.dart';
import 'package:marquer/api/models/study/study_session.dart';
import 'package:marquer/api/models/study/study_stats.dart';
import 'package:marquer/screens/home.dart';
import 'package:mocktail/mocktail.dart';

import '../../helpers/mock_api_service.dart';
import '../../helpers/mock_router.dart';
import '../../helpers/test_setup.dart';

void main() {
  late MockApiService mockApi;

  setUp(() async {
    final env = await setUpTestEnvironment();
    mockApi = env.api;
  });

  tearDown(() async {
    await GetIt.instance.reset();
  });

  /// Stubs GET /study/sessions/stats to return the given [todayTotalSeconds].
  void stubGetStats(MockApiService api, {int todayTotalSeconds = 0}) {
    when(() => api.get<StudyStats>(
          '/study/sessions/stats',
          query: any(named: 'query'),
          fromJsonT: any(named: 'fromJsonT'),
        )).thenAnswer((inv) async {
      final fromJsonT =
          inv.namedArguments[#fromJsonT] as StudyStats Function(Object?);
      return ApiResponse<StudyStats>(
        status: 200,
        success: true,
        message: 'OK',
        data: fromJsonT({
          'today_total_seconds': todayTotalSeconds,
          'sessions': <Map<String, dynamic>>[],
        }),
      );
    });
  }

  /// Stubs GET /study/sessions to return an empty list (no active/paused sessions).
  void stubGetSessions(MockApiService api) {
    when(() => api.get<List<StudySession>>(
          '/study/sessions',
          query: any(named: 'query'),
          fromJsonT: any(named: 'fromJsonT'),
        )).thenAnswer((inv) async {
      final fromJsonT = inv.namedArguments[#fromJsonT]
          as List<StudySession> Function(Object?);
      return ApiResponse<List<StudySession>>(
        status: 200,
        success: true,
        message: 'OK',
        data: fromJsonT([]),
      );
    });
  }

  group('HomePage', () {
    testWidgets('renders AppBar title Marquer', (tester) async {
      stubGetStats(mockApi, todayTotalSeconds: 0);
      stubGetSessions(mockApi);

      await pumpWithRouter(tester, const HomePage());
      await tester.pumpAndSettle();

      expect(find.text('Marquer'), findsOneWidget);
    });

    testWidgets('renders stats card with formatted study time',
        (tester) async {
      stubGetStats(mockApi, todayTotalSeconds: 3600);
      stubGetSessions(mockApi);

      await pumpWithRouter(tester, const HomePage());
      await tester.pumpAndSettle();

      expect(find.text("Today's Study Time"), findsOneWidget);
      expect(find.text('1h 0m'), findsOneWidget);
    });

    testWidgets('renders 4 navigation tiles', (tester) async {
      stubGetStats(mockApi, todayTotalSeconds: 0);
      stubGetSessions(mockApi);

      await pumpWithRouter(tester, const HomePage());
      await tester.pumpAndSettle();

      expect(find.text('Tasks'), findsOneWidget);
      expect(find.text('Start Study'), findsOneWidget);
      expect(find.text('Study Stats'), findsOneWidget);
      expect(find.text('Subjects'), findsOneWidget);
    });

    testWidgets('Tasks tile navigates to /tasks', (tester) async {
      stubGetStats(mockApi, todayTotalSeconds: 0);
      stubGetSessions(mockApi);

      final router = await pumpWithRouter(tester, const HomePage());
      await tester.pumpAndSettle();

      await tester.tap(find.text('Tasks'));
      await tester.pumpAndSettle();

      verify(() => router.push('/tasks')).called(1);
    });

    testWidgets('Study Stats tile navigates to /study/stats', (tester) async {
      stubGetStats(mockApi, todayTotalSeconds: 0);
      stubGetSessions(mockApi);

      final router = await pumpWithRouter(tester, const HomePage());
      await tester.pumpAndSettle();

      await tester.tap(find.text('Study Stats'));
      await tester.pumpAndSettle();

      verify(() => router.push('/study/stats')).called(1);
    });

    testWidgets('Subjects tile navigates to /study/subjects', (tester) async {
      stubGetStats(mockApi, todayTotalSeconds: 0);
      stubGetSessions(mockApi);

      final router = await pumpWithRouter(tester, const HomePage());
      await tester.pumpAndSettle();

      await tester.scrollUntilVisible(find.text('Subjects'), 200);
      await tester.pumpAndSettle();
      await tester.tap(find.text('Subjects'));
      await tester.pumpAndSettle();

      verify(() => router.push('/study/subjects')).called(1);
    });

    testWidgets('shows 0m when no study time', (tester) async {
      stubGetStats(mockApi, todayTotalSeconds: 0);
      stubGetSessions(mockApi);

      await pumpWithRouter(tester, const HomePage());
      await tester.pumpAndSettle();

      expect(find.text('0m'), findsOneWidget);
    });
  });
}
