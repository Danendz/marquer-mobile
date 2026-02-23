import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:marquer/api/models/tasks/tasks/task.dart';
import 'package:marquer/api/models/tasks/tasks/task_status.dart';
import 'package:marquer/providers/tasks/task_filter.dart';
import 'package:marquer/providers/tasks/task_filter_provider.dart';
import 'package:marquer/providers/tasks/tasks_provider.dart';
import 'package:marquer/utils/action_sheet.dart';
import 'package:marquer/utils/colors.dart';

class TaskItemCard extends ConsumerStatefulWidget {
  final Task task;

  const TaskItemCard({super.key, required this.task});

  @override
  ConsumerState<TaskItemCard> createState() => _TaskItemCardState();
}

class _TaskItemCardState extends ConsumerState<TaskItemCard> {
  bool get _isDone => widget.task.status == TaskStatus.done;
  bool get _isCancelled => widget.task.status == TaskStatus.cancelled;

  Future<void> _onLongPress() async {
    await HapticFeedback.mediumImpact();
    if (!mounted) return;

    final filter = ref.read(taskFilterProvider);
    final isDeletedView = filter is RecentlyDeletedFilter;

    final result = await showAppActionSheet(
      context,
      isDeletedView
          ? const [
              AppAction(value: 'restore', icon: Icons.restore_outlined, label: 'Restore'),
              AppAction(value: 'permanent_delete', icon: Icons.delete_forever_outlined, label: 'Delete Forever', isDestructive: true),
            ]
          : const [
              AppAction(value: 'edit', icon: Icons.edit_outlined, label: 'Edit'),
              AppAction(value: 'delete', icon: Icons.delete_outline, label: 'Delete', isDestructive: true),
            ],
    );

    if (!mounted || result == null) return;

    switch (result) {
      case 'edit':
        _showRenameDialog();
        break;
      case 'delete':
        ref.read(tasksProvider.notifier).deleteTask(widget.task);
        break;
      case 'restore':
        ref.read(tasksProvider.notifier).restoreTask(widget.task);
        break;
      case 'permanent_delete':
        ref.read(tasksProvider.notifier).permanentlyDelete(widget.task);
        break;
    }
  }

  Future<void> _showRenameDialog() async {
    final controller = TextEditingController(text: widget.task.name);
    try {
      await showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Rename Task'),
          content: TextField(
            controller: controller,
            autofocus: true,
            decoration: const InputDecoration(hintText: 'Task name'),
            onSubmitted: (value) {
              if (value.trim().isNotEmpty) {
                ref.read(tasksProvider.notifier).renameTask(widget.task, value.trim());
                Navigator.pop(context);
              }
            },
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                final value = controller.text.trim();
                if (value.isNotEmpty) {
                  ref.read(tasksProvider.notifier).renameTask(widget.task, value);
                  Navigator.pop(context);
                }
              },
              child: const Text('Save'),
            ),
          ],
        ),
      );
    } finally {
      controller.dispose();
    }
  }

  @override
  Widget build(BuildContext context) {
    final colors = getColors(context);

    final filter = ref.watch(taskFilterProvider);
    final isDeletedView = filter is RecentlyDeletedFilter;

    return GestureDetector(
      onTap: isDeletedView ? null : () => ref.read(tasksProvider.notifier).toggleTaskStatus(widget.task),
      onLongPress: _onLongPress,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: colors.surfaceContainer,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          children: [
            _CircleCheckbox(
              checked: _isDone,
              onTap: _isCancelled
                  ? null
                  : () => ref.read(tasksProvider.notifier).toggleTaskStatus(widget.task),
              color: colors.primary,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                widget.task.name,
                style: TextStyle(
                  fontSize: 16,
                  decoration: _isDone ? TextDecoration.lineThrough : null,
                  color: _isDone
                      ? colors.onSurface.withValues(alpha: 0.5)
                      : colors.onSurface,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _CircleCheckbox extends StatelessWidget {
  final bool checked;
  final VoidCallback? onTap;
  final Color color;

  const _CircleCheckbox({
    required this.checked,
    required this.onTap,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 24,
        height: 24,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: checked ? color : Colors.transparent,
          border: checked ? null : Border.all(color: color, width: 2),
        ),
        child: checked
            ? const Icon(Icons.check, size: 16, color: Colors.white)
            : null,
      ),
    );
  }
}
