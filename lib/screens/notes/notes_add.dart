import 'package:flutter/material.dart';
import 'package:marquer/components/note_editor/note_editor.dart';

class NotesAddPage extends StatefulWidget {
  const NotesAddPage({super.key});

  @override
  State<NotesAddPage> createState() => _NotesAddPageState();
}

class _NotesAddPageState extends State<NotesAddPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Expanded(
                child: const NoteEditor(),
              )
            ],
          ),
        ),
      ),
    );
  }
}
