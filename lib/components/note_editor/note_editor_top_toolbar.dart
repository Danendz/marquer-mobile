import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';

import 'helpers.dart';

class NoteEditorTopToolbar extends StatelessWidget {
  final QuillController controller;

  const NoteEditorTopToolbar({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(icon: const Icon(Icons.format_clear), onPressed: () => clearFormatting(controller)),
        IconButton(icon: const Icon(Icons.undo), onPressed: controller.undo),
        IconButton(icon: const Icon(Icons.redo), onPressed: controller.redo),
      ],
    );
  }
}
