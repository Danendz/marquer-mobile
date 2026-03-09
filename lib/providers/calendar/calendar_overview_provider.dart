import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:marquer/api/models/calendar/calendar_overview.dart';
import 'package:marquer/api/services/calendar_service.dart';
import 'package:marquer/providers/calendar/calendar_focused_month_provider.dart';
import 'package:marquer/utils/format.dart';

final calendarOverviewProvider =
    AsyncNotifierProvider<CalendarOverviewNotifier, CalendarOverview>(
      CalendarOverviewNotifier.new,
    );

class CalendarOverviewNotifier extends AsyncNotifier<CalendarOverview> {
  final _service = CalendarService();

  @override
  Future<CalendarOverview> build() async {
    final focused = ref.watch(calendarFocusedMonthProvider);
    final from = DateTime(focused.year, focused.month, 1);
    final to = DateTime(focused.year, focused.month + 1, 0);
    return _service.getOverview(formatDate(from), formatDate(to));
  }
}
