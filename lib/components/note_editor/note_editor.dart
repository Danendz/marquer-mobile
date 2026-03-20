import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:marquer/api/models/notes/note.dart';
import 'package:marquer/api/services/notes_service.dart';
import 'package:marquer/components/note_editor/note_editor_bottom_toolbar.dart';
import 'package:marquer/components/note_editor/note_editor_top_toolbar.dart';

class NoteEditor extends StatefulWidget {
  final String? id;
  final Future<void> Function(String jsonContent)? onSave;

  const NoteEditor({
    super.key,
    this.id,
    this.onSave,
  });

  @override
  State<NoteEditor> createState() => _NoteEditorState();
}

class _NoteEditorState extends State<NoteEditor> {
  late QuillController _controller;
  final _focusNode = FocusNode();
  bool _loading = false;
  bool _loadingNote = false;

  @override
  void initState() {
    super.initState();
    _controller = QuillController.basic();
    if (widget.id != null) {
      _getNote(widget.id!);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    if (_loadingNote) return const Center(child: CircularProgressIndicator());

    return Column(
      children: [
        NoteEditorTopToolbar(
          controller: _controller,
          loading: _loading,
          onSave: _submit,
        ),
        const Divider(height: 1),
        Expanded(
          child: Padding(
            padding: EdgeInsetsGeometry.directional(
              start: 20,
              end: 20,
              top: 15,
              bottom: 15,
            ),
            child: QuillEditor.basic(
              controller: _controller,
              focusNode: _focusNode,
              config: QuillEditorConfig(
                customStyles: DefaultStyles(
                  paragraph: DefaultTextBlockStyle(
                    TextStyle(
                      fontSize: 18,
                      height: 1.4,
                      color: cs.onSurface,
                    ),
                    const HorizontalSpacing(0, 0),
                    const VerticalSpacing(0, 0),
                    const VerticalSpacing(0, 0),
                    null,
                  ),
                ),
              ),
            ),
          ),
        ),
        const Divider(height: 1),
        NoteEditorBottomToolbar(controller: _controller),
      ],
    );
  }

  Future<void> _submit() async {
    setState(() => _loading = true);
    try {
      final jsonContent = jsonEncode(_controller.document.toDelta().toJson());
      if (widget.onSave != null) {
        await widget.onSave!(jsonContent);
      }
    } finally {
      setState(() => _loading = false);
    }
  }

  Future<void> _getNote(String id) async {
    setState(() => _loadingNote = true);
    try {
      final notesService = NotesService();
      final Note note = await notesService.getNote(id);
      final json = jsonDecode(note.content);

      if (!mounted) return;

      setState(() {
        _controller.document = Document.fromJson(json);
        _controller.updateSelection(
          const TextSelection.collapsed(offset: 0),
          ChangeSource.local,
        );
      });
    } finally {
      setState(() => _loadingNote = false);
    }
  }
}
