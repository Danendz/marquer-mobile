import 'package:freezed_annotation/freezed_annotation.dart';

part 'create_note_request.freezed.dart';
part 'create_note_request.g.dart';

@freezed
abstract class CreateNoteRequest with _$CreateNoteRequest {
  const factory CreateNoteRequest({
    required String title,
    required String content,
  }) = _CreateNoteRequest;

  factory CreateNoteRequest.fromJson(Map<String, dynamic> json) =>
      _$CreateNoteRequestFromJson(json);
}
