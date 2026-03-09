import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:marquer/api/models/tasks/categories/task_category.dart';
import 'package:marquer/api/models/tasks/tasks/task.dart';
import 'package:marquer/api/models/tasks/tasks/task_status.dart';
import 'package:marquer/api/models/tasks/tasks/update_task_request.dart';
import 'package:marquer/components/shared/circle_checkbox.dart';
import 'package:marquer/components/shared/status_chip.dart';
import 'package:marquer/components/shared/task_edit_sheet.dart';
import 'package:marquer/providers/tasks/task_filter.dart';
import 'package:marquer/providers/tasks/task_filter_provider.dart';
import 'package:marquer/providers/tasks/task_folders_provider.dart';
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
        _showEditSheet();
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

  void _showEditSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => TaskEditSheet(
        task: widget.task,
        onSave: (name, startTime, endTime, clearStartTime, clearEndTime) {
          final request = UpdateTaskRequest(
            name: name != widget.task.name ? name : null,
            startTime: startTime,
            endTime: endTime,
            clearStartTime: clearStartTime,
            clearEndTime: clearEndTime,
          );
          final optimistic = widget.task.copyWith(
            name: name,
            startTime: startTime,
            endTime: endTime,
          );
          ref.read(tasksProvider.notifier).updateTask(widget.task, request, optimistic);
        },
      ),
    );
  }

  TaskCategory? _findCategory(WidgetRef ref, int? id) {
    if (id == null) return null;
    final foldersAsync = ref.watch(taskFoldersProvider);
    return foldersAsync.asData?.value
        .expand((f) => f.categories)
        .where((c) => c.id == id)
        .firstOrNull;
  }

  @override
  Widget build(BuildContext context) {
    final colors = getColors(context);
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    final filter = ref.watch(taskFilterProvider);
    final isDeletedView = filter is RecentlyDeletedFilter;

    final category = _findCategory(ref, widget.task.taskCategoryId);

    final hasTime = widget.task.startTime != null;
    final hasDate = widget.task.date != null;
    final hasSubtitle = hasTime || hasDate;
    final hasCategory = category != null;

    return GestureDetector(
      onTap: (isDeletedView || _isCancelled) ? null : () => ref.read(tasksProvider.notifier).toggleTaskStatus(widget.task),
      onLongPress: _onLongPress,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: colors.surfaceContainer,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            // Row 1: checkbox + name + status chip
            Row(
              children: [
                CircleCheckbox(
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
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                      decoration: _isDone ? TextDecoration.lineThrough : null,
                      color: _isDone
                          ? colorScheme.onSurface.withValues(alpha: 0.5)
                          : colorScheme.onSurface,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                StatusChip(status: widget.task.status, colorScheme: colorScheme),
              ],
            ),
            // Row 2: time + date (only if present)
            if (hasSubtitle) ...[
              const SizedBox(height: 4),
              Padding(
                padding: const EdgeInsets.only(left: 36),
                child: Row(
                  children: [
                    Icon(Icons.access_time, size: 12, color: colorScheme.onSurfaceVariant),
                    const SizedBox(width: 4),
                    if (hasTime)
                      Text(
                        _formatTimeRange(widget.task.startTime, widget.task.endTime),
                        style: textTheme.bodySmall?.copyWith(color: colorScheme.onSurfaceVariant),
                      ),
                    if (hasTime && hasDate) ...[
                      Text(
                        ' · ',
                        style: textTheme.bodySmall?.copyWith(color: colorScheme.onSurfaceVariant),
                      ),
                    ],
                    if (hasDate)
                      Text(
                        _formatDate(widget.task.date!),
                        style: textTheme.bodySmall?.copyWith(color: colorScheme.onSurfaceVariant),
                      ),
                  ],
                ),
              ),
            ],
            // Row 3: category (only if present)
            if (hasCategory) ...[
              const SizedBox(height: 4),
              Padding(
                padding: const EdgeInsets.only(left: 36),
                child: Row(
                  children: [
                    Icon(Icons.folder_outlined, size: 12, color: colorScheme.onSurfaceVariant),
                    const SizedBox(width: 4),
                    Text(
                      category.name,
                      style: textTheme.bodySmall?.copyWith(color: colorScheme.onSurfaceVariant),
                    ),
                    const SizedBox(width: 6),
                    Container(
                      width: 8,
                      height: 8,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: _parseColor(category.color),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  String _formatTimeRange(String? start, String? end) {
    if (start == null) return '';
    if (end == null) return start;
    return '$start – $end';
  }

  String _formatDate(String date) {
    try {
      final dt = DateTime.parse(date);
      return DateFormat('MMM d').format(dt);
    } catch (_) {
      return date;
    }
  }

  Color _parseColor(String hex) {
    try {
      final cleaned = hex.replaceFirst('#', '');
      final value = int.parse(cleaned.length == 6 ? 'FF$cleaned' : cleaned, radix: 16);
      return Color(value);
    } catch (_) {
      return Colors.grey;
    }
  }
}
