import 'package:get_it/get_it.dart';
import 'package:marquer/api/api.dart';
import 'package:marquer/api/models/tasks/categories/upsert_task_category_request.dart';
import 'package:marquer/api/models/tasks/folders/task_folder.dart';
import 'package:marquer/api/models/tasks/folders/upsert_task_folder_request.dart';
import 'package:marquer/api/models/tasks/tasks/create_task_request.dart';
import 'package:marquer/api/models/tasks/tasks/get_tasks_request.dart';
import 'package:marquer/api/models/tasks/tasks/task.dart';
import 'package:marquer/api/models/tasks/tasks/update_task_request.dart';

import '../models/model_parser.dart';

final getIt = GetIt.instance;

final class TasksService {
  final api = getIt<ApiService>(instanceName: 'api');

  // Folders api
  Future<List<TaskFolder>> getFolders() async {
    final resp = await api.get<List<TaskFolder>>(
      '/task-folders',
      fromJsonT: (json) => ModelParser.listFromJson(json, TaskFolder.fromJson),
    );

    return resp.data;
  }

  Future<TaskFolder> createFolder(UpsertTaskFolderRequest request) async {
    final resp = await api.post<TaskFolder>(
      '/task-folders',
      body: request,
      fromJsonT: (json) => ModelParser.objectFromJson(json, TaskFolder.fromJson),
    );

    return resp.data;
  }

  Future<TaskFolder> updateFolder(String id, UpsertTaskFolderRequest request) async {
    final resp = await api.put<TaskFolder>(
      '/task-folders/$id',
      body: request,
      fromJsonT: (json) => ModelParser.objectFromJson(json, TaskFolder.fromJson),
    );

    return resp.data;
  }

  Future<Null> deleteFolder(String id) async {
    final resp = await api.delete('/task-folders/$id');

    return resp.data;
  }

  // Categories api
  Future<TaskFolder> createCategory(UpsertTaskCategoryRequest request) async {
    final resp = await api.post<TaskFolder>(
      '/task-categories',
      body: request,
      fromJsonT: (json) => ModelParser.objectFromJson(json, TaskFolder.fromJson),
    );

    return resp.data;
  }

  Future<TaskFolder> updateCategory(String id, UpsertTaskCategoryRequest request) async {
    final resp = await api.put<TaskFolder>(
      '/task-categories/$id',
      body: request,
      fromJsonT: (json) => ModelParser.objectFromJson(json, TaskFolder.fromJson),
    );

    return resp.data;
  }

  Future<Null> deleteCategory(String id) async {
    final resp = await api.delete('/task-categories/$id');

    return resp.data;
  }

  // Tasks api
  Future<List<Task>> getTasks(GetTasksRequest request) async {
    final resp = await api.get<List<Task>>(
      '/tasks',
      query: request.toJson(),
      fromJsonT: (json) => ModelParser.listFromJson(json, Task.fromJson),
    );

    return resp.data;
  }

  Future<Task> createTask(CreateTaskRequest request) async {
    final resp = await api.post<Task>(
      '/tasks',
      body: request,
      fromJsonT: (json) => ModelParser.objectFromJson(json, Task.fromJson),
    );

    return resp.data;
  }

  Future<Task> updateTask(String id, UpdateTaskRequest request) async {
    final resp = await api.put<Task>(
      '/tasks/$id',
      body: request,
      fromJsonT: (json) => ModelParser.objectFromJson(json, Task.fromJson),
    );

    return resp.data;
  }

  Future<Null> deleteTask(String id) async {
    final resp = await api.delete('/tasks/$id');

    return resp.data;
  }
}
