import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:marquer/api/models/calendar/plan_for_date.dart';
import 'package:marquer/components/shared/circle_checkbox.dart';
import 'package:marquer/providers/calendar/day_plans_provider.dart';
import 'package:marquer/utils/colors.dart';
import 'package:marquer/utils/format.dart';

class PlanTaskTile extends ConsumerWidget {
  final int planId;
  final PlanTaskForDate task;
  final String? planColor;

  const PlanTaskTile({super.key, required this.planId, required this.task, this.planColor});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = getColors(context);
    final colorScheme = Theme.of(context).colorScheme;
    final checkColor = planColor != null ? hexToColor(planColor!) : colors.primary;
    final textTheme = Theme.of(context).textTheme;

    final hasTime = task.startTime != null;

    return Container(
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
            // Row 1: checkbox + name
            Row(
              children: [
                CircleCheckbox(
                  checked: task.isCompleted,
                  color: checkColor,
                  onTap: () => ref.read(dayPlansProvider.notifier).toggleTask(planId, task.id),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    task.name,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                      decoration: task.isCompleted ? TextDecoration.lineThrough : null,
                      color: task.isCompleted
                          ? colorScheme.onSurface.withValues(alpha: 0.5)
                          : colorScheme.onSurface,
                    ),
                  ),
                ),
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
                      formatTimeRange(task.startTime, task.endTime),
                      style: textTheme.bodySmall?.copyWith(color: colorScheme.onSurfaceVariant),
                    ),
                  ],
                ),
              ),
            ],
          ],
        ),
    );
  }

}
