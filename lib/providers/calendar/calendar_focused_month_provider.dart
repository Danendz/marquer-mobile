import 'package:flutter_riverpod/flutter_riverpod.dart';

final calendarFocusedMonthProvider =
    NotifierProvider<CalendarFocusedMonthNotifier, DateTime>(
      CalendarFocusedMonthNotifier.new,
    );

class CalendarFocusedMonthNotifier extends Notifier<DateTime> {
  @override
  DateTime build() => DateTime.now();

  void set(DateTime month) => state = month;
}
