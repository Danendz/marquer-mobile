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

List<PositionedEvent> layoutEvents(List<WeekEvent> events, double columnWidth) {
  if (events.isEmpty) return [];

  final sorted = [...events]..sort((a, b) => a.startMinutes.compareTo(b.startMinutes));
  final clusters = buildClusters(sorted);
  final result = <PositionedEvent>[];

  for (final cluster in clusters) {
    if (cluster.length >= 3) {
      // 3+ overlapping: first event full-width, rest hidden behind "+N" badge
      final first = cluster.first;
      result.add(PositionedEvent(
        event: first,
        left: 0,
        width: columnWidth,
        colIndex: 0,
        overflowCount: cluster.length - 1,
        overflowEvents: cluster.skip(1).toList(),
      ));
    } else {
      // 1 or 2 events: side-by-side columns within cluster
      final subCols = <List<WeekEvent>>[];
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
      }
      final totalCols = subCols.length;
      final w = columnWidth / totalCols;
      for (int c = 0; c < subCols.length; c++) {
        for (final event in subCols[c]) {
          result.add(PositionedEvent(event: event, left: c * w, width: w, colIndex: c));
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
