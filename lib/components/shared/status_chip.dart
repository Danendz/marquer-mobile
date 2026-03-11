import 'package:flutter/material.dart';
import 'package:marquer/api/models/tasks/tasks/task_status.dart';

class StatusChip extends StatelessWidget {
  final TaskStatus status;
  final ColorScheme colorScheme;

  const StatusChip({super.key, required this.status, required this.colorScheme});

  @override
  Widget build(BuildContext context) {
    final (label, bg, fg, outlined) = switch (status) {
      TaskStatus.done => ('Done', Colors.green.withValues(alpha: 0.15), Colors.green, false),
      TaskStatus.progress => ('In Progress', Colors.blue.withValues(alpha: 0.15), Colors.blue, false),
      TaskStatus.cancelled => ('Cancelled', Colors.red.withValues(alpha: 0.15), Colors.red, false),
      TaskStatus.draft => ('Draft', Colors.transparent, colorScheme.onSurfaceVariant, true),
    };

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(20),
        border: outlined ? Border.all(color: colorScheme.outlineVariant) : null,
      ),
      child: Text(
        label,
        style: TextStyle(fontSize: 10, color: fg, fontWeight: FontWeight.w500),
      ),
    );
  }
}
