class UserStudySettings {
  final int defaultWorkMinutes;
  final int defaultShortBreakMinutes;
  final int defaultLongBreakMinutes;
  final int defaultCycles;

  UserStudySettings({
    required this.defaultWorkMinutes,
    required this.defaultShortBreakMinutes,
    required this.defaultLongBreakMinutes,
    required this.defaultCycles,
  });

  factory UserStudySettings.fromJson(Map<String, dynamic> json) =>
      UserStudySettings(
        defaultWorkMinutes: json['default_work_minutes'] as int? ?? 25,
        defaultShortBreakMinutes:
            json['default_short_break_minutes'] as int? ?? 5,
        defaultLongBreakMinutes:
            json['default_long_break_minutes'] as int? ?? 15,
        defaultCycles: json['default_cycles'] as int? ?? 4,
      );

  Map<String, dynamic> toJson() => {
    'default_work_minutes': defaultWorkMinutes,
    'default_short_break_minutes': defaultShortBreakMinutes,
    'default_long_break_minutes': defaultLongBreakMinutes,
    'default_cycles': defaultCycles,
  };

  UserStudySettings copyWith({
    int? defaultWorkMinutes,
    int? defaultShortBreakMinutes,
    int? defaultLongBreakMinutes,
    int? defaultCycles,
  }) => UserStudySettings(
    defaultWorkMinutes: defaultWorkMinutes ?? this.defaultWorkMinutes,
    defaultShortBreakMinutes:
        defaultShortBreakMinutes ?? this.defaultShortBreakMinutes,
    defaultLongBreakMinutes:
        defaultLongBreakMinutes ?? this.defaultLongBreakMinutes,
    defaultCycles: defaultCycles ?? this.defaultCycles,
  );
}
