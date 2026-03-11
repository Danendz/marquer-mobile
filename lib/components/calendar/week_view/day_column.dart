import 'package:flutter/material.dart';
import 'package:marquer/components/calendar/week_view/week_event.dart';
import 'package:marquer/components/calendar/week_view/event_layout.dart';
import 'package:marquer/components/calendar/week_view/week_view_constants.dart';
import 'package:marquer/utils/colors.dart';

class DayColumn extends StatelessWidget {
  final List<WeekEvent> events;
  final ColorScheme colorScheme;
  final void Function(WeekEvent) onEventTap;
  final void Function(WeekEvent)? onEventLongPress;
  final void Function(int minutes)? onEmptyTap;

  const DayColumn({
    super.key,
    required this.events,
    required this.colorScheme,
    required this.onEventTap,
    this.onEventLongPress,
    this.onEmptyTap,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;
        return _buildColumn(context, width);
      },
    );
  }

  Widget _buildColumn(BuildContext context, double width) {
    final positioned = layoutEvents(events, width);

    // Group PlanTaskEvents by planId for background rendering
    final planGroups = <int, List<PlanTaskEvent>>{};
    for (final event in events) {
      if (event is PlanTaskEvent) {
        planGroups.putIfAbsent(event.planId, () => []).add(event);
      }
    }

    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onLongPressStart: (details) {
        final minutes = (details.localPosition.dy / kPixelsPerMinute).round();
        onEmptyTap?.call(minutes);
      },
      child: Stack(
        children: [
          // Plan group backgrounds (rendered before events)
          ...planGroups.entries.map((entry) {
            final planEvents = entry.value;
            final minStart = planEvents.map((e) => e.startMinutes).reduce((a, b) => a < b ? a : b);
            final maxEnd = planEvents
                .map((e) => e.startMinutes + e.durationMinutes)
                .reduce((a, b) => a > b ? a : b);
            final top = ((minStart * kPixelsPerMinute) - 12).clamp(0.0, double.infinity);
            final bgHeight = (((maxEnd - minStart) * kPixelsPerMinute) + 12).clamp(18.0, double.infinity);
            final planName = planEvents.first.planName;
            final planColor = planEvents.first.planTask.planColor != null
                ? hexToColor(planEvents.first.planTask.planColor!)
                : Colors.amber;
            return Positioned(
              top: top,
              left: 1.5,
              width: width - 3,
              height: bgHeight,
              child: Container(
                decoration: BoxDecoration(
                  color: planColor.withValues(alpha: 0.08),
                  borderRadius: BorderRadius.circular(4),
                ),
                padding: const EdgeInsets.only(left: 3, top: 1),
                child: Text(
                  planName,
                  style: TextStyle(fontSize: 8, color: planColor.withValues(alpha: 0.85)),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
              ),
            );
          }),
          // Events
          ...positioned.map((p) {
            final event = p.event;
            final top = event.startMinutes * kPixelsPerMinute;
            final height = (event.durationMinutes * kPixelsPerMinute).clamp(18.0, double.infinity);
            final isDone = event.isDone;

            return Positioned(
              top: top,
              left: p.left + 1.5,
              width: p.width - 3,
              height: height,
              child: GestureDetector(
                onTap: () => onEventTap(event),
                onLongPress: () => onEventLongPress?.call(event),
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: event.color.withValues(alpha: isDone ? 0.12 : 0.2),
                        borderRadius: BorderRadius.circular(4),
                        border: Border(
                          left: BorderSide(color: event.color, width: 2),
                        ),
                      ),
                      padding: const EdgeInsets.only(left: 4, top: 2, right: 2),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (event.startTime != null)
                            Text(
                              event.shortTimeRange,
                              style: TextStyle(
                                fontSize: 8,
                                color: event.color.withValues(alpha: 0.7),
                                decoration: isDone ? TextDecoration.lineThrough : null,
                              ),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                            ),
                          Expanded(
                            child: Text(
                              event.name,
                              style: TextStyle(
                                fontSize: 10,
                                color: event.color,
                                decoration: isDone ? TextDecoration.lineThrough : null,
                              ),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 3,
                            ),
                          ),
                        ],
                      ),
                    ),
                    // Subtle bottom separator
                    Positioned(
                      left: 0,
                      right: 0,
                      bottom: 0,
                      child: Container(height: 0.5, color: colorScheme.outlineVariant),
                    ),
                    // "+N" overflow badge
                    if (p.overflowCount > 0)
                      Positioned(
                        top: 2,
                        right: 2,
                        child: GestureDetector(
                          onTap: () => _showOverflowSheet(context, p.overflowEvents),
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                            decoration: BoxDecoration(
                              color: event.color.withValues(alpha: 0.85),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              '+${p.overflowCount}',
                              style: const TextStyle(
                                fontSize: 8,
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            );
          }),
        ],
      ),
    );
  }

  void _showOverflowSheet(BuildContext context, List<WeekEvent> overflowEvents) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Theme.of(context).colorScheme.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (ctx) {
        final cs = Theme.of(ctx).colorScheme;
        return Padding(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 32),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 36,
                  height: 4,
                  decoration: BoxDecoration(
                    color: cs.outlineVariant,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Text(
                'More events',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: cs.onSurface),
              ),
              const SizedBox(height: 8),
              ...overflowEvents.map((e) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: Row(
                  children: [
                    Container(
                      width: 3,
                      height: 32,
                      decoration: BoxDecoration(
                        color: e.color,
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(e.name, style: TextStyle(fontSize: 13, color: cs.onSurface)),
                          if (e.timeRange.isNotEmpty)
                            Text(
                              e.timeRange,
                              style: TextStyle(fontSize: 11, color: cs.onSurface.withValues(alpha: 0.6)),
                            ),
                        ],
                      ),
                    ),
                  ],
                ),
              )),
            ],
          ),
        );
      },
    );
  }
}
