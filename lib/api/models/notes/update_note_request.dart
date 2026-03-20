import 'package:freezed_annotation/freezed_annotation.dart';

part 'update_note_request.freezed.dart';
part 'update_note_request.g.dart';

@freezed
abstract class UpdateNoteRequest with _$UpdateNoteRequest {
  const factory UpdateNoteRequest({
    required String content,
  }) = _UpdateNoteRequest;

  factory UpdateNoteRequest.fromJson(Map<String, dynamic> json) =>
      _$UpdateNoteRequestFromJson(json);
}
