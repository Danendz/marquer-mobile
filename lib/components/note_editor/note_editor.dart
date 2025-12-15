import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:marquer/components/note_editor/note_editor_bottom_toolbar.dart';
import 'package:marquer/components/note_editor/note_editor_top_toolbar.dart';

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
    final cs = Theme.of(context).colorScheme;
    return Column(
      children: [
        NoteEditorTopToolbar(controller: controller),
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
              controller: controller,
              focusNode: _focusNode,
              config: QuillEditorConfig(
                customStyles: DefaultStyles(
                  paragraph: DefaultTextBlockStyle(
                    TextStyle(
                      fontSize: 18, // default font size
                      height: 1.4, // line height multiplier
                      color: cs.onSurface,
                    ),
                    const HorizontalSpacing(0, 0),
                    const VerticalSpacing(0, 0),
                    const VerticalSpacing(0, 0),
                    null
                  ),
                ),
              ),
            ),
          ),
        ),
        const Divider(height: 1),
        NoteEditorBottomToolbar(controller: controller),
      ],
    );
  }
}
