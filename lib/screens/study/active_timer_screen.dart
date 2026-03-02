import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:marquer/api/models/study/study_session.dart';
import 'package:marquer/api/models/study/timer_mode.dart';
import 'package:marquer/providers/study/timer_provider.dart';

class ActiveTimerScreen extends ConsumerStatefulWidget {
  final StudySession session;

  const ActiveTimerScreen({super.key, required this.session});

  @override
  ConsumerState<ActiveTimerScreen> createState() => _ActiveTimerScreenState();
}

class _ActiveTimerScreenState extends ConsumerState<ActiveTimerScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _breathController;
  late Animation<double> _breathAnim;

  @override
  void initState() {
    super.initState();
    _breathController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..repeat(reverse: true);
    _breathAnim = Tween<double>(begin: 1.0, end: 1.03).animate(
      CurvedAnimation(parent: _breathController, curve: Curves.easeInOut),
    );
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final timerState = ref.read(timerProvider);
      if (timerState.serverSession?.id != widget.session.id) {
        // Session not yet loaded (app restart or first navigation without start())
        ref.read(timerProvider.notifier).loadFromSession(widget.session);
      }
      // else: start() was already called by CreateSessionSheet — do nothing
    });
  }

  @override
  void dispose() {
    _breathController.dispose();
    super.dispose();
  }

  String _formatTime(int seconds) {
    final h = seconds ~/ 3600;
    final m = (seconds % 3600) ~/ 60;
    final s = seconds % 60;
    if (h > 0) {
      return '${h.toString().padLeft(2, '0')}:${m.toString().padLeft(2, '0')}:${s.toString().padLeft(2, '0')}';
    }
    return '${m.toString().padLeft(2, '0')}:${s.toString().padLeft(2, '0')}';
  }

  String _phaseLabel(TimerState s) {
    switch (s.phase) {
      case TimerPhase.work:
        return 'Work';
      case TimerPhase.shortBreak:
        return 'Short Break';
      case TimerPhase.longBreak:
        return 'Long Break';
      case TimerPhase.idle:
        return '';
    }
  }

  Future<void> _confirmEnd(
    BuildContext context,
    TimerNotifier notifier,
  ) async {
    final router = GoRouter.of(context);
    final confirm = await showDialog<bool>(
      context: context,
      builder:
          (ctx) => AlertDialog(
            title: const Text('End Session?'),
            content: const Text('Complete the current study session?'),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(ctx).pop(false),
                child: const Text('Cancel'),
              ),
              ElevatedButton(
                onPressed: () => Navigator.of(ctx).pop(true),
                child: const Text('Complete'),
              ),
            ],
          ),
    );
    if (confirm == true && mounted) {
      await notifier.complete();
      if (mounted) router.go('/');
    }
  }

  Widget _buildGlassButton({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
    Color iconColor = Colors.white,
    Color labelColor = Colors.white,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 90,
        height: 90,
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.12),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: Colors.white.withValues(alpha: 0.15),
            width: 1,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 28, color: iconColor),
            const SizedBox(height: 6),
            Text(
              label,
              style: TextStyle(
                color: labelColor,
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProgressRing(TimerState s) {
    double progress = 0.0;
    if (s.mode == TimerMode.countDown &&
        s.targetSeconds != null &&
        s.targetSeconds! > 0) {
      progress = s.elapsedSeconds / s.targetSeconds!;
    } else if (s.mode == TimerMode.pomodoro &&
        s.currentPhaseTotalSeconds > 0) {
      progress = s.phaseElapsedSeconds / s.currentPhaseTotalSeconds;
    }
    progress = progress.clamp(0.0, 1.0);

    final timeText = s.mode == TimerMode.countUp
        ? _formatTime(s.elapsedSeconds)
        : _formatTime(s.remainingSeconds);

    return AnimatedBuilder(
      animation: _breathAnim,
      builder: (context, _) {
        final scale = s.isRunning ? _breathAnim.value : 1.0;
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
                    painter: _RingPainter(
                      progress: progress,
                      showRing: s.mode != TimerMode.countUp,
                    ),
                  ),
                ),
                Text(
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
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final s = ref.watch(timerProvider);
    final notifier = ref.read(timerProvider.notifier);

    // Sync breathing animation with running state
    ref.listen(timerProvider.select((ts) => ts.isRunning), (_, isRunning) {
      if (isRunning && !_breathController.isAnimating) {
        _breathController.repeat(reverse: true);
      } else if (!isRunning && _breathController.isAnimating) {
        _breathController.stop();
        _breathController.animateTo(
          0.0,
          duration: const Duration(milliseconds: 300),
        );
      }
    });

    // Auto-navigate when count-down completes
    if (s.mode == TimerMode.countDown &&
        !s.isRunning &&
        s.elapsedSeconds > 0 &&
        s.elapsedSeconds >= (s.targetSeconds ?? 0)) {
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        if (!mounted) return;
        final router = GoRouter.of(context);
        await notifier.complete();
        if (mounted) router.go('/');
      });
    }

    final sessionId = widget.session.id;
    final bgUrl = 'https://picsum.photos/seed/$sessionId/800/1600?blur=3';

    return PopScope(
      canPop: false,
      child: Stack(
        fit: StackFit.expand,
        children: [
          // Background image
          Image.network(
            bgUrl,
            fit: BoxFit.cover,
            errorBuilder:
                (context, error, stackTrace) => Container(
                  decoration: const BoxDecoration(
                    gradient: RadialGradient(
                      colors: [Color(0xFF1a1a2e), Color(0xFF0a0a0a)],
                      radius: 1.2,
                    ),
                  ),
                ),
          ),
          // Dark gradient overlay
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0x99000000), // ~60% black at top
                  Color(0xCC000000), // ~80% black at bottom
                ],
              ),
            ),
          ),
          // Main scaffold
          Scaffold(
            backgroundColor: Colors.transparent,
            extendBodyBehindAppBar: true,
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              iconTheme: const IconThemeData(color: Colors.white),
              leading: IconButton(
                icon: const Icon(Icons.close),
                onPressed: () => _confirmEnd(context, notifier),
              ),
              title: Text(
                s.serverSession?.name ?? 'Study Session',
                style: const TextStyle(color: Colors.white),
              ),
            ),
            body: SafeArea(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Pomodoro phase info
                  if (s.mode == TimerMode.pomodoro) ...[
                    Text(
                      _phaseLabel(s),
                      style: Theme.of(
                        context,
                      ).textTheme.headlineSmall?.copyWith(
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
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: Colors.white70,
                      ),
                    ),
                    const SizedBox(height: 32),
                  ],
                  // Progress ring / timer
                  _buildProgressRing(s),
                  const SizedBox(height: 24),
                  // Subject chip
                  if (s.serverSession?.subject != null)
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.15),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: Colors.white.withValues(alpha: 0.2),
                        ),
                      ),
                      child: Text(
                        s.serverSession!.subject!.name,
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  const SizedBox(height: 48),
                  // Buttons
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if (s.isRunning)
                        _buildGlassButton(
                          icon: Icons.pause,
                          label: 'Pause',
                          onTap: () => notifier.pause(),
                        )
                      else
                        _buildGlassButton(
                          icon: Icons.play_arrow,
                          label: 'Resume',
                          onTap: () => notifier.resume(),
                        ),
                      const SizedBox(width: 24),
                      _buildGlassButton(
                        icon: Icons.stop,
                        label: 'End Session',
                        onTap: () => _confirmEnd(context, notifier),
                        iconColor: Colors.redAccent,
                        labelColor: Colors.redAccent,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _RingPainter extends CustomPainter {
  final double progress;
  final bool showRing;

  _RingPainter({required this.progress, required this.showRing});

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
  bool shouldRepaint(_RingPainter old) =>
      old.progress != progress || old.showRing != showRing;
}
