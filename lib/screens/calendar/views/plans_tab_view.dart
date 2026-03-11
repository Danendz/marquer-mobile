import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:marquer/api/models/calendar/plan.dart';
import 'package:marquer/providers/calendar/plans_provider.dart';
import 'package:marquer/utils/colors.dart';

class PlansTabView extends ConsumerWidget {
  final void Function(Plan) onLongPress;
  final void Function(Plan) onEdit;

  const PlansTabView({super.key, required this.onLongPress, required this.onEdit});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final plansAsync = ref.watch(plansProvider);
    final colors = getColors(context);

    return RefreshIndicator(
      onRefresh: () => ref.refresh(plansProvider.future),
      child: plansAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, st) => const Center(child: Text('Failed to load plans')),
        data: (plans) {
          if (plans.isEmpty) {
            return const SingleChildScrollView(
              physics: AlwaysScrollableScrollPhysics(),
              child: Padding(
                padding: EdgeInsets.only(top: 200),
                child: Center(child: Text('No plans yet')),
              ),
            );
          }

          return ListView.builder(
            physics: const AlwaysScrollableScrollPhysics(),
            padding: const EdgeInsets.only(bottom: 100),
            itemCount: plans.length,
            itemBuilder: (context, index) {
              final plan = plans[index];
              return Opacity(
                opacity: plan.isActive ? 1.0 : 0.5,
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                  decoration: BoxDecoration(
                    color: colors.surfaceContainer,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: ListTile(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                    title: Text(plan.name, style: const TextStyle(fontWeight: FontWeight.w600)),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(plan.schedule.label, style: TextStyle(color: colors.primary, fontSize: 12)),
                        Text(
                          '${plan.tasks.length} task${plan.tasks.length != 1 ? 's' : ''}',
                          style: TextStyle(color: colors.onSurface.withValues(alpha: 0.6), fontSize: 12),
                        ),
                      ],
                    ),
                    onTap: () => onEdit(plan),
                    onLongPress: () => onLongPress(plan),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
