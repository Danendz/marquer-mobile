import 'dart:async';

import 'package:flutter/material.dart';
import 'package:marquer/components/calendar/week_view/week_view_constants.dart';

class CurrentTimeIndicator extends StatefulWidget {
  final ColorScheme colorScheme;

  const CurrentTimeIndicator({super.key, required this.colorScheme});

  @override
  State<CurrentTimeIndicator> createState() => _CurrentTimeIndicatorState();
}

class _CurrentTimeIndicatorState extends State<CurrentTimeIndicator> {
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(minutes: 1), (_) => setState(() {}));
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final minutes = now.hour * 60 + now.minute;
    final top = minutes * kPixelsPerMinute;

    return Positioned(
      top: top,
      left: kTimeGutter - 4,
      right: 0,
      child: Row(
        children: [
          Container(
            width: 8,
            height: 8,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: widget.colorScheme.primary,
            ),
          ),
          Expanded(
            child: Container(height: 1.5, color: widget.colorScheme.primary),
          ),
        ],
      ),
    );
  }
}
