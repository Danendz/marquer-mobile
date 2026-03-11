import 'package:flutter/material.dart';
import 'package:marquer/components/calendar/week_view/week_view_constants.dart';

class TimeGrid extends StatelessWidget {
  final ColorScheme colorScheme;
  final int hourInterval;

  const TimeGrid({super.key, required this.colorScheme, this.hourInterval = 1});

  @override
  Widget build(BuildContext context) {
    final count = 24 ~/ hourInterval;
    return SizedBox(
      width: kTimeGutter,
      child: Stack(
        children: List.generate(count, (i) {
          final hour = i * hourInterval;
          return Positioned(
            top: (hour * kPixelsPerHour - 7).clamp(0.0, double.infinity),
            left: 0,
            right: 4,
            child: Text(
              '${hour.toString().padLeft(2, '0')}:00',
              textAlign: TextAlign.right,
              style: TextStyle(
                fontSize: 9,
                color: colorScheme.onSurface.withValues(alpha: 0.4),
              ),
            ),
          );
        }),
      ),
    );
  }
}
