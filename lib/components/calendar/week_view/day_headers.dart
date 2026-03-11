import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:marquer/components/calendar/calendar_settings_sheet.dart';
import 'package:marquer/providers/calendar/calendar_selected_date_provider.dart';
import 'package:marquer/utils/format.dart';
import 'package:marquer/components/calendar/week_view/week_view_constants.dart';

class DayHeaders extends ConsumerWidget {
  final List<DateTime> days;
  final DateTime selected;
  final String today;
  final ColorScheme colorScheme;

  const DayHeaders({
    super.key,
    required this.days,
    required this.selected,
    required this.today,
    required this.colorScheme,
  });

  static const _dayLabels = ['M', 'T', 'W', 'T', 'F', 'S', 'S'];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedStr = formatDate(selected);
    return Container(
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: colorScheme.outlineVariant, width: 0.5)),
      ),
      child: Row(
        children: [
          SizedBox(
            width: kTimeGutter,
            child: Center(
              child: IconButton(
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
                icon: Icon(Icons.settings_outlined, size: 22, color: colorScheme.onSurface.withValues(alpha: 0.4)),
                onPressed: () => showModalBottomSheet(
                  context: context,
                  backgroundColor: Theme.of(context).colorScheme.surface,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                  ),
                  builder: (_) => const CalendarSettingsSheet(),
                ),
              ),
            ),
          ),
          ...List.generate(7, (i) {
            final day = days[i];
            final dateStr = formatDate(day);
            final isToday = dateStr == today;
            final isSelected = dateStr == selectedStr;

            return Expanded(
              child: GestureDetector(
                onTap: () => ref.read(calendarSelectedDateProvider.notifier).select(day),
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Column(
                    children: [
                      Text(
                        _dayLabels[i],
                        style: TextStyle(
                          fontSize: 11,
                          color: colorScheme.onSurface.withValues(alpha: 0.6),
                        ),
                      ),
                      const SizedBox(height: 2),
                      Container(
                        width: 28,
                        height: 28,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: isToday
                              ? colorScheme.primary
                              : isSelected
                                  ? colorScheme.primaryContainer
                                  : Colors.transparent,
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          '${day.day}',
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: isToday
                                ? colorScheme.onPrimary
                                : isSelected
                                    ? colorScheme.onPrimaryContainer
                                    : colorScheme.onSurface,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }),
        ],
      ),
    );
  }
}
