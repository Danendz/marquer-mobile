import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:marquer/api/models/notes/update_note_request.dart';
import 'package:marquer/components/note_editor/note_editor.dart';
import 'package:marquer/providers/notes/notes_provider.dart';

class NotesEditPage extends ConsumerWidget {
  final String id;
  const NotesEditPage({super.key, required this.id});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: NoteEditor(
                id: id,
                onSave: (jsonContent) => ref
                    .read(notesProvider.notifier)
                    .updateNote(id, UpdateNoteRequest(content: jsonContent)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
