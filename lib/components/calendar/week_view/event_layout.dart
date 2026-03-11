import 'package:marquer/components/calendar/week_view/week_event.dart';

class PositionedEvent {
  final WeekEvent event;
  final double left;
  final double width;
  final int colIndex;
  final int overflowCount;
  final List<WeekEvent> overflowEvents;

  const PositionedEvent({
    required this.event,
    required this.left,
    required this.width,
    required this.colIndex,
    this.overflowCount = 0,
    this.overflowEvents = const [],
  });
}

/// Returns the max number of events simultaneously active at any point.
int _peakConcurrent(List<WeekEvent> cluster) {
  final endpoints = <({int time, int delta})>[];
  for (final e in cluster) {
    endpoints.add((time: e.startMinutes, delta: 1));
    endpoints.add((time: e.startMinutes + e.durationMinutes, delta: -1));
  }
  // Sort ends before starts at the same time (conservative: don't count as concurrent)
  endpoints.sort((a, b) => a.time != b.time ? a.time.compareTo(b.time) : a.delta.compareTo(b.delta));
  int peak = 0, count = 0;
  for (final p in endpoints) {
    count += p.delta;
    if (count > peak) peak = count;
  }
  return peak;
}

/// Returns the events that are all simultaneously active at the peak-overlap time.
List<WeekEvent> _peakConcurrentEvents(List<WeekEvent> cluster) {
  final endpoints = <({int time, bool isStart})>[];
  for (final e in cluster) {
    endpoints.add((time: e.startMinutes, isStart: true));
    endpoints.add((time: e.startMinutes + e.durationMinutes, isStart: false));
  }
  endpoints.sort((a, b) => a.time != b.time ? a.time.compareTo(b.time) : (a.isStart ? 1 : -1));
  int peak = 0, count = 0, peakTime = 0;
  for (final p in endpoints) {
    if (p.isStart) {
      count++;
      if (count > peak) {
        peak = count;
        peakTime = p.time;
      }
    } else {
      count--;
    }
  }
  return cluster
      .where((e) => e.startMinutes <= peakTime && e.startMinutes + e.durationMinutes > peakTime)
      .toList();
}

List<PositionedEvent> layoutEvents(List<WeekEvent> events, double columnWidth) {
  if (events.isEmpty) return [];

  final sorted = [...events]..sort((a, b) => a.startMinutes.compareTo(b.startMinutes));
  final clusters = buildClusters(sorted);
  final result = <PositionedEvent>[];

  for (final cluster in clusters) {
    final peakConcurrent = _peakConcurrent(cluster);
    if (peakConcurrent >= 3) {
      // 3+ simultaneously overlapping: first event full-width, rest hidden behind "+N" badge
      final concurrent = _peakConcurrentEvents(cluster);
      final first = concurrent.first;
      result.add(PositionedEvent(
        event: first,
        left: 0,
        width: columnWidth,
        colIndex: 0,
        overflowCount: peakConcurrent - 1,
        overflowEvents: concurrent.skip(1).toList(),
      ));
    } else {
      // 1 or 2 events: side-by-side columns within cluster.
      // Phase 1: assign each event to a column greedily.
      final subCols = <List<WeekEvent>>[];
      final colOf = <WeekEvent, int>{};
      for (final event in cluster) {
        int col = -1;
        for (int i = 0; i < subCols.length; i++) {
          final last = subCols[i].last;
          if (event.startMinutes >= last.startMinutes + last.durationMinutes) {
            col = i;
            break;
          }
        }
        if (col == -1) {
          col = subCols.length;
          subCols.add([]);
        }
        subCols[col].add(event);
        colOf[event] = col;
      }
      // Phase 2: per-event width based on how many columns actually overlap at that event's time.
      for (int c = 0; c < subCols.length; c++) {
        for (final event in subCols[c]) {
          final activeCols = subCols.where((colEvents) => colEvents.any((e) =>
            e.startMinutes < event.startMinutes + event.durationMinutes &&
            e.startMinutes + e.durationMinutes > event.startMinutes
          )).length;
          final w = columnWidth / activeCols.clamp(1, subCols.length);
          result.add(PositionedEvent(event: event, left: colOf[event]! * w, width: w, colIndex: colOf[event]!));
        }
      }
    }
  }

  return result;
}

/// Groups events into overlap clusters (transitive closure of pairwise overlap).
List<List<WeekEvent>> buildClusters(List<WeekEvent> sorted) {
  final clusters = <List<WeekEvent>>[];
  for (final event in sorted) {
    bool added = false;
    for (final cluster in clusters) {
      final overlaps = cluster.any((e) =>
        event.startMinutes < e.startMinutes + e.durationMinutes &&
        e.startMinutes < event.startMinutes + event.durationMinutes);
      if (overlaps) {
        cluster.add(event);
        added = true;
        break;
      }
    }
    if (!added) clusters.add([event]);
  }
  return clusters;
}
