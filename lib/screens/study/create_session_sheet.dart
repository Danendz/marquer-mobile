import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:marquer/api/models/study/store_study_session_request.dart';
import 'package:marquer/api/models/study/study_subject.dart';
import 'package:marquer/api/models/study/timer_mode.dart';
import 'package:marquer/api/services/study_service.dart';
import 'package:marquer/providers/study/study_settings_provider.dart';
import 'package:marquer/providers/study/study_subjects_provider.dart';
import 'package:marquer/screens/study/widgets/countdown_config_section.dart';
import 'package:marquer/screens/study/widgets/pomodoro_config_section.dart';

class CreateSessionSheet extends ConsumerStatefulWidget {
  const CreateSessionSheet({super.key});

  @override
  ConsumerState<CreateSessionSheet> createState() => _CreateSessionSheetState();
}

class _CreateSessionSheetState extends ConsumerState<CreateSessionSheet> {
  final _nameCtrl = TextEditingController();
  final _countDownCtrl = TextEditingController(text: '30');
  TimerMode _mode = TimerMode.countUp;
  StudySubject? _subject;
  int _countDownMinutes = 30;
  bool _customCountDown = false;
  bool _loading = false;

  int _workMinutes = 25;
  int _shortBreak = 5;
  int _longBreak = 15;
  int _cycles = 4;

  @override
  void initState() {
    super.initState();
    final settings = ref.read(studySettingsProvider).asData?.value;
    if (settings != null) {
      _workMinutes = settings.defaultWorkMinutes;
      _shortBreak = settings.defaultShortBreakMinutes;
      _longBreak = settings.defaultLongBreakMinutes;
      _cycles = settings.defaultCycles;
    }
  }

  @override
  void dispose() {
    _nameCtrl.dispose();
    _countDownCtrl.dispose();
    super.dispose();
  }

