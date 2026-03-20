import 'package:flutter/material.dart';
import 'package:marquer/api/models/notes/list_note.dart';
import 'package:marquer/components/notes/note_tile.dart';

class NotesTiles extends StatelessWidget {
  final List<ListNote> notes;

  const NotesTiles({super.key, required this.notes});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GridView.builder(
        padding: const EdgeInsets.all(10),
        itemCount: notes.length,
        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 150,
          childAspectRatio: 0.75,
          crossAxisSpacing: 15,
          mainAxisSpacing: 15,
        ),
        itemBuilder: (context, i) {
          final note = notes[i];
          return NoteTile(note: note);
        },
      ),
    );
  }
}
