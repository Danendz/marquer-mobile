import 'package:freezed_annotation/freezed_annotation.dart';

part 'list_note.freezed.dart';
part 'list_note.g.dart';

@freezed
abstract class ListNote with _$ListNote {
  const factory ListNote({
    required int id,
    required String title,
    @JsonKey(name: 'created_at') required String createdAt,
    @JsonKey(name: 'updated_at') required String updatedAt,
  }) = _ListNote;

  factory ListNote.fromJson(Map<String, dynamic> json) =>
      _$ListNoteFromJson(json);
}
