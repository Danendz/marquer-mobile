import 'package:flutter/material.dart';
import 'package:marquer/api/models/notes/list_note.dart';
import 'package:marquer/components/notes/NoteTile.dart';

class NotesTiles extends StatelessWidget {
  final List<ListNote> notes;
  final Function(int id) onDeleted;

  const NotesTiles({super.key, required this.notes, required this.onDeleted});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GridView.builder(
        padding: const EdgeInsets.all(10),
        itemCount: notes.length,
        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 150, // Maximum width of each item before wrapping
          childAspectRatio: 0.75, // ratio 1.0 = Square (width == height)
          crossAxisSpacing: 15, // Horizontal space between items
          mainAxisSpacing: 15, // Vertical space between items
        ),
        itemBuilder: (context, i) {
          final note = notes[i];
          return NoteTile(note: note, onDeleted: onDeleted);
        },
      ),
    );
  }
}
