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

  const TaskFolderItem({super.key, required this.taskFolder});

  void _addNewCategory(WidgetRef ref) {
    ref
        .read(taskFoldersProvider.notifier)
        .addCategory(
          taskFolder.id,
          TaskCategory(
            id: null,
            name: 'New category',
            color: '#fff',
            tasksCount: 0,
            tempNewUUID: Uuid().v4()
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
      title: Row(
        children: [
          Icon(Icons.folder),
          SizedBox(width: 20),
          Text(taskFolder.name),
        ],
      ),
      childrenPadding: EdgeInsets.only(left: 60, right: 20),
      children: [
        Divider(
          height: 1,
          thickness: 1,
          indent: 0,
          color: colors.onSecondary.withValues(alpha: 0.1),
        ),
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
        Padding(
          padding: EdgeInsets.only(left: 25),
          child: TextButton(
            child: const Text('New'),
            onPressed: () => _addNewCategory(ref),
          ),
        ),
      ],
    );
  }
}
