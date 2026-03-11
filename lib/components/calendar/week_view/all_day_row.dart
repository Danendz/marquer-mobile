import 'package:flutter/material.dart';
import 'package:marquer/components/calendar/week_view/week_event.dart';
import 'package:marquer/components/calendar/week_view/week_view_constants.dart';

class AllDayRow extends StatelessWidget {
  final List<DateTime> days;
  final List<List<WeekEvent>> allDayEventsByDay;
  final ColorScheme colorScheme;
  final void Function(WeekEvent) onEventTap;
  final void Function(WeekEvent)? onEventLongPress;

  const AllDayRow({
    super.key,
    required this.days,
    required this.allDayEventsByDay,
    required this.colorScheme,
    required this.onEventTap,
    this.onEventLongPress,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: colorScheme.outlineVariant, width: 0.5)),
      ),
      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: kTimeGutter,
              child: Padding(
                padding: const EdgeInsets.only(top: 4),
                child: Text(
                  'All day',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 10,
                    color: colorScheme.onSurface.withValues(alpha: 0.5),
                  ),
                ),
              ),
            ),
            ...List.generate(7, (i) {
              final events = allDayEventsByDay[i];
              return Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(4),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: events.map((e) {
                      final isDone = e.isDone;
                      return GestureDetector(
                        onTap: () => onEventTap(e),
                        onLongPress: () => onEventLongPress?.call(e),
                        child: Container(
                          margin: const EdgeInsets.only(bottom: 3),
                          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
                          decoration: BoxDecoration(
                            color: e.color.withValues(alpha: isDone ? 0.12 : 0.2),
                            borderRadius: BorderRadius.circular(4),
                            border: Border(
                              left: BorderSide(color: e.color, width: 3),
                            ),
                          ),
                          child: Text(
                            e.name,
                            style: TextStyle(
                              fontSize: 10,
                              color: e.color,
                              decoration: isDone ? TextDecoration.lineThrough : null,
                            ),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}
