class CalendarOverview {
  final Set<String> datesWithIncomplete;

  CalendarOverview({required this.datesWithIncomplete});

  factory CalendarOverview.fromJson(Map<String, dynamic> json) => CalendarOverview(
    datesWithIncomplete: Set<String>.from(json['dates_with_incomplete'] as List),
  );
}
