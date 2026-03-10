import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:marquer/providers/calendar/calendar_settings_provider.dart';

class CalendarSettingsSheet extends ConsumerWidget {
  const CalendarSettingsSheet({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final interval = ref.watch(calendarHourIntervalProvider);
    final colorScheme = Theme.of(context).colorScheme;

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 36,
                height: 4,
                decoration: BoxDecoration(
                  color: colorScheme.outlineVariant,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'Calendar Settings',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 20),
            Text(
              'Hour interval',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 10),
            Wrap(
              spacing: 6,
              children: List.generate(6, (i) {
                final value = i + 1;
                return ChoiceChip(
                  label: Text('$value'),
                  selected: interval == value,
                  onSelected: (_) => ref.read(calendarHourIntervalProvider.notifier).set(value),
                  visualDensity: VisualDensity.compact,
                  labelStyle: TextStyle(
                    fontSize: 12,
                    color: interval == value ? colorScheme.onSecondaryContainer : colorScheme.onSurface,
                  ),
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
