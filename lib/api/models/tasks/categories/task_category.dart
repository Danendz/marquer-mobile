import 'package:freezed_annotation/freezed_annotation.dart';

part 'task_category.freezed.dart';
part 'task_category.g.dart';

@freezed
abstract class TaskCategory with _$TaskCategory {
  const factory TaskCategory({
    int? id,
    required String name,
    required String color,
    @JsonKey(name: 'tasks_count') @Default(0) int tasksCount,
    @JsonKey(name: 'created_at') String? createdAt,
    @JsonKey(name: 'updated_at') String? updatedAt,
    @JsonKey(includeFromJson: false, includeToJson: false) String? tempNewUUID,
  }) = _TaskCategory;

  factory TaskCategory.fromJson(Map<String, dynamic> json) =>
      _$TaskCategoryFromJson(json);
}
