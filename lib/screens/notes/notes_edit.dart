import 'package:flutter/material.dart';
import 'package:marquer/components/note_super_editor/note_super_editor.dart';

class NotesEditPage extends StatefulWidget {
  const NotesEditPage({super.key, required this.id});

  final String id;

  @override
  State<NotesEditPage> createState() => _NotesEditPageState();
}

class _NotesEditPageState extends State<NotesEditPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: .center,
          children: [
            Expanded(
              child: const NoteSuperEditor()
            )
          ],
        ),
      ),
    );
  }
}
