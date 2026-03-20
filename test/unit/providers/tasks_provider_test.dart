import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mocktail/mocktail.dart';
import 'package:marquer/api/models/api_response.dart';
import 'package:marquer/api/models/tasks/tasks/task.dart';
import 'package:marquer/providers/tasks/task_filter.dart';
import 'package:marquer/providers/tasks/task_filter_provider.dart';
import 'package:marquer/providers/tasks/tasks_provider.dart';

import '../../fixtures/json/tasks.dart';
import '../../helpers/mock_api_service.dart';
import '../../helpers/riverpod_helpers.dart';
import '../../helpers/test_setup.dart';

void main() {
  late MockApiService mockApi;

  setUp(() async {
    final env = await setUpTestEnvironment();
    mockApi = env.api;
  });

  tearDown(() => GetIt.instance.reset());

  /// Stubs [mockApi.get] for the /tasks endpoint to return the provided tasks.
  void stubGetTasks(List<Map<String, dynamic>> taskMaps) {
    when(
      () => mockApi.get<List<Task>>(
        '/tasks',
        query: any(named: 'query'),
        fromJsonT: any(named: 'fromJsonT'),
      ),
    ).thenAnswer((inv) async {
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

  group('tasksProvider', () {
    test('starts in loading state then emits task list', () async {
      stubGetTasks([taskJson1, taskJson2]);

      final container = createTestContainer();

      // Initially loading
      final initial = container.read(tasksProvider);
      expect(initial, isA<AsyncLoading<List<Task>>>());

      // Wait for the async build to complete
      await container.read(tasksProvider.future);

      final loaded = container.read(tasksProvider);
      expect(loaded, isA<AsyncData<List<Task>>>());
      expect(loaded.value, hasLength(2));
      expect(loaded.value![0].name, 'Buy groceries');
      expect(loaded.value![1].name, 'Finish homework');
    });

    test('re-fetches when taskFilterProvider changes', () async {
      stubGetTasks([taskJson1, taskJson2, taskJson3]);

      final container = createTestContainer();
      await container.read(tasksProvider.future);

      // Verify initial fetch
      verify(
        () => mockApi.get<List<Task>>(
          '/tasks',
          query: any(named: 'query'),
          fromJsonT: any(named: 'fromJsonT'),
        ),
      ).called(1);

      // Change filter — should trigger a new fetch
      stubGetTasks([taskJson3]);
      container
          .read(taskFilterProvider.notifier)
          .set(CategoryFilter(
            categoryId: 5,
            categoryName: 'Study',
            categoryColor: '#FF0000',
          ));

      await container.read(tasksProvider.future);

      // Second fetch should have happened
      verify(
        () => mockApi.get<List<Task>>(
          '/tasks',
          query: any(named: 'query'),
          fromJsonT: any(named: 'fromJsonT'),
        ),
      ).called(1);
    });

    test('returns empty list when API returns no tasks', () async {
      stubGetTasks([]);

      final container = createTestContainer();
      final tasks = await container.read(tasksProvider.future);

      expect(tasks, isEmpty);
    });
  });
}
