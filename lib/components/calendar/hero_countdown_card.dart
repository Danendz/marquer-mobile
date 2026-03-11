import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:marquer/api/models/calendar/countdown.dart';

int daysUntil(String targetDate) {
  final target = DateTime.parse(targetDate);
  final now = DateTime.now();
  final today = DateTime(now.year, now.month, now.day);
  return target.difference(today).inDays;
}

String daysLabel(int days) {
  if (days > 0) return '$days days';
  if (days == 0) return 'Today';
  return '${-days} days ago';
}

class HeroCountdownCard extends ConsumerWidget {
  final Countdown countdown;
  final VoidCallback onTap;
  final VoidCallback onLongPress;

  const HeroCountdownCard({
    super.key,
    required this.countdown,
    required this.onTap,
    required this.onLongPress,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final days = daysUntil(countdown.targetDate);
    final isPast = days < 0;

    return GestureDetector(
      onTap: onTap,
      onLongPress: onLongPress,
      child: Opacity(
        opacity: isPast ? 0.6 : 1.0,
        child: Container(
          margin: const EdgeInsets.all(16),
          height: 220,
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
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
                    colors: [Colors.transparent, Colors.black54],
                  ),
                ),
              ),
              Positioned(
                left: 20,
                right: 20,
                bottom: 20,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      countdown.name,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        shadows: [Shadow(blurRadius: 4, color: Colors.black54)],
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      daysLabel(days),
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 42,
                        fontWeight: FontWeight.bold,
                        shadows: [Shadow(blurRadius: 6, color: Colors.black87)],
                      ),
                    ),
                  ],
                ),
              ),
              if (countdown.isPinned)
                const Positioned(
                  top: 12,
                  right: 12,
                  child: Icon(Icons.push_pin, color: Colors.white, size: 20),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class CountdownListTile extends StatelessWidget {
  final Countdown countdown;
  final VoidCallback onTap;
  final VoidCallback onLongPress;

  const CountdownListTile({
    super.key,
    required this.countdown,
    required this.onTap,
    required this.onLongPress,
  });

  @override
  Widget build(BuildContext context) {
    final days = daysUntil(countdown.targetDate);
    final isPast = days < 0;
    final colors = Theme.of(context).colorScheme;

    return GestureDetector(
      onTap: onTap,
      onLongPress: onLongPress,
      child: Opacity(
        opacity: isPast ? 0.5 : 1.0,
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
          decoration: BoxDecoration(
            color: colors.surfaceContainer,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.horizontal(left: Radius.circular(16)),
                child: Image.asset(
                  'assets/timer_bg/${countdown.bgImage}',
                  width: 64,
                  height: 64,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      countdown.name,
                      style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 2),
                    Text(
                      daysLabel(days),
                      style: TextStyle(
                        fontSize: 13,
                        color: isPast ? colors.onSurface.withValues(alpha: 0.5) : colors.primary,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 12),
            ],
          ),
        ),
      ),
    );
  }
}
