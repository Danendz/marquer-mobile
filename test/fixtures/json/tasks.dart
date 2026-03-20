/// Task fixture data for tests.
library;

const Map<String, dynamic> taskJson1 = {
  'id': 1,
  'name': 'Buy groceries',
  'status': 'draft',
  'date': '2026-03-19',
  'start_time': '10:00',
  'end_time': '11:00',
  'task_category_id': 5,
  'color': '#FF5733',
  'created_at': '2026-03-18T08:00:00.000000Z',
  'updated_at': '2026-03-18T08:00:00.000000Z',
};

const Map<String, dynamic> taskJson2 = {
  'id': 2,
  'name': 'Finish homework',
  'status': 'done',
  'date': null,
  'start_time': null,
  'end_time': null,
  'task_category_id': null,
  'color': null,
  'created_at': '2026-03-17T12:00:00.000000Z',
  'updated_at': '2026-03-18T09:30:00.000000Z',
};

const Map<String, dynamic> taskJson3 = {
  'id': 3,
  'name': 'Read a book',
  'status': 'progress',
  'date': '2026-03-20',
  'start_time': null,
  'end_time': null,
  'task_category_id': 5,
  'color': null,
  'created_at': '2026-03-16T14:00:00.000000Z',
  'updated_at': '2026-03-18T10:00:00.000000Z',
};

/// A typical successful API response wrapping a list of tasks.
Map<String, dynamic> tasksListResponse({
  List<Map<String, dynamic>> tasks = const [taskJson1, taskJson2, taskJson3],
}) =>
    {
      'status': 200,
      'success': true,
      'message': 'Tasks fetched successfully',
      'data': tasks,
    };

/// A typical successful API response wrapping a single task.
Map<String, dynamic> singleTaskResponse({
  Map<String, dynamic> task = taskJson1,
}) =>
    {
      'status': 200,
      'success': true,
      'message': 'Task created successfully',
      'data': task,
    };
