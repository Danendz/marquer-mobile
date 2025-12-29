import 'package:flutter/material.dart';
import 'package:marquer/components/note_editor/note_editor.dart';

class NotesEditPage extends StatefulWidget {
  final String id;
  const NotesEditPage({super.key, required this.id});

  @override
  State<NotesEditPage> createState() => _NotesEditPageState();
}

class _NotesEditPageState extends State<NotesEditPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(children: [Expanded(child: NoteEditor(id: widget.id ))]),
      ),
    );
  }
}
