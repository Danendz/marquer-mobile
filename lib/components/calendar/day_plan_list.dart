import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:marquer/components/calendar/plan_task_tile.dart';
import 'package:marquer/providers/calendar/day_plans_provider.dart';
import 'package:marquer/utils/colors.dart';

class DayPlanList extends ConsumerStatefulWidget {
  const DayPlanList({super.key});

  @override
  ConsumerState<DayPlanList> createState() => _DayPlanListState();
}

class _DayPlanListState extends ConsumerState<DayPlanList> {
  final Set<int> _collapsed = {};

  @override
  Widget build(BuildContext context) {
    final plansAsync = ref.watch(dayPlansProvider);

    final plans = plansAsync.asData?.value;
    if (plans == null || plans.isEmpty) return const SizedBox.shrink();

    final colorScheme = Theme.of(context).colorScheme;

    return AnimatedSize(
      duration: const Duration(milliseconds: 200),
      curve: Curves.easeInOut,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          for (final plan in plans) ...[
            GestureDetector(
              onTap: () => setState(() {
                if (_collapsed.contains(plan.id)) {
                  _collapsed.remove(plan.id);
                } else {
                  _collapsed.add(plan.id);
                }
              }),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 10, 16, 2),
                child: Row(
                  children: [
                    Container(
                      width: 10,
                      height: 10,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: plan.color != null
                            ? hexToColor(plan.color!)
                            : Colors.amber,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        plan.name,
                        style: Theme.of(context).textTheme.titleSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Text(
                      '(${plan.tasks.length})',
                      style: TextStyle(
                        fontSize: 12,
                        color: colorScheme.onSurface.withValues(alpha: 0.5),
                      ),
                    ),
                    const SizedBox(width: 4),
                    Icon(
                      _collapsed.contains(plan.id)
                          ? Icons.expand_more
                          : Icons.expand_less,
                      size: 18,
                      color: colorScheme.onSurface.withValues(alpha: 0.5),
                    ),
                  ],
                ),
              ),
            ),
            if (!_collapsed.contains(plan.id))
              for (final task in plan.tasks)
                PlanTaskTile(planId: plan.id, task: task, planColor: plan.color),
          ],
        ],
      ),
    );
  }
}
