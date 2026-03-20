import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:marquer/api/models/tasks/categories/task_category.dart';

part 'task_folder.freezed.dart';
part 'task_folder.g.dart';

@freezed
abstract class TaskFolder with _$TaskFolder {
  @JsonSerializable(explicitToJson: true)
  const factory TaskFolder({
    required int id,
    required String name,
    @Default([]) List<TaskCategory> categories,
    @JsonKey(name: 'created_at') String? createdAt,
    @JsonKey(name: 'updated_at') String? updatedAt,
  }) = _TaskFolder;

  factory TaskFolder.fromJson(Map<String, dynamic> json) =>
      _$TaskFolderFromJson(json);
}
