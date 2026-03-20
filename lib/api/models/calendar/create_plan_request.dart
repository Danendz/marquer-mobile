import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:marquer/api/models/calendar/plan_schedule.dart';

part 'create_plan_request.freezed.dart';
part 'create_plan_request.g.dart';

@freezed
abstract class CreatePlanTaskRequest with _$CreatePlanTaskRequest {
  @JsonSerializable(includeIfNull: false)
  const factory CreatePlanTaskRequest({
    required String name,
    @JsonKey(name: 'sort_order') required int sortOrder,
    @JsonKey(name: 'start_time') String? startTime,
    @JsonKey(name: 'end_time') String? endTime,
  }) = _CreatePlanTaskRequest;

  factory CreatePlanTaskRequest.fromJson(Map<String, dynamic> json) =>
      _$CreatePlanTaskRequestFromJson(json);
}

@freezed
abstract class CreatePlanRequest with _$CreatePlanRequest {
  @JsonSerializable(includeIfNull: false, explicitToJson: true)
  const factory CreatePlanRequest({
    required String name,
    @JsonKey(toJson: _scheduleToJson, fromJson: PlanSchedule.fromJson)
    required PlanSchedule schedule,
    @JsonKey(name: 'start_date') required String startDate,
    @JsonKey(name: 'end_date') String? endDate,
    String? color,
    required List<CreatePlanTaskRequest> tasks,
  }) = _CreatePlanRequest;

  factory CreatePlanRequest.fromJson(Map<String, dynamic> json) =>
      _$CreatePlanRequestFromJson(json);
}

Map<String, dynamic> _scheduleToJson(PlanSchedule s) => s.toJson();
