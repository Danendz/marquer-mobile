import 'package:flutter/material.dart';
import 'package:marquer/api/models/tasks/categories/task_category.dart';
import 'package:marquer/utils/colors.dart';

class TaskCategoryItem extends StatelessWidget {
  final TaskCategory taskCategory;

  const TaskCategoryItem({super.key, required this.taskCategory});

  @override
  Widget build(BuildContext context) {
    final colors = getColors(context);
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          children: [
            Container(
              width: 10,
              height: 20,
              decoration: BoxDecoration(
                color: colorFromHex(taskCategory.color),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(2),
                  bottomLeft: Radius.circular(2),
                ),
              ),
            ),
            Container(
              width: 10,
              height: 20,
              decoration: BoxDecoration(
                color: colorFromHex(taskCategory.color).withValues(alpha: 0.5),
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(2),
                  bottomRight: Radius.circular(2),
                ),
              ),
            ),
          ],
        ),

        const SizedBox(width: 15),

        Expanded(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(5),
                    topLeft: Radius.circular(5),
                  ),
                ),
                contentPadding: const EdgeInsets.only(left: 10, right: 10),
                title: Row(
                  children: [
                    Text(taskCategory.name),
                    Spacer(),
                    Text(taskCategory.tasksCount.toString()),
                  ],
                ),
                onTap: () {},
              ),
              Divider(
                height: 1,
                thickness: 1,
                indent: 10,
                color: colors.onSecondary.withValues(alpha: 0.1),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
