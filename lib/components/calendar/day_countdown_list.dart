import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:marquer/providers/calendar/calendar_selected_date_provider.dart';
import 'package:marquer/utils/format.dart';
import 'package:marquer/providers/calendar/countdowns_provider.dart';

class DayCountdownList extends ConsumerWidget {
  const DayCountdownList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedDate = ref.watch(calendarSelectedDateProvider);
    final countdownsAsync = ref.watch(countdownsProvider);

    final countdowns = countdownsAsync.asData?.value;
    if (countdowns == null) return const SizedBox.shrink();

    final key = formatDate(selectedDate);
    final matching = countdowns.where((c) => c.targetDate == key).toList();

    final colors = Theme.of(context).colorScheme;

    return AnimatedSize(
      duration: const Duration(milliseconds: 200),
      curve: Curves.easeInOut,
      child: matching.isEmpty
          ? const SizedBox.shrink()
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 8, 16, 4),
                  child: Text(
                    'Countdowns',
                    style: Theme.of(context).textTheme.labelMedium?.copyWith(
                      color: colors.onSurface.withValues(alpha: 0.6),
                    ),
                  ),
                ),
                ...matching.map((countdown) {
                  return GestureDetector(
                    onTap: () => context.push('/countdown/detail', extra: countdown),
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                      decoration: BoxDecoration(
                        color: colors.surfaceContainer,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        children: [
                          ClipRRect(
                            borderRadius: const BorderRadius.horizontal(left: Radius.circular(12)),
                            child: Image.asset(
                              'assets/timer_bg/${countdown.bgImage}',
                              width: 56,
                              height: 56,
                              fit: BoxFit.cover,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Text(
                              countdown.name,
                              style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 12),
                            child: Text(
                              'Today',
                              style: TextStyle(
                                fontSize: 13,
                                color: colors.primary,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }),
              ],
            ),
    );
  }
}
