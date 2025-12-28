import 'package:marquer/api/api.dart';

import '../models/notes/list_note.dart';
import '../models/model_parser.dart';
import '../models/notes/note.dart';

final class NotesService {
  final api = ApiService();

  Future<List<ListNote>> getNotes() async {
    final resp = await api.get<List<ListNote>>(
      '/notes',
      fromJsonT: (json) => ModelParser.listFromJson(json, ListNote.fromJson),
    );

    return resp.data;
  }

  Future<Note> getNote(int id) async {
    final resp = await api.get<Note>(
      '/notes/$id',
      fromJsonT: (json) => ModelParser.objectFromJson(json, Note.fromJson),
    );

    return resp.data;
  }
}
