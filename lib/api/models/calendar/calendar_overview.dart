import 'package:freezed_annotation/freezed_annotation.dart';

part 'calendar_overview.freezed.dart';
part 'calendar_overview.g.dart';

@freezed
abstract class CalendarOverview with _$CalendarOverview {
  const factory CalendarOverview({
    @JsonKey(name: 'tasks', fromJson: _setFromJson) required Set<String> datesWithIncomplete,
    @JsonKey(name: 'plan_tasks', fromJson: _setFromJson) required Set<String> datesWithPlans,
  }) = _CalendarOverview;

  factory CalendarOverview.fromJson(Map<String, dynamic> json) =>
      _$CalendarOverviewFromJson(json);
}

Set<String> _setFromJson(dynamic json) => Set<String>.from(json as List);
