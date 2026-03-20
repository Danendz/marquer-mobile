import 'package:freezed_annotation/freezed_annotation.dart';

part 'upsert_task_category_request.freezed.dart';
part 'upsert_task_category_request.g.dart';

@freezed
abstract class UpsertTaskCategoryRequest with _$UpsertTaskCategoryRequest {
  @JsonSerializable(includeIfNull: false)
  const factory UpsertTaskCategoryRequest({
    required String name,
    @JsonKey(name: 'task_folder_id') required int taskFolderId,
    String? color,
  }) = _UpsertTaskCategoryRequest;

  factory UpsertTaskCategoryRequest.fromJson(Map<String, dynamic> json) =>
      _$UpsertTaskCategoryRequestFromJson(json);
}
