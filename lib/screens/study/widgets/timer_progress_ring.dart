import 'package:flutter/material.dart';
import 'package:marquer/api/models/study/timer_mode.dart';
import 'package:marquer/providers/study/timer_state.dart';
import 'package:marquer/screens/study/widgets/ring_painter.dart';

class TimerProgressRing extends StatelessWidget {
  final TimerState s;
  final Animation<double> breathAnim;
  final Animation<double> progressCurve;
  final double progressStart;
  final double progressEnd;
  final String timeText;

  const TimerProgressRing({
    super.key,
    required this.s,
    required this.breathAnim,
    required this.progressCurve,
    required this.progressStart,
    required this.progressEnd,
    required this.timeText,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: Listenable.merge([breathAnim, progressCurve]),
      builder: (context, _) {
        final scale = s.isRunning ? breathAnim.value : 1.0;
        final progress =
            (progressStart + (progressEnd - progressStart) * progressCurve.value)
                .clamp(0.0, 1.0);
        return Transform.scale(
          scale: scale,
          child: SizedBox(
            width: 220,
            height: 220,
            child: Stack(
              alignment: Alignment.center,
              children: [
                SizedBox.expand(
                  child: CustomPaint(
                    painter: RingPainter(
                      progress: progress,
                      showRing: s.mode != TimerMode.countUp,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Text(
                      timeText,
                      style: Theme.of(context).textTheme.displayLarge?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontFeatures: [const FontFeature.tabularFigures()],
                        shadows: [
                          Shadow(
                            color: Colors.black.withValues(alpha: 0.5),
                            blurRadius: 8,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
