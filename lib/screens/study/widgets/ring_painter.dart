import 'dart:math' as math;

import 'package:flutter/material.dart';

class RingPainter extends CustomPainter {
  final double progress;
  final bool showRing;

  RingPainter({required this.progress, required this.showRing});

  @override
  void paint(Canvas canvas, Size size) {
    if (!showRing) return;

    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2 - 8;
    const strokeWidth = 8.0;

    // Background ring
    canvas.drawCircle(
      center,
      radius,
      Paint()
        ..color = Colors.white.withValues(alpha: 0.15)
        ..style = PaintingStyle.stroke
        ..strokeWidth = strokeWidth,
    );

    // Progress arc
    if (progress > 0) {
      canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius),
        -math.pi / 2,
        2 * math.pi * progress,
        false,
        Paint()
          ..color = Colors.white
          ..style = PaintingStyle.stroke
          ..strokeWidth = strokeWidth
          ..strokeCap = StrokeCap.round,
      );
    }
  }

  @override
  bool shouldRepaint(RingPainter old) =>
      old.progress != progress || old.showRing != showRing;
}
