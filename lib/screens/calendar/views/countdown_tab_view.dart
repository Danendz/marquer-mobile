import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:marquer/api/models/calendar/countdown.dart';
import 'package:marquer/components/calendar/hero_countdown_card.dart';
import 'package:marquer/providers/calendar/countdowns_provider.dart';

class CountdownTabView extends ConsumerWidget {
  final void Function(Countdown) onLongPress;

  const CountdownTabView({super.key, required this.onLongPress});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final countdownsAsync = ref.watch(countdownsProvider);

    return RefreshIndicator(
      onRefresh: () => ref.refresh(countdownsProvider.future),
      child: countdownsAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, st) => const Center(child: Text('Failed to load countdowns')),
        data: (countdowns) {
          if (countdowns.isEmpty) {
            return const SingleChildScrollView(
              physics: AlwaysScrollableScrollPhysics(),
              child: Padding(
                padding: EdgeInsets.only(top: 200),
                child: Center(child: Text('No countdowns yet')),
              ),
            );
          }

          final pinned = countdowns.firstWhere(
            (c) => c.isPinned,
            orElse: () => countdowns.reduce(
              (a, b) => DateTime.parse(a.targetDate).isBefore(DateTime.parse(b.targetDate)) ? a : b,
            ),
          );
          final rest = countdowns.where((c) => c.id != pinned.id).toList();
          final listKey = countdowns.map((c) => c.id).join(',');

          return SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            padding: const EdgeInsets.only(bottom: 100),
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 200),
              switchInCurve: Curves.easeInOut,
              switchOutCurve: Curves.easeInOut,
              transitionBuilder: (child, animation) => FadeTransition(opacity: animation, child: child),
              child: Column(
                key: ValueKey(listKey),
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  HeroCountdownCard(
                    countdown: pinned,
                    onTap: () => context.push('/countdown/detail', extra: pinned),
                    onLongPress: () => onLongPress(pinned),
                  ),
                  if (rest.isNotEmpty) ...[
                    const SizedBox(height: 8),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: rest.length,
                      itemBuilder: (context, index) => CountdownListTile(
                        countdown: rest[index],
                        onTap: () => context.push('/countdown/detail', extra: rest[index]),
                        onLongPress: () => onLongPress(rest[index]),
                      ),
                    ),
                  ],
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
