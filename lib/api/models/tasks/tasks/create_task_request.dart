import 'package:freezed_annotation/freezed_annotation.dart';

part 'create_task_request.freezed.dart';
part 'create_task_request.g.dart';

@freezed
abstract class CreateTaskRequest with _$CreateTaskRequest {
  @JsonSerializable(includeIfNull: false)
  const factory CreateTaskRequest({
    required String name,
    String? date,
    @JsonKey(name: 'start_time') String? startTime,
    @JsonKey(name: 'end_time') String? endTime,
    @JsonKey(name: 'task_category_id') int? taskCategoryId,
    String? color,
  }) = _CreateTaskRequest;

  factory CreateTaskRequest.fromJson(Map<String, dynamic> json) =>
      _$CreateTaskRequestFromJson(json);
}
