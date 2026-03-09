import 'package:flutter_riverpod/flutter_riverpod.dart';

final calendarSelectedDateProvider =
    NotifierProvider<CalendarSelectedDateNotifier, DateTime>(
      CalendarSelectedDateNotifier.new,
    );

class CalendarSelectedDateNotifier extends Notifier<DateTime> {
  @override
  DateTime build() => DateTime.now();

  void select(DateTime date) {
    state = date;
  }
}
