import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:marquer/api/models/tasks/categories/task_category.dart';
import 'package:marquer/api/models/tasks/categories/upsert_task_category_request.dart';
import 'package:marquer/api/models/tasks/folders/task_folder.dart';
import 'package:marquer/api/services/tasks_service.dart';
import 'package:marquer/services/toast_service.dart';

final taskFoldersProvider =
    AsyncNotifierProvider<TaskFoldersAsyncNotifier, List<TaskFolder>>(
      TaskFoldersAsyncNotifier.new,
    );

class TaskFoldersAsyncNotifier extends AsyncNotifier<List<TaskFolder>> {
  final _service = TasksService();

  @override
  Future<List<TaskFolder>> build() async {
    return _service.getFolders();
  }

  void _deleteCategory(int folderId, TaskCategory category) {
    final current = state.asData?.value;
    if (current == null) return;

    bool isNew = category.tempNewUUID != null;

    state = AsyncData([
      for (final f in current)
        if (f.id == folderId)
          f.copyWith(
            categories: [
              for (final c in f.categories)
                if (isNew
                    ? c.tempNewUUID != category.tempNewUUID
                    : c.id != category.id)
                  c,
            ],
          ),
    ]);
  }

  void _updateCategory(int folderId, TaskCategory category) {
    final current = state.asData?.value;
    if (current == null) return;

    bool isNew = category.tempNewUUID != null;

    state = AsyncData([
      for (final f in current)
        if (f.id == folderId)
          f.copyWith(
            categories: [
              for (final c in f.categories)
                if (isNew
                    ? c.tempNewUUID == category.tempNewUUID
                    : c.id == category.id)
                  category
                else
                  c,
            ],
          ),
    ]);
  }

  void addCategory(int folderId, TaskCategory category) {
    final current = state.asData?.value;
    if (current == null) return;

    state = AsyncData([
      for (final folder in current)
        if (folder.id == folderId)
          folder.copyWith(categories: [...folder.categories, category])
        else
          folder,
    ]);
  }

  Future<void> updateCategory(int folderId, TaskCategory category) async {
    final current = state.asData?.value;
    if (current == null) return;

    _updateCategory(folderId, category);

    if (category.id == null) return;

    try {
      await _service.updateCategory(
        (category.id as int).toString(),
        UpsertTaskCategoryRequest(
          name: category.name,
          taskFolderId: folderId,
          color: category.color,
        ),
      );
    } catch (e) {
      state = AsyncData(current);
      ToastService.showError("Unable to update category! Try again later");
    }
  }

  void _replaceCategory(
    int folderId,
    TaskCategory oldCategory,
    TaskCategory category,
  ) {
    final current = state.asData?.value;
    if (current == null) return;

    bool isNew = oldCategory.tempNewUUID != null;

    state = AsyncData([
      for (final f in current)
        if (f.id == folderId)
          f.copyWith(
            categories: [
              for (final c in f.categories)
                if (isNew
                    ? c.tempNewUUID == oldCategory.tempNewUUID
                    : c.id == oldCategory.id)
                  category
                else
                  c,
            ],
          ),
    ]);
  }

  Future<void> saveNewCategory(int folderId, TaskCategory category) async {
    final current = state.asData?.value;
    if (current == null) return;

    try {
      final insertedCategory = await _service.createCategory(
        UpsertTaskCategoryRequest(
          name: category.name,
          color: category.color,
          taskFolderId: folderId,
        ),
      );

      _replaceCategory(folderId, category, insertedCategory);
    } catch (e) {
      state = AsyncData(current);
      debugPrint(e.toString());
      ToastService.showError("Unable to save category! Try again later");
    }
  }

  Future<void> deleteCategory(int folderId, TaskCategory category) async {
    final current = state.asData?.value;
    if (current == null) return;

    _deleteCategory(folderId, category);

    if (category.id == null) return;

    try {
      await _service.deleteCategory((category.id as int).toString());
    } catch (e) {
      state = AsyncData(current);
      debugPrint(e.toString());
      ToastService.showError("Unable to save category! Try again later");
    }
  }
}
