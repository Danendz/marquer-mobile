import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:marquer/api/models/tasks/categories/task_category.dart';
import 'package:marquer/api/models/tasks/folders/task_folder.dart';
import 'package:marquer/api/services/tasks_service.dart';

final taskFoldersProvider = AsyncNotifierProvider<TaskFoldersAsyncNotifier, List<TaskFolder>>(
  TaskFoldersAsyncNotifier.new,
);

class TaskFoldersAsyncNotifier extends AsyncNotifier<List<TaskFolder>> {
  final _service = TasksService();

  @override
  Future<List<TaskFolder>> build() async {
    return _service.getFolders();
  }

  void deleteCategory(int folderId, int categoryId) {
    final current = state.asData?.value;
    if (current == null) return;

    state = AsyncData([
      for (final f in current)
        if (f.id == folderId)
          f.copyWith(
            categories: [
              for (final c in f.categories)
                if (c.id != categoryId) c,
            ],
          )
    ]);
  }

  void updateCategories(int folderId, List<TaskCategory> cats) {
    final current = state.asData?.value;
    if (current == null) return;

    state = AsyncData([
      for (final f in current)
        if (f.id == folderId) f.copyWith(categories: cats) else f,
    ]);
  }
}
