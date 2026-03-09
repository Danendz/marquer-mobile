import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:marquer/components/calendar/plan_task_tile.dart';
import 'package:marquer/providers/calendar/day_plans_provider.dart';

class DayPlanList extends ConsumerWidget {
  const DayPlanList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final plansAsync = ref.watch(dayPlansProvider);

    final plans = plansAsync.asData?.value;
    if (plans == null || plans.isEmpty) return const SizedBox.shrink();

    final colors = Theme.of(context).colorScheme;

    return AnimatedSize(
      duration: const Duration(milliseconds: 200),
      curve: Curves.easeInOut,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          for (final plan in plans) ...[
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 2),
              child: Text(
                plan.name,
                style: Theme.of(context).textTheme.labelMedium?.copyWith(
                  color: colors.onSurface.withValues(alpha: 0.6),
                ),
              ),
            ),
            for (final task in plan.tasks)
              PlanTaskTile(planId: plan.id, task: task),
          ],
        ],
      ),
    );
  }
}
