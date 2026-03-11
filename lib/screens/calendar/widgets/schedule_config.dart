import 'package:flutter/material.dart';

enum ScheduleType { daily, weekly, interval, monthlyDates, monthlyWeekday }

const weekdayLabels = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
const weekOccurrenceLabels = ['First', 'Second', 'Third', 'Fourth', 'Last'];
const weekOccurrenceValues = [1, 2, 3, 4, -1];

class ScheduleConfigSection extends StatelessWidget {
  final ScheduleType type;
  final List<int> weeklyDays;
  final int intervalEvery;
  final List<int> monthlyDates;
  final int monthlyWeekdayOccurrence;
  final int monthlyWeekdayDay;
  final ValueChanged<ScheduleType> onTypeChanged;
  final ValueChanged<List<int>> onWeeklyDaysChanged;
  final ValueChanged<int> onIntervalChanged;
  final ValueChanged<List<int>> onMonthlyDatesChanged;
  final ValueChanged<int> onMonthlyWeekdayOccurrenceChanged;
  final ValueChanged<int> onMonthlyWeekdayDayChanged;

  const ScheduleConfigSection({
    super.key,
    required this.type,
    required this.weeklyDays,
    required this.intervalEvery,
    required this.monthlyDates,
    required this.monthlyWeekdayOccurrence,
    required this.monthlyWeekdayDay,
    required this.onTypeChanged,
    required this.onWeeklyDaysChanged,
    required this.onIntervalChanged,
    required this.onMonthlyDatesChanged,
    required this.onMonthlyWeekdayOccurrenceChanged,
    required this.onMonthlyWeekdayDayChanged,
  });

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Repeat', style: Theme.of(context).textTheme.titleSmall),
        const SizedBox(height: 8),
        _buildTypePicker(),
        const SizedBox(height: 12),
        _buildConfig(colors),
      ],
    );
  }

  Widget _buildTypePicker() {
    return Wrap(
      spacing: 8,
      children: [
        for (final t in ScheduleType.values)
          ChoiceChip(
            label: Text(_typeLabel(t)),
            selected: type == t,
            onSelected: (_) => onTypeChanged(t),
          ),
      ],
    );
  }

  String _typeLabel(ScheduleType t) {
    return switch (t) {
      ScheduleType.daily => 'Daily',
      ScheduleType.weekly => 'Weekly',
      ScheduleType.interval => 'Interval',
      ScheduleType.monthlyDates => 'Monthly dates',
      ScheduleType.monthlyWeekday => 'Monthly weekday',
    };
  }

  Widget _buildConfig(ColorScheme colors) {
    return switch (type) {
      ScheduleType.daily => const SizedBox.shrink(),
      ScheduleType.weekly => _buildWeeklyConfig(),
      ScheduleType.interval => _buildIntervalConfig(),
      ScheduleType.monthlyDates => _buildMonthlyDatesConfig(),
      ScheduleType.monthlyWeekday => _buildMonthlyWeekdayConfig(),
    };
  }

  Widget _buildWeeklyConfig() {
    return Wrap(
      spacing: 6,
      children: List.generate(7, (i) {
        final selected = weeklyDays.contains(i);
        return FilterChip(
          label: Text(weekdayLabels[i]),
          selected: selected,
          onSelected: (v) {
            final updated = List<int>.from(weeklyDays);
            if (v) {
              updated.add(i);
            } else if (updated.length > 1) {
              updated.remove(i);
            }
            onWeeklyDaysChanged(updated);
          },
        );
      }),
    );
  }

  Widget _buildIntervalConfig() {
    return Row(
      children: [
        const Text('Every'),
        const SizedBox(width: 12),
        IconButton(
          onPressed: intervalEvery > 1 ? () => onIntervalChanged(intervalEvery - 1) : null,
          icon: const Icon(Icons.remove),
        ),
        Text('$intervalEvery', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
        IconButton(
          onPressed: () => onIntervalChanged(intervalEvery + 1),
          icon: const Icon(Icons.add),
        ),
        const Text('days'),
      ],
    );
  }

  Widget _buildMonthlyDatesConfig() {
    return LayoutBuilder(
      builder: (context, constraints) {
        const spacing = 4.0;
        final chipWidth = (constraints.maxWidth - spacing * 6) / 7;
        return Wrap(
          spacing: spacing,
          runSpacing: spacing,
          children: List.generate(31, (i) {
            final day = i + 1;
            final selected = monthlyDates.contains(day);
            return SizedBox(
              width: chipWidth,
              child: FilterChip(
                label: Center(child: Text('$day', style: const TextStyle(fontSize: 13))),
                selected: selected,
                showCheckmark: false,
                onSelected: (v) {
                  final updated = List<int>.from(monthlyDates);
                  if (v) {
                    updated.add(day);
                  } else if (updated.length > 1) {
                    updated.remove(day);
                  }
                  onMonthlyDatesChanged(updated);
                },
                labelPadding: EdgeInsets.zero,
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
            );
          }),
        );
      },
    );
  }

  Widget _buildMonthlyWeekdayConfig() {
    return Row(
      children: [
        Expanded(
          child: DropdownButtonFormField<int>(
            initialValue: weekOccurrenceValues.contains(monthlyWeekdayOccurrence)
                ? monthlyWeekdayOccurrence
                : 1,
            decoration: const InputDecoration(labelText: 'Occurrence', border: OutlineInputBorder()),
            items: List.generate(weekOccurrenceLabels.length, (i) => DropdownMenuItem(
              value: weekOccurrenceValues[i],
              child: Text(weekOccurrenceLabels[i]),
            )),
            onChanged: (v) => onMonthlyWeekdayOccurrenceChanged(v!),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: DropdownButtonFormField<int>(
            initialValue: monthlyWeekdayDay,
            decoration: const InputDecoration(labelText: 'Weekday', border: OutlineInputBorder()),
            items: List.generate(7, (i) => DropdownMenuItem(
              value: i,
              child: Text(weekdayLabels[i]),
            )),
            onChanged: (v) => onMonthlyWeekdayDayChanged(v!),
          ),
        ),
      ],
    );
  }
}
