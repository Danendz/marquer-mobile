import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:marquer/api/models/calendar/plan_for_date.dart';
import 'package:marquer/providers/calendar/day_plans_provider.dart';
import 'package:marquer/utils/colors.dart';

class PlanTaskTile extends ConsumerWidget {
  final int planId;
  final PlanTaskForDate task;

  const PlanTaskTile({super.key, required this.planId, required this.task});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = getColors(context);

    return GestureDetector(
      onTap: () => ref.read(dayPlansProvider.notifier).toggleTask(planId, task.id),
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
              checked: task.isCompleted,
              color: colors.primary,
              onTap: () => ref.read(dayPlansProvider.notifier).toggleTask(planId, task.id),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                task.name,
                style: TextStyle(
                  fontSize: 15,
                  decoration: task.isCompleted ? TextDecoration.lineThrough : null,
                  color: task.isCompleted
                      ? colors.onSurface.withValues(alpha: 0.45)
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

  const _CircleCheckbox({required this.checked, required this.onTap, required this.color});

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
        child: checked ? const Icon(Icons.check, size: 16, color: Colors.white) : null,
      ),
    );
  }
}
