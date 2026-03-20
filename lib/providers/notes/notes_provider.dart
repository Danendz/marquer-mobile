import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:marquer/api/models/notes/create_note_request.dart';
import 'package:marquer/api/models/notes/list_note.dart';
import 'package:marquer/api/models/notes/update_note_request.dart';
import 'package:marquer/api/services/notes_service.dart';
import 'package:marquer/providers/optimistic_mutation.dart';

final notesProvider = AsyncNotifierProvider<NotesNotifier, List<ListNote>>(
  NotesNotifier.new,
);

class NotesNotifier extends AsyncNotifier<List<ListNote>>
    with OptimisticMutation {
  final _service = NotesService();

  @override
  Future<List<ListNote>> build() => _service.getNotes();

  Future<void> create(CreateNoteRequest request) async {
    final current = currentValue;
    if (current == null) return;

    await mutate(
      action: () => _service.createNote(request),
      errorMessage: 'Unable to create note! Try again later',
      onSuccess: (latest, created) => [
        ListNote(
          id: created.id,
          title: created.title,
          createdAt: created.createdAt,
          updatedAt: created.updatedAt,
        ),
        ...latest,
      ],
    );
  }

  Future<void> updateNote(String id, UpdateNoteRequest request) async {
    await mutate(
      action: () => _service.updateNote(id, request),
      errorMessage: 'Unable to update note! Try again later',
    );
  }

  Future<void> delete(int id) async {
    final current = currentValue;
    if (current == null) return;

    state = AsyncData([for (final n in current) if (n.id != id) n]);

    await mutate(
      action: () => _service.deleteNote(id.toString()),
      errorMessage: 'Unable to delete note! Try again later',
      rollback: () => current,
    );
  }
}
