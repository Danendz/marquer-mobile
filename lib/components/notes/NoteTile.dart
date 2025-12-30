import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:marquer/api/models/notes/list_note.dart';
import 'package:marquer/api/services/notes_service.dart';

class NoteTile extends StatefulWidget {
  final ListNote note;
  final Function(int id) onDeleted;

  const NoteTile({super.key, required this.note, required this.onDeleted});

  @override
  State<NoteTile> createState() => _NoteTileState();
}

class _NoteTileState extends State<NoteTile> {
  ListNote get note => widget.note;
  Offset _tapPosition = Offset.zero;
  bool _loading = false;
  final notesService = NotesService();

  Future<void> onLongPress(BuildContext context) async {
    await HapticFeedback.mediumImpact();

    final result = await showMenu(
      context: context,
      // Use the captured _tapPosition
      position: RelativeRect.fromLTRB(
        _tapPosition.dx,
        _tapPosition.dy,
        _tapPosition.dx,
        _tapPosition.dy,
      ),
      items: [
        const PopupMenuItem(
          value: 'edit',
          child: Row(
            children: [Icon(Icons.edit), SizedBox(width: 8), Text('Edit')],
          ),
        ),
        const PopupMenuItem(
          value: 'delete',
          child: Row(
            children: [
              Icon(Icons.delete, color: Colors.red),
              SizedBox(width: 8),
              Text('Delete'),
            ],
          ),
        ),
      ],
    );

    if (result == 'edit') {
      context.go('/notes/${note.id}');
    } else if (result == 'delete') {
      try {
        setState(() {
          _loading = true;
        });
        await notesService.deleteNote(note.id.toString());
        widget.onDeleted(note.id);
      } finally {
        setState(() {
          _loading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(
          child: Card(
            margin: EdgeInsets.zero,
            elevation: 1,
            clipBehavior: Clip.hardEdge,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(10),
                bottomRight: Radius.circular(10),
              ),
            ),
            child: InkWell(
              onTapDown: (details) {
                _tapPosition = details.globalPosition;
              },
              onTap: () => _loading ? null : context.go('/notes/${note.id}'),
              onLongPress: () async => _loading ? null : await onLongPress(context),
              child: Center(
                child: _loading ? const CircularProgressIndicator() : Icon(Icons.description, size: 40, color: Colors.grey),
              ),
            ),
          ),
        ),
        const SizedBox(height: 8),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4.0),
          child: Text(note.title /*...*/),
        ),
      ],
    );
  }
}
