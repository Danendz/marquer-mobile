import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:marquer/components/calendar/week_view/week_page.dart';
import 'package:marquer/components/calendar/week_view/week_view_constants.dart';
import 'package:marquer/providers/calendar/calendar_selected_date_provider.dart';

class WeekView extends ConsumerStatefulWidget {
  const WeekView({super.key});

  @override
  ConsumerState<WeekView> createState() => _WeekViewState();
}

class _WeekViewState extends ConsumerState<WeekView> {
  late final PageController _pageController;
  late DateTime _baseMonday;
  static const int _kInitialPage = 1000;
  final _scrollOffsets = <int, double>{};
  double _defaultScrollOffset() =>
      ((DateTime.now().hour * kPixelsPerHour) - 80).clamp(0.0, double.infinity);

  @override
  void initState() {
    super.initState();
    final selected = ref.read(calendarSelectedDateProvider);
    _baseMonday = _mondayOf(selected);
    _pageController = PageController(initialPage: _kInitialPage);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  DateTime _mondayOf(DateTime d) => d.subtract(Duration(days: d.weekday - 1));

  DateTime _mondayForPage(int page) =>
      _baseMonday.add(Duration(days: (page - _kInitialPage) * 7));

  void _onPageChanged(int page) {
    final monday = _mondayForPage(page);
    final selected = ref.read(calendarSelectedDateProvider);
    // Keep same weekday in the new week
    final weekday = selected.weekday; // 1=Mon..7=Sun
    final newDate = monday.add(Duration(days: weekday - 1));
    ref.read(calendarSelectedDateProvider.notifier).select(newDate);
  }

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      controller: _pageController,
      onPageChanged: _onPageChanged,
      itemBuilder: (context, page) {
        final monday = _mondayForPage(page);
        return WeekPage(
          monday: monday,
          initialScrollOffset: _scrollOffsets[page] ?? _defaultScrollOffset(),
          onScrollChanged: (offset) => _scrollOffsets[page] = offset,
        );
      },
    );
  }
}
