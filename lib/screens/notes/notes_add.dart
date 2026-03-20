import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:marquer/api/models/notes/create_note_request.dart';
import 'package:marquer/components/note_editor/note_editor.dart';
import 'package:marquer/providers/notes/notes_provider.dart';

class NotesAddPage extends ConsumerWidget {
  const NotesAddPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: NoteEditor(
                onSave: (jsonContent) => ref
                    .read(notesProvider.notifier)
                    .create(CreateNoteRequest(content: jsonContent, title: 'new note')),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
