import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';

class NoteViewer extends StatelessWidget {
  final List<dynamic> jsonDelta;

  const NoteViewer({super.key, required this.jsonDelta});

  @override
  Widget build(BuildContext context) {
    final doc = Document.fromJson(jsonDelta);
    final readOnlyController = QuillController(
      document: doc,
      selection: const TextSelection.collapsed(offset: 0),
      readOnly: true,
    );

    return QuillEditor.basic(controller: readOnlyController);
  }
}
