import 'package:freezed_annotation/freezed_annotation.dart';

part 'upsert_task_folder_request.freezed.dart';
part 'upsert_task_folder_request.g.dart';

@freezed
abstract class UpsertTaskFolderRequest with _$UpsertTaskFolderRequest {
  const factory UpsertTaskFolderRequest({
    required String name,
  }) = _UpsertTaskFolderRequest;

  factory UpsertTaskFolderRequest.fromJson(Map<String, dynamic> json) =>
      _$UpsertTaskFolderRequestFromJson(json);
}
