import 'package:flutter/material.dart';
import 'package:marquer/screens/study/widgets/session_num_field.dart';

class PomodoroConfigSection extends StatelessWidget {
  final int workMinutes;
  final int shortBreak;
  final int longBreak;
  final int cycles;
  final ValueChanged<int> onWorkChanged;
  final ValueChanged<int> onShortBreakChanged;
  final ValueChanged<int> onLongBreakChanged;
  final ValueChanged<int> onCyclesChanged;

  const PomodoroConfigSection({
    super.key,
    required this.workMinutes,
    required this.shortBreak,
    required this.longBreak,
    required this.cycles,
    required this.onWorkChanged,
    required this.onShortBreakChanged,
    required this.onLongBreakChanged,
    required this.onCyclesChanged,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Padding(
      key: const ValueKey('pomodoro'),
      padding: const EdgeInsets.only(top: 16),
      child: Container(
        decoration: BoxDecoration(
          color: colorScheme.surface,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            SessionNumField(
              'Work',
              workMinutes,
              1,
              120,
              onWorkChanged,
              unit: 'min',
            ),
            Divider(
              height: 1,
              color: colorScheme.onSurface.withValues(alpha: 0.08),
            ),
            SessionNumField(
              'Short break',
              shortBreak,
              1,
              60,
              onShortBreakChanged,
              unit: 'min',
            ),
            Divider(
              height: 1,
              color: colorScheme.onSurface.withValues(alpha: 0.08),
            ),
            SessionNumField(
              'Long break',
              longBreak,
              1,
              60,
              onLongBreakChanged,
              unit: 'min',
            ),
            Divider(
              height: 1,
              color: colorScheme.onSurface.withValues(alpha: 0.08),
            ),
            SessionNumField(
              'Cycles',
              cycles,
              1,
              20,
              onCyclesChanged,
            ),
          ],
        ),
      ),
    );
  }
}
