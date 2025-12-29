import 'package:get_it/get_it.dart';
import 'package:marquer/api/api.dart';
import 'package:marquer/api/models/notes/create_note_request.dart';
import 'package:marquer/api/models/notes/update_note_request.dart';

import '../models/notes/list_note.dart';
import '../models/model_parser.dart';
import '../models/notes/note.dart';

final getIt = GetIt.instance;

final class NotesService {
  final api = getIt<ApiService>(instanceName: 'api');

  Future<List<ListNote>> getNotes() async {
    final resp = await api.get<List<ListNote>>(
      '/notes',
      fromJsonT: (json) => ModelParser.listFromJson(json, ListNote.fromJson),
    );

    return resp.data;
  }

  Future<Note> getNote(String id) async {
    final resp = await api.get<Note>(
      '/notes/$id',
      fromJsonT: (json) => ModelParser.objectFromJson(json, Note.fromJson),
    );

    return resp.data;
  }

  Future<Note> createNote(CreateNoteRequest request) async {
    final resp = await api.post<Note>(
      '/notes',
      body: request,
      fromJsonT: (json) => ModelParser.objectFromJson(json, Note.fromJson),
    );

    return resp.data;
  }

  Future<Note> updateNote(String id, UpdateNoteRequest request) async {
    final resp = await api.put<Note>(
      '/notes/$id',
      body: request,
      fromJsonT: (json) => ModelParser.objectFromJson(json, Note.fromJson),
    );

    return resp.data;
  }

  Future<Null> deleteNote(String id) async {
    final resp = await api.delete('/notes/$id');

    return resp.data;
  }
}
