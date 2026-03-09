import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:marquer/api/models/calendar/countdown.dart';
import 'package:marquer/providers/calendar/countdowns_provider.dart';

int _daysUntil(String targetDate) {
  final target = DateTime.parse(targetDate);
  final now = DateTime.now();
  final today = DateTime(now.year, now.month, now.day);
  return target.difference(today).inDays;
}

String _daysLabel(int days) {
  if (days > 0) return '$days days';
  if (days == 0) return 'Today';
  return '${-days} days ago';
}

class CountdownDetailScreen extends ConsumerWidget {
  final Countdown initialCountdown;

  const CountdownDetailScreen({super.key, required this.initialCountdown});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final countdowns = ref.watch(countdownsProvider).asData?.value;
    final countdown = countdowns?.firstWhere(
          (c) => c.id == initialCountdown.id,
          orElse: () => initialCountdown,
        ) ??
        initialCountdown;

    final days = _daysUntil(countdown.targetDate);

    return PopScope(
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          foregroundColor: Colors.white,
          elevation: 0,
          actions: [
            IconButton(
              icon: const Icon(Icons.settings_outlined),
              onPressed: () => context.push('/countdown/settings', extra: countdown),
            ),
          ],
        ),
        body: RefreshIndicator(
          onRefresh: () => ref.refresh(countdownsProvider.future),
          child: CustomScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            slivers: [
              SliverFillRemaining(
                hasScrollBody: false,
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    Image.asset(
                      'assets/timer_bg/${countdown.bgImage}',
                      fit: BoxFit.cover,
                    ),
                    Container(
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [Colors.black38, Colors.black87],
                        ),
                      ),
                    ),
                    SafeArea(
                      child: Column(
                        children: [
                          const Spacer(),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 32),
                            child: Column(
                              children: [
                                Text(
                                  countdown.name,
                                  style: const TextStyle(
                                    color: Colors.white70,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w500,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  _daysLabel(days),
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 72,
                                    fontWeight: FontWeight.bold,
                                    height: 1.0,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          ),
                          const Spacer(),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(24, 0, 24, 32),
                            child: FilledButton.tonal(
                              onPressed: () => context.pop(),
                              style: FilledButton.styleFrom(
                                minimumSize: const Size(double.infinity, 50),
                                backgroundColor: Colors.white24,
                                foregroundColor: Colors.white,
                              ),
                              child: const Text('More countdowns'),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
