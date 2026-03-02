import 'package:flutter/material.dart';
import 'package:marquer/api/models/study/study_session.dart';
import 'package:marquer/api/models/study/study_session_status.dart';
import 'package:marquer/api/models/study/timer_mode.dart';
import 'package:marquer/utils/colors.dart';
import 'package:marquer/utils/format.dart';

class SessionCard extends StatelessWidget {
  final StudySession session;

  const SessionCard({super.key, required this.session});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final tt = Theme.of(context).textTheme;
    final subjectColor =
        session.subject != null ? hexToColor(session.subject!.color) : null;

    final bgColor = subjectColor != null
        ? subjectColor.withValues(alpha: 0.15)
        : cs.onSurface.withValues(alpha: 0.06);
    final borderColor = subjectColor != null
        ? subjectColor.withValues(alpha: 0.3)
        : cs.onSurface.withValues(alpha: 0.12);

    final date = DateTime.tryParse(session.startedAt);
    final now = DateTime.now();
    final dateStr = date == null
        ? ''
        : date.year == now.year
            ? '${date.day} ${_monthShort(date.month)}'
            : '${date.day} ${_monthShort(date.month)} ${date.year}';

    return Container(
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: borderColor),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    session.name,
                    style: tt.titleSmall?.copyWith(fontWeight: FontWeight.bold),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const SizedBox(width: 8),
                _StatusChip(status: session.status),
              ],
            ),
            const SizedBox(height: 4),
            Text(
              session.subject?.name ?? _modeLabel(session.timerMode),
              style: tt.bodySmall?.copyWith(color: cs.onSurfaceVariant),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Icon(_modeIcon(session.timerMode), size: 14,
                    color: cs.onSurfaceVariant),
                const SizedBox(width: 4),
                Text(
                  _modeLabel(session.timerMode),
                  style: tt.bodySmall?.copyWith(color: cs.onSurfaceVariant),
                ),
                if (session.timerMode == TimerMode.pomodoro &&
                    session.pomodoroCompletedCycles > 0) ...[
                  const SizedBox(width: 6),
                  Text(
                    '${session.pomodoroCompletedCycles}×',
                    style: tt.bodySmall?.copyWith(color: cs.onSurfaceVariant),
                  ),
                ],
                const Spacer(),
                Text(
                  formatDuration(session.actualDurationSeconds),
                  style: tt.titleMedium?.copyWith(fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(height: 4),
            Align(
              alignment: Alignment.centerRight,
              child: Text(
                dateStr,
                style: tt.bodySmall?.copyWith(color: cs.onSurfaceVariant),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _monthShort(int month) {
    const months = [
      'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
      'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec',
    ];
    return months[month - 1];
  }

  IconData _modeIcon(TimerMode m) => switch (m) {
        TimerMode.countUp => Icons.trending_up,
        TimerMode.countDown => Icons.timer_outlined,
        TimerMode.pomodoro => Icons.loop,
      };

  String _modeLabel(TimerMode m) => switch (m) {
        TimerMode.countUp => 'Count-up',
        TimerMode.countDown => 'Count-down',
        TimerMode.pomodoro => 'Pomodoro',
      };
}

class _StatusChip extends StatelessWidget {
  final StudySessionStatus status;

  const _StatusChip({required this.status});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final (bg, fg, label) = switch (status) {
      StudySessionStatus.completed => (
          Colors.green.withValues(alpha: 0.15),
          Colors.green,
          'Completed',
        ),
      StudySessionStatus.cancelled => (
          Colors.red.withValues(alpha: 0.15),
          Colors.red,
          'Cancelled',
        ),
      StudySessionStatus.paused => (
          cs.primary.withValues(alpha: 0.15),
          cs.primary,
          'Paused',
        ),
      StudySessionStatus.active => (
          cs.primary.withValues(alpha: 0.15),
          cs.primary,
          'Active',
        ),
    };

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        label,
        style: Theme.of(context).textTheme.labelSmall?.copyWith(color: fg),
      ),
    );
  }
}
