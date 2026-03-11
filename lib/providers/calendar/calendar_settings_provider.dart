import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

const _kHourIntervalKey = 'calendar_hour_interval';

final calendarHourIntervalProvider = NotifierProvider<CalendarHourIntervalNotifier, int>(
  CalendarHourIntervalNotifier.new,
);

class CalendarHourIntervalNotifier extends Notifier<int> {
  @override
  int build() {
    _load();
    return 1;
  }

  Future<void> _load() async {
    final prefs = await SharedPreferences.getInstance();
    final value = prefs.getInt(_kHourIntervalKey) ?? 1;
    state = value.clamp(1, 6);
  }

  Future<void> set(int value) async {
    final clamped = value.clamp(1, 6);
    state = clamped;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_kHourIntervalKey, clamped);
  }
}
