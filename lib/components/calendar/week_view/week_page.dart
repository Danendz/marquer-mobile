import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:marquer/components/calendar/week_view/day_headers.dart';
import 'package:marquer/components/calendar/week_view/week_body.dart';
import 'package:marquer/providers/calendar/calendar_selected_date_provider.dart';
import 'package:marquer/providers/calendar/week_data_provider.dart';
import 'package:marquer/utils/format.dart';

class WeekPage extends ConsumerStatefulWidget {
  final DateTime monday;
  final double initialScrollOffset;
  final void Function(double)? onScrollChanged;

  const WeekPage({
    super.key,
    required this.monday,
    required this.initialScrollOffset,
    this.onScrollChanged,
  });

  @override
  ConsumerState<WeekPage> createState() => _WeekPageState();
}

class _WeekPageState extends ConsumerState<WeekPage> {
  late final ScrollController _scrollController;

  List<DateTime> get _days => List.generate(7, (i) => widget.monday.add(Duration(days: i)));

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController(initialScrollOffset: widget.initialScrollOffset);
    _scrollController.addListener(() => widget.onScrollChanged?.call(_scrollController.offset));
    // Stale-while-revalidate: show cached data immediately, refresh in background
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final mondayStr = formatDate(widget.monday);
      ref.read(weekDataProvider(mondayStr).notifier).silentRefresh();
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final mondayStr = formatDate(widget.monday);
    final weekAsync = ref.watch(weekDataProvider(mondayStr));
    final selected = ref.watch(calendarSelectedDateProvider);
    final today = DateTime.now();
    final todayStr = formatDate(today);
    final colorScheme = Theme.of(context).colorScheme;

    final days = _days;

    return Column(
      children: [
        DayHeaders(days: days, selected: selected, today: todayStr, colorScheme: colorScheme),
        weekAsync.when(
          loading: () => const Expanded(child: Center(child: CircularProgressIndicator())),
          error: (e, _) => const Expanded(child: Center(child: Text('Failed to load'))),
          data: (data) => WeekBody(
            days: days,
            data: data,
            scrollController: _scrollController,
            colorScheme: colorScheme,
            mondayStr: mondayStr,
          ),
        ),
      ],
    );
  }
}
