import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';

class NoteEditor extends StatefulWidget {
  final QuillController? controller;
  final bool showToolbar;

  const NoteEditor({super.key, this.controller, this.showToolbar = true});

  @override
  State<NoteEditor> createState() => _NoteEditorState();
}

class _NoteEditorState extends State<NoteEditor> {
  late QuillController _controller;
  final _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ?? QuillController.basic();
  }

  @override
  void dispose() {
    if (widget.controller == null) {
      _controller.dispose();
    }
    _focusNode.dispose();
    super.dispose();
  }

  QuillController get controller => _controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (widget.showToolbar) QuillSimpleToolbar(controller: _controller),
        const Divider(height: 1),
        Expanded(
          child: QuillEditor.basic(
            controller: _controller,
            focusNode: _focusNode,
          ),
        ),
      ],
    );
  }
}
