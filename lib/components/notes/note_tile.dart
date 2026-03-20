import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:marquer/api/models/notes/list_note.dart';
import 'package:marquer/providers/notes/notes_provider.dart';

class NoteTile extends ConsumerStatefulWidget {
  final ListNote note;

  const NoteTile({super.key, required this.note});

  @override
  ConsumerState<NoteTile> createState() => _NoteTileState();
}

class _NoteTileState extends ConsumerState<NoteTile> {
  ListNote get note => widget.note;
  Offset _tapPosition = Offset.zero;
  bool _loading = false;

  Future<void> onLongPress(BuildContext context) async {
    await HapticFeedback.mediumImpact();
    if (!context.mounted) return;

    final result = await showMenu(
      context: context,
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

    if (!context.mounted) return;

    if (result == 'edit') {
      context.go('/notes/${note.id}');
    } else if (result == 'delete') {
      setState(() => _loading = true);
      try {
        await ref.read(notesProvider.notifier).delete(note.id);
      } finally {
        if (mounted) setState(() => _loading = false);
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
              onTap: _loading ? null : () => context.go('/notes/${note.id}'),
              onLongPress: _loading ? null : () => onLongPress(context),
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
