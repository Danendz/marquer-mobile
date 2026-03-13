import 'package:flutter/material.dart';

class EventDaySelector extends StatelessWidget {
  final List<DateTime> days;
  final DateTime? selected;
  final ColorScheme colorScheme;
  final List<String> dayLabels;
  final void Function(DateTime) onSelect;

  const EventDaySelector({
    super.key,
    required this.days,
    required this.selected,
    required this.colorScheme,
    required this.dayLabels,
    required this.onSelect,
  });

  bool _isSameDay(DateTime a, DateTime b) =>
      a.year == b.year && a.month == b.month && a.day == b.day;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(days.length, (i) {
        final day = days[i];
        final isSelected = selected != null && _isSameDay(day, selected!);
        return Expanded(
          child: GestureDetector(
            onTap: () => onSelect(day),
            child: Column(
              children: [
                Text(
                  dayLabels[i],
                  style: TextStyle(
                    fontSize: 11,
                    color: colorScheme.onSurface.withValues(alpha: 0.5),
                  ),
                ),
                const SizedBox(height: 2),
                Container(
                  width: 28,
                  height: 28,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: isSelected ? colorScheme.primary : Colors.transparent,
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    '${day.day}',
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: isSelected ? colorScheme.onPrimary : colorScheme.onSurface,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
