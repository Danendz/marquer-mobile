import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:marquer/api/models/notes/list_note.dart';
import 'package:marquer/api/services/notes_service.dart';

class NotesPage extends StatefulWidget {
  const NotesPage({super.key});

  @override
  State<NotesPage> createState() => _NotesPageState();
}

class _NotesPageState extends State<NotesPage> {
  bool _loading = false;
  List<ListNote> notes = List.empty();

  @override
  void initState() {
    super.initState();
    _getNotes();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _loading
            ? const CircularProgressIndicator()
            : ListView.builder(
                itemCount: notes.length,
                itemBuilder: (context, i) {
                  final note = notes[i];
                  return ListTile(
                    title: Text(note.title),
                    onTap: () => context.go('/notes/${note.id}'),
                  );
                },
              ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.go("/notes/add"),
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }

  Future<void> _getNotes() async {
    setState(() => _loading = true);

    try {
      final notesService = NotesService();
      final result = await notesService.getNotes();
      setState(() {
        notes = result;
      });
    } finally {
      setState(() => _loading = false);
    }
  }
}
