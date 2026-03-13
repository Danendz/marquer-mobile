import 'package:flutter/material.dart';
import 'package:marquer/providers/study/timer_provider.dart';

class TimerPhaseIndicator extends StatelessWidget {
  final TimerState s;
  final String phaseLabel;

  const TimerPhaseIndicator({
    super.key,
    required this.s,
    required this.phaseLabel,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          phaseLabel,
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
            color: Colors.white,
            fontWeight: FontWeight.w600,
            shadows: [
              Shadow(
                color: Colors.black.withValues(alpha: 0.5),
                blurRadius: 4,
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'Cycle ${s.completedCycles}/${s.totalCycles}',
          style: Theme.of(
            context,
          ).textTheme.bodyLarge?.copyWith(color: Colors.white70),
        ),
        const SizedBox(height: 32),
      ],
    );
  }
}
