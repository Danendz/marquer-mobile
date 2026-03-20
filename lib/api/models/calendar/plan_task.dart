import 'package:freezed_annotation/freezed_annotation.dart';

part 'plan_task.freezed.dart';
part 'plan_task.g.dart';

@freezed
abstract class PlanTask with _$PlanTask {
  const factory PlanTask({
    required int id,
    required String name,
    @JsonKey(name: 'sort_order') required int sortOrder,
    @JsonKey(name: 'start_time') String? startTime,
    @JsonKey(name: 'end_time') String? endTime,
  }) = _PlanTask;

  factory PlanTask.fromJson(Map<String, dynamic> json) =>
      _$PlanTaskFromJson(json);
}