  Future<void> _start() async {
    if (_nameCtrl.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Session name is required')),
      );
      return;
    }
    setState(() => _loading = true);
    try {
      final session = await StudyService().createSession(
        StoreStudySessionRequest(
          name: _nameCtrl.text.trim(),
          studySubjectId: _subject?.id,
          timerMode: _mode,
          plannedDurationSeconds:
              _mode == TimerMode.countDown ? _countDownMinutes * 60 : null,
          pomodoroWorkMinutes:
              _mode == TimerMode.pomodoro ? _workMinutes : null,
          pomodoroShortBreakMinutes:
              _mode == TimerMode.pomodoro ? _shortBreak : null,
          pomodoroLongBreakMinutes:
              _mode == TimerMode.pomodoro ? _longBreak : null,
          pomodoroCycles: _mode == TimerMode.pomodoro ? _cycles : null,
        ),
      );
      if (!mounted) return;
      Navigator.of(context).pop(session);
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(e.toString())));
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  Widget _buildModeConfig() {
    switch (_mode) {
      case TimerMode.countDown:
        return CountdownConfigSection(
          countDownMinutes: _countDownMinutes,
          customCountDown: _customCountDown,
          countDownCtrl: _countDownCtrl,
          onPresetSelected: (m) => setState(() {
            _customCountDown = false;
            _countDownMinutes = m;
          }),
          onCustomSelected: () => setState(() {
            _customCountDown = true;
            _countDownMinutes =
                (int.tryParse(_countDownCtrl.text) ?? 30).clamp(1, 600);
          }),
          onCustomChanged: (v) => setState(() => _countDownMinutes = v),
        );
      case TimerMode.pomodoro:
        return PomodoroConfigSection(
          workMinutes: _workMinutes,
          shortBreak: _shortBreak,
          longBreak: _longBreak,
          cycles: _cycles,
          onWorkChanged: (v) => setState(() => _workMinutes = v),
          onShortBreakChanged: (v) => setState(() => _shortBreak = v),
          onLongBreakChanged: (v) => setState(() => _longBreak = v),
          onCyclesChanged: (v) => setState(() => _cycles = v),
        );
      default:
        return const SizedBox.shrink(key: ValueKey('none'));
    }
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final subjects = ref.watch(studySubjectsProvider).asData?.value ?? [];
    final inputFill = colorScheme.surface;
    final inputBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide.none,
    );

    return Container(
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainer,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.only(
            left: 24,
            right: 24,
            bottom: MediaQuery.of(context).viewInsets.bottom + 24,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Drag handle
              Center(
                child: Container(
                  width: 36,
                  height: 4,
                  margin: const EdgeInsets.symmetric(vertical: 14),
                  decoration: BoxDecoration(
                    color: colorScheme.onSurface.withValues(alpha: 0.25),
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),

              // Title row
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: colorScheme.primary.withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(
                      Icons.play_circle_outline_rounded,
                      color: colorScheme.primary,
                      size: 22,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'New Study Session',
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'Set up your focus session',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 24),

              // Session name
              TextField(
                controller: _nameCtrl,
                autofocus: true,
                decoration: InputDecoration(
                  labelText: 'Session name',
                  hintText: 'e.g. Math chapter 5',
                  filled: true,
                  fillColor: inputFill,
                  border: inputBorder,
                  enabledBorder: inputBorder,
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: colorScheme.primary, width: 1.5),
                  ),
                  prefixIcon: const Icon(Icons.edit_outlined, size: 20),
                ),
              ),
              const SizedBox(height: 10),

              // Subject
              DropdownButtonFormField<StudySubject?>(
                initialValue: _subject,
                dropdownColor: colorScheme.surfaceContainer,
                decoration: InputDecoration(
                  labelText: 'Subject',
                  filled: true,
                  fillColor: inputFill,
                  border: inputBorder,
                  enabledBorder: inputBorder,
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: colorScheme.primary, width: 1.5),
                  ),
                  prefixIcon: const Icon(Icons.category_outlined, size: 20),
                ),
                items: [
                  const DropdownMenuItem(value: null, child: Text('No subject')),
                  ...subjects.map(
                    (s) => DropdownMenuItem(value: s, child: Text(s.name)),
                  ),
                ],
                onChanged: (v) => setState(() => _subject = v),
              ),
              const SizedBox(height: 16),

              // Timer mode
              Text(
                'Timer mode',
                style: Theme.of(context).textTheme.labelMedium?.copyWith(
                  color: colorScheme.onSurfaceVariant,
                ),
              ),
              const SizedBox(height: 8),
              SegmentedButton<TimerMode>(
                selected: {_mode},
                onSelectionChanged: (v) => setState(() => _mode = v.first),
                style: ButtonStyle(
                  backgroundColor: WidgetStateProperty.resolveWith((states) {
                    if (states.contains(WidgetState.selected)) {
                      return colorScheme.primary;
                    }
                    return Colors.transparent;
                  }),
                  foregroundColor: WidgetStateProperty.resolveWith((states) {
                    if (states.contains(WidgetState.selected)) {
                      return colorScheme.onPrimary;
                    }
                    return colorScheme.onSurface;
                  }),
                ),
                segments: const [
                  ButtonSegment(
                    value: TimerMode.countUp,
                    icon: Icon(Icons.trending_up, size: 16),
                    label: Text('Count-up'),
                  ),
                  ButtonSegment(
                    value: TimerMode.countDown,
                    icon: Icon(Icons.timer_outlined, size: 16),
                    label: Text('Count-down'),
                  ),
                  ButtonSegment(
                    value: TimerMode.pomodoro,
                    icon: Icon(Icons.loop, size: 16),
                    label: Text('Pomodoro'),
                  ),
                ],
              ),

              // Animated mode config
              AnimatedSize(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
                alignment: Alignment.topCenter,
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 220),
                  switchInCurve: Curves.easeOut,
                  switchOutCurve: Curves.easeIn,
                  transitionBuilder: (child, animation) => FadeTransition(
                    opacity: animation,
                    child: SlideTransition(
                      position: Tween<Offset>(
                        begin: const Offset(0, 0.06),
                        end: Offset.zero,
                      ).animate(animation),
                      child: child,
                    ),
                  ),
                  child: _buildModeConfig(),
                ),
              ),

              const SizedBox(height: 24),

              // Start button
              SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton.icon(
                  onPressed: _loading ? null : _start,
                  icon:
                      _loading
                          ? const SizedBox(
                            height: 18,
                            width: 18,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          )
                          : const Icon(Icons.play_arrow_rounded),
                  label: const Text(
                    'Start Session',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: colorScheme.primary,
                    foregroundColor: colorScheme.onPrimary,
                    disabledBackgroundColor:
                        colorScheme.primary.withValues(alpha: 0.5),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
