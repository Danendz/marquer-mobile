import 'package:freezed_annotation/freezed_annotation.dart';

part 'plan_for_date.freezed.dart';
part 'plan_for_date.g.dart';

@freezed
abstract class PlanTaskForDate with _$PlanTaskForDate {
  const factory PlanTaskForDate({
    required int id,
    required String name,
    @JsonKey(name: 'sort_order') required int sortOrder,
    @JsonKey(name: 'start_time') String? startTime,
    @JsonKey(name: 'end_time') String? endTime,
    @JsonKey(name: 'is_completed') required bool isCompleted,
  }) = _PlanTaskForDate;

  factory PlanTaskForDate.fromJson(Map<String, dynamic> json) =>
      _$PlanTaskForDateFromJson(json);
}

@freezed
abstract class PlanForDate with _$PlanForDate {
  @JsonSerializable(explicitToJson: true)
  const factory PlanForDate({
    required int id,
    required String name,
    String? color,
    required List<PlanTaskForDate> tasks,
  }) = _PlanForDate;

  factory PlanForDate.fromJson(Map<String, dynamic> json) =>
      _$PlanForDateFromJson(json);
}
