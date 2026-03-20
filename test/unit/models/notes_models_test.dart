import 'package:flutter_test/flutter_test.dart';
import 'package:marquer/api/models/notes/create_note_request.dart';
import 'package:marquer/api/models/notes/list_note.dart';
import 'package:marquer/api/models/notes/note.dart';
import 'package:marquer/api/models/notes/update_note_request.dart';

void main() {
  group('Note', () {
    test('round-trip fromJson/toJson', () {
      final json = {
        'id': 1, 'title': 'My Note', 'content': 'Body text',
        'created_at': '2026-01-01', 'updated_at': '2026-01-02',
      };
      final note = Note.fromJson(json);
      expect(note.title, 'My Note');
      expect(Note.fromJson(note.toJson()), note);
    });
  });

  group('ListNote', () {
    test('round-trip', () {
      final json = {'id': 1, 'title': 'Note', 'created_at': 'c', 'updated_at': 'u'};
      final obj = ListNote.fromJson(json);
      expect(ListNote.fromJson(obj.toJson()), obj);
    });
  });

  group('CreateNoteRequest', () {
    test('round-trip', () {
      final obj = CreateNoteRequest(title: 'T', content: 'C');
      expect(CreateNoteRequest.fromJson(obj.toJson()), obj);
    });
  });

  group('UpdateNoteRequest', () {
    test('round-trip', () {
      final obj = UpdateNoteRequest(content: 'Updated');
      expect(UpdateNoteRequest.fromJson(obj.toJson()), obj);
    });
  });
}
