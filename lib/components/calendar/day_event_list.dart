import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:marquer/components/calendar/add_event_sheet.dart';
import 'package:marquer/components/calendar/day_event_tile.dart';
import 'package:marquer/providers/calendar/calendar_day_events_provider.dart';

class DayEventList extends ConsumerWidget {
  const DayEventList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final eventsAsync = ref.watch(calendarDayEventsProvider);

    return eventsAsync.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (e, st) => const Center(child: Text('Failed to load events')),
      data: (events) => Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (events.isEmpty)
            const Padding(
              padding: EdgeInsets.all(24),
              child: Center(child: Text('No events for this day')),
            )
          else
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: events.length,
              itemBuilder: (context, index) => DayEventTile(task: events[index]),
            ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: OutlinedButton.icon(
              onPressed: () => showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                backgroundColor: Colors.transparent,
                builder: (_) => const AddEventSheet(),
              ),
              icon: const Icon(Icons.add),
              label: const Text('Add Event'),
            ),
          ),
        ],
      ),
    );
  }
}
