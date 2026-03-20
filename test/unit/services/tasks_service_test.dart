import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mocktail/mocktail.dart';
import 'package:marquer/api/models/api_response.dart';
import 'package:marquer/api/models/tasks/tasks/get_tasks_request.dart';
import 'package:marquer/api/models/tasks/tasks/task.dart';
import 'package:marquer/api/models/tasks/tasks/task_status.dart';
import 'package:marquer/api/services/tasks_service.dart';

import '../../fixtures/json/tasks.dart';
import '../../helpers/mock_api_service.dart';
import '../../helpers/test_setup.dart';

void main() {
  late MockApiService mockApi;

  setUp(() {
    final env = setUpTestEnvironment();
    mockApi = env.api;
  });

  tearDown(() => GetIt.instance.reset());

  group('TasksService', () {
    group('getTasks', () {
      test('calls api.get with correct path and returns parsed tasks',
          () async {
        when(
          () => mockApi.get<List<Task>>(
            '/tasks',
            query: any(named: 'query'),
            fromJsonT: any(named: 'fromJsonT'),
          ),
        ).thenAnswer((inv) async {
          final fromJsonT =
              inv.namedArguments[#fromJsonT] as List<Task> Function(Object?);
          final data = [taskJson1, taskJson2];
          return ApiResponse<List<Task>>(
            status: 200,
            success: true,
            message: 'OK',
            data: fromJsonT(data),
          );
        });

        final service = TasksService();
        final tasks = await service.getTasks(GetTasksRequest());

        expect(tasks, hasLength(2));
        expect(tasks[0].id, 1);
        expect(tasks[0].name, 'Buy groceries');
        expect(tasks[0].status, TaskStatus.draft);
        expect(tasks[1].id, 2);
        expect(tasks[1].name, 'Finish homework');
        expect(tasks[1].status, TaskStatus.done);

        verify(
          () => mockApi.get<List<Task>>(
            '/tasks',
            query: any(named: 'query'),
            fromJsonT: any(named: 'fromJsonT'),
          ),
        ).called(1);
      });

      test('passes query parameters from GetTasksRequest', () async {
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
            data: fromJsonT([]),
          );
        });

        final service = TasksService();
        final request = GetTasksRequest(
          taskCategoryId: 5,
          status: TaskStatus.done,
        );
        await service.getTasks(request);

        final captured = verify(
          () => mockApi.get<List<Task>>(
            '/tasks',
            query: captureAny(named: 'query'),
            fromJsonT: any(named: 'fromJsonT'),
          ),
        ).captured;

        final query = captured.first as Map<String, dynamic>;
        expect(query['task_category_id'], 5);
        expect(query['status'], 'done');
      });
    });

    group('deleteTask', () {
      test('calls api.delete with correct path', () async {
        when(() => mockApi.delete('/tasks/42')).thenAnswer(
          (inv) async => ApiResponse<Null>(
            status: 200,
            success: true,
            message: 'Deleted',
            data: null,
          ),
        );

        final service = TasksService();
        await service.deleteTask('42');

        verify(() => mockApi.delete('/tasks/42')).called(1);
      });
    });
  });
}
