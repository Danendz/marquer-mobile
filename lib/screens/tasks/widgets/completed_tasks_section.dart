import 'package:flutter/material.dart';
import 'package:marquer/api/models/tasks/tasks/task.dart';
import 'package:marquer/components/tasks/task_item_card.dart';
import 'package:marquer/utils/colors.dart';

class CompletedTasksSection extends StatelessWidget {
  const CompletedTasksSection({
    super.key,
    required this.tasks,
    required this.expanded,
    required this.onToggle,
  });

  final List<Task> tasks;
  final bool expanded;
  final VoidCallback onToggle;

  @override
  Widget build(BuildContext context) {
    final colors = getColors(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: onToggle,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
            child: Row(
              children: [
                Icon(
                  expanded ? Icons.expand_less : Icons.expand_more,
                  size: 20,
                  color: colors.onSurface.withValues(alpha: 0.6),
                ),
                const SizedBox(width: 8),
                Text(
                  'Completed (${tasks.length})',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: colors.onSurface.withValues(alpha: 0.6),
                  ),
                ),
              ],
            ),
          ),
        ),
        if (expanded)
          ...tasks.map((task) => TaskItemCard(
                key: ValueKey(task.id),
                task: task,
              )),
      ],
    );
  }
}
