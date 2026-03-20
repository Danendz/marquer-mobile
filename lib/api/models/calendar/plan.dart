import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:marquer/api/models/calendar/plan_schedule.dart';
import 'package:marquer/api/models/calendar/plan_task.dart';

part 'plan.freezed.dart';
part 'plan.g.dart';

@freezed
abstract class Plan with _$Plan {
  @JsonSerializable(explicitToJson: true)
  const factory Plan({
    required int id,
    required String name,
    @JsonKey(fromJson: PlanSchedule.fromJson, toJson: _scheduleToJson)
    required PlanSchedule schedule,
    @JsonKey(name: 'start_date') required String startDate,
    @JsonKey(name: 'end_date') String? endDate,
    @JsonKey(name: 'is_active') required bool isActive,
    String? color,
    required List<PlanTask> tasks,
    @JsonKey(name: 'created_at') required String createdAt,
    @JsonKey(name: 'updated_at') required String updatedAt,
  }) = _Plan;

  factory Plan.fromJson(Map<String, dynamic> json) => _$PlanFromJson(json);
}

Map<String, dynamic> _scheduleToJson(PlanSchedule schedule) => schedule.toJson();
