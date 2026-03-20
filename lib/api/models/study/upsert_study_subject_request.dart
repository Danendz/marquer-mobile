import 'package:freezed_annotation/freezed_annotation.dart';

part 'upsert_study_subject_request.freezed.dart';
part 'upsert_study_subject_request.g.dart';

@freezed
abstract class UpsertStudySubjectRequest with _$UpsertStudySubjectRequest {
  const factory UpsertStudySubjectRequest({
    required String name,
    required String color,
  }) = _UpsertStudySubjectRequest;

  factory UpsertStudySubjectRequest.fromJson(Map<String, dynamic> json) =>
      _$UpsertStudySubjectRequestFromJson(json);
}
