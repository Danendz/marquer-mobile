import 'dart:async' show unawaited;
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_foreground_task/flutter_foreground_task.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:marquer/api/models/study/study_session.dart';
import 'package:marquer/api/models/study/timer_mode.dart';
import 'package:marquer/providers/study/timer_provider.dart';
import 'package:marquer/screens/study/widgets/timer_glass_button.dart';
import 'package:marquer/screens/study/widgets/timer_phase_indicator.dart';
import 'package:marquer/screens/study/widgets/timer_progress_ring.dart';
import 'package:marquer/services/timer_feedback_service.dart';

class ActiveTimerScreen extends ConsumerStatefulWidget {
  final StudySession? session;

  const ActiveTimerScreen({super.key, this.session});

  @override
  ConsumerState<ActiveTimerScreen> createState() => _ActiveTimerScreenState();
}

class _ActiveTimerScreenState extends ConsumerState<ActiveTimerScreen>
    with TickerProviderStateMixin, WidgetsBindingObserver {
  late AnimationController _breathController;
  late Animation<double> _breathAnim;
  late AnimationController _progressController;
  late Animation<double> _progressCurve;
  double _progressStart = 0.0;
  double _progressEnd = 0.0;
  bool _hasAutoCompleted = false;
  bool _hasShownStopDialog = false;
  String? _bgAsset;

  double _computeProgress(TimerState s) {
    if (s.mode == TimerMode.countDown &&
        s.targetSeconds != null &&
        s.targetSeconds! > 0) {
      return (s.elapsedSeconds / s.targetSeconds!).clamp(0.0, 1.0);
    }
    if (s.mode == TimerMode.pomodoro && s.currentPhaseTotalSeconds > 0) {
      return (s.phaseElapsedSeconds / s.currentPhaseTotalSeconds).clamp(
        0.0,
        1.0,
      );
    }
    return 0.0;
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _breathController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..repeat(reverse: true);
    _breathAnim = Tween<double>(begin: 1.0, end: 1.03).animate(
      CurvedAnimation(parent: _breathController, curve: Curves.easeInOut),
    );
    _progressController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 950),
    );
    _progressCurve = CurvedAnimation(
      parent: _progressController,
      curve: Curves.easeOut,
    );
    _loadBgAsset();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      if (widget.session != null) {
        final timerState = ref.read(timerProvider);
        if (timerState.serverSession?.id != widget.session!.id) {
          // Session not yet loaded (app restart or first navigation without start())
          ref.read(timerProvider.notifier).loadFromSession(widget.session!);
        }
        // else: start() was already called by CreateSessionSheet — do nothing
      } else {
        // extra was null: app restored from background
        final timerState = ref.read(timerProvider);
        if (timerState.serverSession == null) {
          context.go('/');
        }
        // else: provider still has the session — carry on
      }
    });
  }

  Future<void> _loadBgAsset() async {
    final manifest = await AssetManifest.loadFromAssetBundle(rootBundle);
    final assets = manifest.listAssets()
        .where((k) => k.startsWith('assets/timer_bg/'))
        .toList();
    if (mounted && assets.isNotEmpty) {
      setState(() => _bgAsset = assets[math.Random().nextInt(assets.length)]);
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _breathController.dispose();
    _progressController.dispose();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused ||
        state == AppLifecycleState.inactive) {
      _breathController.stop();
      ref.read(timerProvider.notifier).pauseTicker();
    } else if (state == AppLifecycleState.resumed) {
      final timerState = ref.read(timerProvider);
      if (timerState.isRunning) {
        _breathController.reset();
        _breathController.repeat(reverse: true);
      }
      ref.read(timerProvider.notifier).recoverFromBackground();
    }
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
    TimerNotifier notifier, {
    VoidCallback? onCancel,
  }) async {
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
    } else if (mounted) {
      onCancel?.call();
    }
  }

  @override
  Widget build(BuildContext context) {
    final s = ref.watch(timerProvider);
    final notifier = ref.read(timerProvider.notifier);

    // Snap progress to correct value when session first loads
    ref.listen(timerProvider.select((ts) => ts.serverSession?.id), (prev, next) {
      if (prev != next) {
        final p = _computeProgress(ref.read(timerProvider));
        _progressStart = p;
        _progressEnd = p;
        _progressController.value = 1.0;
      }
    });

    // Animate progress ring on each tick
    ref.listen(
      timerProvider.select((ts) {
        if (ts.mode == TimerMode.pomodoro) return ts.phaseElapsedSeconds;
        return ts.elapsedSeconds;
      }),
      (prev, next) {
        if (prev == next) return;
        // Capture current animated position as the new start
        _progressStart =
            _progressStart +
            (_progressEnd - _progressStart) * _progressCurve.value;
        _progressEnd = _computeProgress(ref.read(timerProvider));
        _progressController.forward(from: 0.0);
      },
    );

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

    // Show completion dialog when count-down finishes
    if (!_hasAutoCompleted &&
        s.mode == TimerMode.countDown &&
        !s.isRunning &&
        s.elapsedSeconds > 0 &&
        s.elapsedSeconds >= (s.targetSeconds ?? 0)) {
      _hasAutoCompleted = true;
      final elapsed = s.elapsedSeconds;
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        if (!mounted) return;
        final router = GoRouter.of(context);
        unawaited(TimerFeedbackService.playCompletionFeedback());
        await showDialog<void>(
          context: context,
          barrierDismissible: false,
          builder:
              (ctx) => AlertDialog(
                title: const Text('Session Complete!'),
                content: Text(
                  'Great work! You studied for ${_formatTime(elapsed)}.',
                ),
                actions: [
                  ElevatedButton(
                    onPressed: () => Navigator.of(ctx).pop(),
                    child: const Text('Done'),
                  ),
                ],
              ),
        );
        unawaited(TimerFeedbackService.stop());
        if (!mounted) return;
        await notifier.complete();
        if (mounted) router.go('/');
      });
    }

    // Show confirmation dialog when Stop was tapped in the notification
    if (s.stopRequested && !_hasShownStopDialog) {
      _hasShownStopDialog = true;
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (!mounted) return;
        _confirmEnd(
          context,
          notifier,
          onCancel: () {
            notifier.clearStopRequest();
            _hasShownStopDialog = false;
          },
        );
      });
    }

    final timeText = s.mode == TimerMode.countUp
        ? _formatTime(s.elapsedSeconds)
        : _formatTime(s.remainingSeconds);

    return WithForegroundTask(
      child: PopScope(
        canPop: false,
        child: Stack(
          fit: StackFit.expand,
          children: [
            // Background image
            if (_bgAsset != null)
              Image.asset(_bgAsset!, fit: BoxFit.cover)
            else
              Container(
                decoration: const BoxDecoration(
                  gradient: RadialGradient(
                    colors: [Color(0xFF2e2e50), Color(0xFF181828)],
                    radius: 1.2,
                  ),
                ),
              ),
            // Overlay
            Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color(0x55000000), // ~33% black at top
                    Color(0x88000000), // ~53% black at bottom
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
                    if (s.mode == TimerMode.pomodoro)
                      TimerPhaseIndicator(s: s, phaseLabel: _phaseLabel(s)),
                    // Progress ring / timer
                    TimerProgressRing(
                      s: s,
                      breathAnim: _breathAnim,
                      progressCurve: _progressCurve,
                      progressStart: _progressStart,
                      progressEnd: _progressEnd,
                      timeText: timeText,
                    ),
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
                          TimerGlassButton(
                            icon: Icons.pause,
                            label: 'Pause',
                            onTap: () => notifier.pause(),
                          )
                        else
                          TimerGlassButton(
                            icon: Icons.play_arrow,
                            label: 'Resume',
                            onTap: () => notifier.resume(),
                          ),
                        const SizedBox(width: 24),
                        TimerGlassButton(
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
      ),
    );
  }
}
