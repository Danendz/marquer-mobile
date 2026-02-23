import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:marquer/api/models/tasks/categories/task_category.dart';
import 'package:marquer/api/models/tasks/folders/task_folder.dart';
import 'package:marquer/components/tasks/task_category_item.dart';
import 'package:marquer/providers/tasks/task_folders_provider.dart';
import 'package:marquer/utils/colors.dart';
import 'package:uuid/uuid.dart';

class TaskFolderItem extends ConsumerWidget {
  final TaskFolder taskFolder;
  final VoidCallback? onLongPress;

  const TaskFolderItem({super.key, required this.taskFolder, this.onLongPress});

  void _addNewCategory(WidgetRef ref) {
    ref.read(taskFoldersProvider.notifier).addCategory(
      taskFolder.id,
      TaskCategory(
        id: null,
        name: '',
        color: '#fff',
        tasksCount: 0,
        tempNewUUID: Uuid().v4(),
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = getColors(context);
    return ExpansionTile(
      expandedCrossAxisAlignment: CrossAxisAlignment.start,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(20)),
      ),
      collapsedShape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(20)),
      ),
      collapsedBackgroundColor: colors.surfaceContainer,
      backgroundColor: colors.surfaceContainer,
      title: GestureDetector(
        onLongPress: onLongPress,
        behavior: HitTestBehavior.opaque,
        child: Row(
          children: [
            const Icon(Icons.folder_outlined),
            const SizedBox(width: 12),
            Text(taskFolder.name),
          ],
        ),
      ),
      childrenPadding: const EdgeInsets.only(left: 52, right: 16, bottom: 8),
      children: [
        const Divider(height: 1, thickness: 1),
        ...taskFolder.categories.map((category) {
          if (category.id == null) {
            return TaskCategoryItem(
              key: ValueKey(category.tempNewUUID),
              taskCategory: category,
              folderId: taskFolder.id,
              isEditable: true,
            );
          }
          return TaskCategoryItem(
            key: ValueKey(category.id),
            taskCategory: category,
            folderId: taskFolder.id,
            isEditable: false,
          );
        }),
        TextButton.icon(
          icon: const Icon(Icons.add, size: 16),
          label: const Text('New Category'),
          onPressed: () => _addNewCategory(ref),
        ),
      ],
    );
  }
}
