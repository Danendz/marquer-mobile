import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';

import 'helpers.dart';

class NoteEditorTopToolbar extends StatelessWidget {
  final QuillController controller;
  final VoidCallback onSave;
  final bool loading;

  const NoteEditorTopToolbar({
    super.key,
    required this.controller,
    required this.onSave,
    required this.loading,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
          icon: const Icon(Icons.format_clear),
          onPressed: () => clearFormatting(controller),
        ),
        IconButton(icon: const Icon(Icons.undo), onPressed: controller.undo),
        IconButton(icon: const Icon(Icons.redo), onPressed: controller.redo),
        const Spacer(),

        IconButton(icon: loading ? const CircularProgressIndicator() : const Icon(Icons.check), onPressed: onSave),
      ],
    );
  }
}
