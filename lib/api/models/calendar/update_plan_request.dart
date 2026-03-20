import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:marquer/api/models/calendar/plan_schedule.dart';

part 'update_plan_request.freezed.dart';
part 'update_plan_request.g.dart';

@freezed
abstract class UpdatePlanTaskRequest with _$UpdatePlanTaskRequest {
  @JsonSerializable(includeIfNull: false)
  const factory UpdatePlanTaskRequest({
    int? id,
    required String name,
    @JsonKey(name: 'sort_order') required int sortOrder,
    @JsonKey(name: 'start_time') String? startTime,
    @JsonKey(name: 'end_time') String? endTime,
  }) = _UpdatePlanTaskRequest;

  factory UpdatePlanTaskRequest.fromJson(Map<String, dynamic> json) =>
      _$UpdatePlanTaskRequestFromJson(json);
}

@freezed
abstract class UpdatePlanRequest with _$UpdatePlanRequest {
  @JsonSerializable(includeIfNull: false, explicitToJson: true)
  const factory UpdatePlanRequest({
    required String name,
    @JsonKey(toJson: _scheduleToJson, fromJson: PlanSchedule.fromJson)
    required PlanSchedule schedule,
    @JsonKey(name: 'start_date') required String startDate,
    @JsonKey(name: 'end_date') String? endDate,
    @JsonKey(name: 'is_active') bool? isActive,
    String? color,
    required List<UpdatePlanTaskRequest> tasks,
  }) = _UpdatePlanRequest;

  factory UpdatePlanRequest.fromJson(Map<String, dynamic> json) =>
      _$UpdatePlanRequestFromJson(json);
}

Map<String, dynamic> _scheduleToJson(PlanSchedule s) => s.toJson();
