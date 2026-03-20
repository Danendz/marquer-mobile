import 'package:flutter_test/flutter_test.dart';
import 'package:marquer/api/models/tasks/categories/task_category.dart';
import 'package:marquer/api/models/tasks/folders/task_folder.dart';
import 'package:marquer/api/models/tasks/tasks/create_task_request.dart';
import 'package:marquer/api/models/tasks/tasks/get_tasks_request.dart';
import 'package:marquer/api/models/tasks/tasks/task.dart';
import 'package:marquer/api/models/tasks/tasks/task_status.dart';
import 'package:marquer/api/models/tasks/tasks/update_task_request.dart';

void main() {
  group('Task', () {
    test('round-trip fromJson/toJson with all fields', () {
      final json = {
        'id': 1,
        'name': 'Buy groceries',
        'status': 'draft',
        'date': '2026-03-20',
        'start_time': '10:00',
        'end_time': '11:00',
        'task_category_id': 5,
        'color': '#FF0000',
        'created_at': '2026-03-18T08:00:00.000000Z',
        'updated_at': '2026-03-18T09:00:00.000000Z',
      };
      final task = Task.fromJson(json);
      expect(task.id, 1);
      expect(task.name, 'Buy groceries');
      expect(task.status, TaskStatus.draft);
      expect(task.date, '2026-03-20');
      expect(task.startTime, '10:00');
      expect(task.taskCategoryId, 5);
      expect(Task.fromJson(task.toJson()), task);
    });

    test('round-trip with nullable fields null', () {
      final json = {
        'id': 2,
        'name': 'Task',
        'status': 'done',
        'date': null,
        'start_time': null,
        'end_time': null,
        'task_category_id': null,
        'color': null,
        'created_at': '2026-01-01',
        'updated_at': '2026-01-01',
      };
      final task = Task.fromJson(json);
      expect(task.date, isNull);
      expect(task.startTime, isNull);
      expect(Task.fromJson(task.toJson()), task);
    });

    test('copyWith sets nullable field to null', () {
      final task = Task(
        id: 1, name: 'T', status: TaskStatus.draft,
        date: '2026-01-01', createdAt: 'c', updatedAt: 'u',
      );
      final updated = task.copyWith(date: null);
      expect(updated.date, isNull);
      expect(updated.name, 'T'); // unchanged
    });
  });

  group('TaskCategory', () {
    test('round-trip, defaults tasksCount to 0', () {
      final json = {'id': 1, 'name': 'Work', 'color': '#00F', 'created_at': 'c', 'updated_at': 'u'};
      final cat = TaskCategory.fromJson(json);
      expect(cat.tasksCount, 0);
      expect(cat.name, 'Work');
      expect(TaskCategory.fromJson(cat.toJson()), cat);
    });

    test('tempNewUUID excluded from JSON', () {
      final cat = TaskCategory(name: 'X', color: '#F', tasksCount: 0, tempNewUUID: 'uuid-123');
      final json = cat.toJson();
      expect(json.containsKey('tempNewUUID'), isFalse);
      expect(json.containsKey('temp_new_u_u_i_d'), isFalse);
    });
  });

  group('TaskFolder', () {
    test('round-trip with nested categories', () {
      final json = {
        'id': 1, 'name': 'School',
        'categories': [
          {'id': 1, 'name': 'Math', 'color': '#F00', 'tasks_count': 5},
        ],
        'created_at': 'c', 'updated_at': 'u',
      };
      final folder = TaskFolder.fromJson(json);
      expect(folder.categories, hasLength(1));
      expect(folder.categories[0].name, 'Math');
      expect(TaskFolder.fromJson(folder.toJson()), folder);
    });

    test('defaults categories to empty list', () {
      final json = {'id': 1, 'name': 'Empty'};
      final folder = TaskFolder.fromJson(json);
      expect(folder.categories, isEmpty);
    });
  });

  group('CreateTaskRequest', () {
    test('toJson omits null fields', () {
      final req = CreateTaskRequest(name: 'Buy milk');
      final json = req.toJson();
      expect(json['name'], 'Buy milk');
      expect(json.containsKey('date'), isFalse);
      expect(json.containsKey('start_time'), isFalse);
    });
  });

  group('GetTasksRequest', () {
    test('toJson omits null fields', () {
      final req = GetTasksRequest(taskCategoryId: 5, status: TaskStatus.done);
      final json = req.toJson();
      expect(json['task_category_id'], 5);
      expect(json['status'], 'done');
      expect(json.containsKey('task_folder_id'), isFalse);
    });
  });

  group('UpdateTaskRequest', () {
    test('toJson with clearStartTime', () {
      final req = UpdateTaskRequest(clearStartTime: true);
      final json = req.toJson();
      expect(json['start_time'], isNull);
      expect(json.containsKey('start_time'), isTrue);
    });

    test('toJson omits unset fields', () {
      final req = UpdateTaskRequest(name: 'New name');
      final json = req.toJson();
      expect(json['name'], 'New name');
      expect(json.containsKey('status'), isFalse);
    });
  });
}
