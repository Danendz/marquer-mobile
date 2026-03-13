import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class PlanDateRangeSection extends StatelessWidget {
  final DateTime startDate;
  final bool hasEndDate;
  final DateTime? endDate;
  final VoidCallback onPickStart;
  final VoidCallback onPickEnd;
  final ValueChanged<bool> onEndDateToggle;

  const PlanDateRangeSection({
    super.key,
    required this.startDate,
    required this.hasEndDate,
    this.endDate,
    required this.onPickStart,
    required this.onPickEnd,
    required this.onEndDateToggle,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Date range', style: Theme.of(context).textTheme.titleSmall),
        const SizedBox(height: 8),
        Row(
          children: [
            Expanded(
              child: OutlinedButton.icon(
                onPressed: onPickStart,
                icon: const Icon(Icons.calendar_today_outlined, size: 16),
                label: Text(DateFormat('MMM d, yyyy').format(startDate)),
              ),
            ),
            const SizedBox(width: 8),
            Switch(
              value: hasEndDate,
              onChanged: onEndDateToggle,
            ),
            const Text('End'),
          ],
        ),
        if (hasEndDate) ...[
          const SizedBox(height: 8),
          OutlinedButton.icon(
            onPressed: onPickEnd,
            icon: const Icon(Icons.calendar_today_outlined, size: 16),
            label: Text(
              endDate != null ? DateFormat('MMM d, yyyy').format(endDate!) : 'Pick end date',
            ),
          ),
        ],
      ],
    );
  }
}
