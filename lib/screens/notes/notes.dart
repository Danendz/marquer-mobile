import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:marquer/components/notes/notes_tiles.dart';
import 'package:marquer/providers/notes/notes_provider.dart';

class NotesPage extends ConsumerWidget {
  const NotesPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notesAsync = ref.watch(notesProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Notes"),
      ),
      body: RefreshIndicator(
        onRefresh: () => ref.refresh(notesProvider.future),
        child: notesAsync.when(
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (e, _) => Center(child: Text('Error: $e')),
          data: (notes) => NotesTiles(notes: notes),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.go("/notes/add"),
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
