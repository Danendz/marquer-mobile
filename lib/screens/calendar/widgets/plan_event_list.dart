import 'package:flutter/material.dart';
import 'package:marquer/utils/format.dart';

class PlanTaskItem {
  final int? id;
  String name;
  int sortOrder;
  String? startTime;
  String? endTime;

  PlanTaskItem({this.id, required this.name, required this.sortOrder, this.startTime, this.endTime});

  TimeOfDay? get startTimeOfDay {
    if (startTime == null) return null;
    final parts = startTime!.split(':');
    return TimeOfDay(hour: int.parse(parts[0]), minute: int.parse(parts[1]));
  }

  TimeOfDay? get endTimeOfDay {
    if (endTime == null) return null;
    final parts = endTime!.split(':');
    return TimeOfDay(hour: int.parse(parts[0]), minute: int.parse(parts[1]));
  }

  void setStartTime(TimeOfDay? t) {
    startTime = t != null ? formatTimeOfDay(t) : null;
  }

  void setEndTime(TimeOfDay? t) {
    endTime = t != null ? formatTimeOfDay(t) : null;
  }
}

class PlanEventList extends StatelessWidget {
  final List<PlanTaskItem> tasks;
  final void Function(int index) onEdit;
  final void Function(int index) onDelete;

  const PlanEventList({
    super.key,
    required this.tasks,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    if (tasks.isEmpty) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: Center(
          child: Text(
            'No events yet. Tap Add to create one.',
            style: TextStyle(color: colors.onSurface.withValues(alpha: 0.5)),
          ),
        ),
      );
    }
    return Column(
      children: [
        for (int index = 0; index < tasks.length; index++)
          _buildTile(context, index, colors),
      ],
    );
  }

  Widget _buildTile(BuildContext context, int index, ColorScheme colors) {
    final task = tasks[index];
    return GestureDetector(
      onTap: () => onEdit(index),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: colors.surfaceContainer,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          children: [
            Icon(Icons.circle_outlined, size: 20, color: colors.onSurface.withValues(alpha: 0.4)),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    task.name,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600),
                  ),
                  if (task.startTime != null) ...[
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        Icon(Icons.access_time, size: 12, color: colors.onSurfaceVariant),
                        const SizedBox(width: 4),
                        Text(
                          formatTimeRange(task.startTime, task.endTime),
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(color: colors.onSurfaceVariant),
                        ),
                      ],
                    ),
                  ],
                ],
              ),
            ),
            IconButton(
              icon: const Icon(Icons.delete_outline, size: 20),
              onPressed: () => onDelete(index),
              visualDensity: VisualDensity.compact,
            ),
          ],
        ),
      ),
    );
  }
}
