import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:marquer/api/models/api_response.dart';
import 'package:marquer/api/models/tasks/folders/task_folder.dart';
import 'package:marquer/api/models/tasks/tasks/task.dart';
import 'package:marquer/screens/tasks/tasks.dart';
import 'package:mocktail/mocktail.dart';

import '../../fixtures/json/tasks.dart';
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

  /// Stubs GET /tasks to return [taskMaps] via the real provider chain.
  void stubGetTasks(MockApiService api, List<Map<String, dynamic>> taskMaps) {
    when(() => api.get<List<Task>>(
          '/tasks',
          query: any(named: 'query'),
          fromJsonT: any(named: 'fromJsonT'),
        )).thenAnswer((inv) async {
      final fromJsonT =
          inv.namedArguments[#fromJsonT] as List<Task> Function(Object?);
      return ApiResponse<List<Task>>(
        status: 200,
        success: true,
        message: 'OK',
        data: fromJsonT(taskMaps),
      );
    });
  }

  /// Stubs GET /task-folders to return an empty list.
  void stubGetTaskFolders(MockApiService api) {
    when(() => api.get<List<TaskFolder>>(
          '/task-folders',
          query: any(named: 'query'),
          fromJsonT: any(named: 'fromJsonT'),
        )).thenAnswer((inv) async {
      final fromJsonT =
          inv.namedArguments[#fromJsonT] as List<TaskFolder> Function(Object?);
      return ApiResponse<List<TaskFolder>>(
        status: 200,
        success: true,
        message: 'OK',
        data: fromJsonT([]),
      );
    });
  }

  group('TasksPage', () {
    testWidgets('shows CircularProgressIndicator while loading', (tester) async {
      // Use a Completer that never completes (no timer created).
      final neverComplete = Completer<ApiResponse<List<Task>>>();

      when(() => mockApi.get<List<Task>>(
            '/tasks',
            query: any(named: 'query'),
            fromJsonT: any(named: 'fromJsonT'),
          )).thenAnswer((_) => neverComplete.future);
      stubGetTaskFolders(mockApi);

      await pumpWithRouter(tester, const TasksPage());
      // Single pump — provider is still loading.
      await tester.pump();

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    testWidgets('renders active and completed tasks when loaded',
        (tester) async {
      stubGetTasks(mockApi, [taskJson1, taskJson2, taskJson3]);
      stubGetTaskFolders(mockApi);

      await pumpWithRouter(tester, const TasksPage());
      await tester.pumpAndSettle();

      // Active tasks (draft / progress)
      expect(find.text('Buy groceries'), findsOneWidget);
      expect(find.text('Read a book'), findsOneWidget);

      // Completed section header visible (1 done task)
      expect(find.text('Completed (1)'), findsOneWidget);
    });

    testWidgets('shows empty state when no tasks', (tester) async {
      stubGetTasks(mockApi, []);
      stubGetTaskFolders(mockApi);

      await pumpWithRouter(tester, const TasksPage());
      await tester.pumpAndSettle();

      expect(find.text('No tasks yet'), findsOneWidget);
    });

    testWidgets('shows FAB with add icon', (tester) async {
      stubGetTasks(mockApi, [taskJson1]);
      stubGetTaskFolders(mockApi);

      await pumpWithRouter(tester, const TasksPage());
      await tester.pumpAndSettle();

      expect(find.byType(FloatingActionButton), findsOneWidget);
      expect(find.byIcon(Icons.add), findsOneWidget);
    });

    testWidgets('filter title shows "All To-Do" by default', (tester) async {
      stubGetTasks(mockApi, []);
      stubGetTaskFolders(mockApi);

      await pumpWithRouter(tester, const TasksPage());
      await tester.pumpAndSettle();

      expect(find.text('All To-Do'), findsOneWidget);
    });

    testWidgets('shows error message when loading fails', (tester) async {
      when(() => mockApi.get<List<Task>>(
            '/tasks',
            query: any(named: 'query'),
            fromJsonT: any(named: 'fromJsonT'),
          )).thenThrow(Exception('Network error'));
      stubGetTaskFolders(mockApi);

      await pumpWithRouter(tester, const TasksPage());
      await tester.pumpAndSettle();

      expect(
        find.text('Failed to load tasks. Pull down to retry.'),
        findsOneWidget,
      );
    });
  });
}
