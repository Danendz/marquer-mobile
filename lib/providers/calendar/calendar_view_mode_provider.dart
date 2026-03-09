import 'package:flutter_riverpod/flutter_riverpod.dart';

enum CalendarViewMode { month, week }

final calendarViewModeProvider = NotifierProvider<CalendarViewModeNotifier, CalendarViewMode>(
  CalendarViewModeNotifier.new,
);

class CalendarViewModeNotifier extends Notifier<CalendarViewMode> {
  @override
  CalendarViewMode build() => CalendarViewMode.month;

  void toggle() {
    state = state == CalendarViewMode.month ? CalendarViewMode.week : CalendarViewMode.month;
  }
}
