import 'package:freezed_annotation/freezed_annotation.dart';

part 'study_subject.freezed.dart';
part 'study_subject.g.dart';

@freezed
abstract class StudySubject with _$StudySubject {
  const factory StudySubject({
    required int id,
    required String name,
    required String color,
    @JsonKey(name: 'is_system') required bool isSystem,
    @JsonKey(name: 'created_at') required String createdAt,
  }) = _StudySubject;

  factory StudySubject.fromJson(Map<String, dynamic> json) =>
      _$StudySubjectFromJson(json);
}
