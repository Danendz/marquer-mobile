sealed class PlanSchedule {
  const PlanSchedule();

  factory PlanSchedule.fromJson(Map<String, dynamic> json) {
    return switch (json['type'] as String) {
      'daily' => const DailySchedule(),
      'weekly' => WeeklySchedule(days: List<int>.from(json['days'] as List)),
      'interval' => IntervalSchedule(every: json['every'] as int),
      'monthly_dates' => MonthlyDatesSchedule(days: List<int>.from(json['days'] as List)),
      'monthly_weekday' => MonthlyWeekdaySchedule(
        week: json['week'] as int,
        weekday: json['weekday'] as int,
      ),
      _ => throw ArgumentError('Unknown schedule type: ${json['type']}'),
    };
  }

  Map<String, dynamic> toJson();

  String get label {
    return switch (this) {
      DailySchedule() => 'Daily',
      WeeklySchedule(:final days) => 'Weekly (${_weekdayNames(days)})',
      IntervalSchedule(:final every) => 'Every $every days',
      MonthlyDatesSchedule(:final days) => 'Monthly (${days.join(', ')})',
      MonthlyWeekdaySchedule(:final week, :final weekday) =>
        '${_weekLabel(week)} ${_weekdayName(weekday)} of month',
    };
  }
}

class DailySchedule extends PlanSchedule {
  const DailySchedule();

  @override
  Map<String, dynamic> toJson() => {'type': 'daily'};
}

class WeeklySchedule extends PlanSchedule {
  final List<int> days; // 0=Mon..6=Sun

  const WeeklySchedule({required this.days});

  @override
  Map<String, dynamic> toJson() => {'type': 'weekly', 'days': days};
}

class IntervalSchedule extends PlanSchedule {
  final int every;

  const IntervalSchedule({required this.every});

  @override
  Map<String, dynamic> toJson() => {'type': 'interval', 'every': every};
}

class MonthlyDatesSchedule extends PlanSchedule {
  final List<int> days; // day-of-month 1..31

  const MonthlyDatesSchedule({required this.days});

  @override
  Map<String, dynamic> toJson() => {'type': 'monthly_dates', 'days': days};
}

class MonthlyWeekdaySchedule extends PlanSchedule {
  final int week; // -1=last, 1=first..4=fourth
  final int weekday; // 0=Mon..6=Sun

  const MonthlyWeekdaySchedule({required this.week, required this.weekday});

  @override
  Map<String, dynamic> toJson() => {
    'type': 'monthly_weekday',
    'week': week,
    'weekday': weekday,
  };
}

const _weekdayShortNames = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];

String _weekdayName(int index) => _weekdayShortNames[index];

String _weekdayNames(List<int> days) => days.map(_weekdayName).join(', ');

String _weekLabel(int week) {
  return switch (week) {
    1 => 'First',
    2 => 'Second',
    3 => 'Third',
    4 => 'Fourth',
    -1 => 'Last',
    _ => '$week.',
  };
}
