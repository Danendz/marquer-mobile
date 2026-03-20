// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'calendar_overview.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_CalendarOverview _$CalendarOverviewFromJson(Map<String, dynamic> json) =>
    _CalendarOverview(
      datesWithIncomplete: _setFromJson(json['tasks']),
      datesWithPlans: _setFromJson(json['plan_tasks']),
    );

Map<String, dynamic> _$CalendarOverviewToJson(_CalendarOverview instance) =>
    <String, dynamic>{
      'tasks': instance.datesWithIncomplete.toList(),
      'plan_tasks': instance.datesWithPlans.toList(),
    };
