import 'package:flutter/material.dart';
import 'package:marquer/api/models/tasks/folders/task_folder.dart';
import 'package:marquer/components/tasks/task_category_item.dart';
import 'package:marquer/utils/colors.dart';

class TaskFolderItem extends StatelessWidget {
  final TaskFolder taskFolder;

  const TaskFolderItem({super.key, required this.taskFolder});

  @override
  Widget build(BuildContext context) {
    final colors = getColors(context);
    return ExpansionTile(
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
      children: taskFolder.categories
          .map(
            (category) => TaskCategoryItem(
              key: ValueKey(category.id),
              taskCategory: category,
            ),
          )
          .toList(),
    );
  }
}
