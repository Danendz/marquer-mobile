import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';

class NoteEditorBottomToolbar extends StatelessWidget {
  final QuillController controller;

  const NoteEditorBottomToolbar({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          IconButton(
            icon: const Icon(Icons.check_circle_outline_outlined),
            onPressed: () => controller.formatSelection(Attribute.unchecked),
          ),
          IconButton(
            icon: const Icon(Icons.format_list_numbered),
            onPressed: () => controller.formatSelection(Attribute.ol),
          ),
          IconButton(
            icon: const Icon(Icons.format_list_bulleted),
            onPressed: () => controller.formatSelection(Attribute.ul),
          ),
          IconButton(
            icon: const Icon(Icons.format_underline),
            onPressed: () => controller.formatSelection(Attribute.underline),
          ),
          IconButton(
            icon: const Icon(Icons.format_bold),
            onPressed: () => controller.formatSelection(Attribute.bold),
          ),
          IconButton(
            icon: const Icon(Icons.format_italic),
            onPressed: () => controller.formatSelection(Attribute.italic),
          ),
          IconButton(
            icon: const Icon(Icons.format_align_left),
            onPressed: () =>
                controller.formatSelection(Attribute.leftAlignment),
          ),
          IconButton(
            icon: const Icon(Icons.format_align_center),
            onPressed: () =>
                controller.formatSelection(Attribute.centerAlignment),
          ),
          IconButton(
            icon: const Icon(Icons.format_align_right),
            onPressed: () =>
                controller.formatSelection(Attribute.rightAlignment),
          ),
          IconButton(
            icon: const Icon(Icons.format_align_right),
            onPressed: () =>
                controller.formatSelection(Attribute.rightAlignment),
          ),
        ],
      ),
    );
  }
}
