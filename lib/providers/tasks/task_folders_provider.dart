import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:marquer/api/models/tasks/categories/task_category.dart';
import 'package:marquer/api/models/tasks/categories/upsert_task_category_request.dart';
import 'package:marquer/api/models/tasks/folders/task_folder.dart';
import 'package:marquer/api/models/tasks/folders/upsert_task_folder_request.dart';
import 'package:marquer/api/services/tasks_service.dart';
import 'package:marquer/providers/optimistic_mutation.dart';

final taskFoldersProvider =
    AsyncNotifierProvider<TaskFoldersAsyncNotifier, List<TaskFolder>>(
      TaskFoldersAsyncNotifier.new,
    );

class TaskFoldersAsyncNotifier extends AsyncNotifier<List<TaskFolder>>
    with OptimisticMutation {
  final _service = TasksService();

  @override
  Future<List<TaskFolder>> build() async {
    return _service.getFolders();
  }

  void _deleteCategory(int folderId, TaskCategory category) {
    final current = currentValue;
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
          )
        else
          f,
    ]);
  }

  void _updateCategory(int folderId, TaskCategory category) {
    final current = currentValue;
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
          )
        else
          f,
    ]);
  }

  void addCategory(int folderId, TaskCategory category) {
    final current = currentValue;
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
    final current = currentValue;
    if (current == null) return;

    _updateCategory(folderId, category);

    if (category.id == null) return;

    await mutate(
      action: () => _service.updateCategory(
        (category.id as int).toString(),
        UpsertTaskCategoryRequest(
          name: category.name,
          taskFolderId: folderId,
          color: category.color,
        ),
      ),
      errorMessage: 'Unable to update category! Try again later',
      rollback: () => current,
    );
  }

  void _replaceCategory(
    int folderId,
    TaskCategory oldCategory,
    TaskCategory category,
  ) {
    final current = currentValue;
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
          )
        else
          f,
    ]);
  }

  Future<void> saveNewCategory(int folderId, TaskCategory category) async {
    final current = currentValue;
    if (current == null) return;

    await mutate(
      action: () => _service.createCategory(
        UpsertTaskCategoryRequest(
          name: category.name,
          color: category.color,
          taskFolderId: folderId,
        ),
      ),
      errorMessage: 'Unable to save category! Try again later',
      rollback: () => current,
      onSuccess: (latest, inserted) {
        _replaceCategory(folderId, category, inserted);
        return state.asData!.value;
      },
    );
  }

  Future<void> deleteCategory(int folderId, TaskCategory category) async {
    final current = currentValue;
    if (current == null) return;

    _deleteCategory(folderId, category);

    if (category.id == null) return;

    await mutate(
      action: () => _service.deleteCategory((category.id as int).toString()),
      errorMessage: 'Unable to delete category! Try again later',
      rollback: () => current,
    );
  }

  Future<void> createFolder(String name) async {
    final current = currentValue;
    if (current == null) return;

    await mutate(
      action: () => _service.createFolder(UpsertTaskFolderRequest(name: name)),
      errorMessage: 'Unable to create folder! Try again later',
      onSuccess: (latest, folder) => [...current, folder],
    );
  }

  Future<void> updateFolder(int folderId, String name) async {
    final current = currentValue;
    if (current == null) return;

    state = AsyncData([
      for (final f in current)
        if (f.id == folderId) f.copyWith(name: name) else f,
    ]);

    await mutate(
      action: () => _service.updateFolder(
        folderId.toString(),
        UpsertTaskFolderRequest(name: name),
      ),
      errorMessage: 'Unable to update folder! Try again later',
      rollback: () => current,
    );
  }

  Future<void> deleteFolder(int folderId) async {
    final current = currentValue;
    if (current == null) return;

    state = AsyncData([
      for (final f in current) if (f.id != folderId) f,
    ]);

    await mutate(
      action: () => _service.deleteFolder(folderId.toString()),
      errorMessage: 'Unable to delete folder! Try again later',
      rollback: () => current,
    );
  }
}
