import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:marquer/api/models/tasks/tasks/task_status.dart';

part 'get_tasks_request.freezed.dart';
part 'get_tasks_request.g.dart';

@freezed
abstract class GetTasksRequest with _$GetTasksRequest {
  @JsonSerializable(includeIfNull: false)
  const factory GetTasksRequest({
    @JsonKey(name: 'task_category_id') int? taskCategoryId,
    @JsonKey(name: 'task_folder_id') int? taskFolderId,
    TaskStatus? status,
    String? date,
  }) = _GetTasksRequest;

  factory GetTasksRequest.fromJson(Map<String, dynamic> json) =>
      _$GetTasksRequestFromJson(json);
}
