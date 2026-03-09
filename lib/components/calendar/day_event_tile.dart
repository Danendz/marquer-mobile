import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:marquer/api/models/tasks/tasks/task.dart';
import 'package:marquer/api/models/tasks/tasks/task_status.dart';
import 'package:marquer/api/models/tasks/tasks/update_task_request.dart';
import 'package:marquer/components/shared/circle_checkbox.dart';
import 'package:marquer/components/shared/status_chip.dart';
import 'package:marquer/components/shared/task_edit_sheet.dart';
import 'package:marquer/providers/calendar/calendar_day_events_provider.dart';
import 'package:marquer/utils/action_sheet.dart';
import 'package:marquer/utils/colors.dart';

class DayEventTile extends ConsumerStatefulWidget {
  final Task task;

  const DayEventTile({super.key, required this.task});

  @override
  ConsumerState<DayEventTile> createState() => _DayEventTileState();
}

class _DayEventTileState extends ConsumerState<DayEventTile> {
  bool get _isDone => widget.task.status == TaskStatus.done;

  Future<void> _onLongPress() async {
    await HapticFeedback.mediumImpact();
    if (!mounted) return;

    final result = await showAppActionSheet(context, const [
      AppAction(value: 'edit', icon: Icons.edit_outlined, label: 'Edit'),
      AppAction(value: 'delete', icon: Icons.delete_outline, label: 'Delete', isDestructive: true),
    ]);

    if (!mounted || result == null) return;

    switch (result) {
      case 'edit':
        _showEditSheet();
      case 'delete':
        ref.read(calendarDayEventsProvider.notifier).deleteEvent(widget.task);
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
          ref.read(calendarDayEventsProvider.notifier).updateEvent(widget.task, request, optimistic);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final colors = getColors(context);
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    final hasTime = widget.task.startTime != null;

    return GestureDetector(
      onTap: () => ref.read(calendarDayEventsProvider.notifier).toggleEvent(widget.task),
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
                  onTap: () => ref.read(calendarDayEventsProvider.notifier).toggleEvent(widget.task),
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
            // Row 2: time range (only if set)
            if (hasTime) ...[
              const SizedBox(height: 4),
              Padding(
                padding: const EdgeInsets.only(left: 36),
                child: Row(
                  children: [
                    Icon(Icons.access_time, size: 12, color: colorScheme.onSurfaceVariant),
                    const SizedBox(width: 4),
                    Text(
                      _formatTimeRange(widget.task.startTime, widget.task.endTime),
                      style: textTheme.bodySmall?.copyWith(color: colorScheme.onSurfaceVariant),
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
}
