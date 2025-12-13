import 'package:flutter/material.dart';
import 'package:super_editor/super_editor.dart';

class NoteSuperEditor extends StatefulWidget {
  final MutableDocument? document;
  final void Function(MutableDocument document)? onChanged;

  const NoteSuperEditor({super.key, this.document, this.onChanged});

  @override
  State<NoteSuperEditor> createState() => _NoteSuperEditorState();
}

class _NoteSuperEditorState extends State<NoteSuperEditor> {
  late final Editor _editor;
  final _popoverToolbarController = OverlayPortalController();
  late final MutableDocument _document;
  late final MutableDocumentComposer _composer;

  @override
  void initState() {
    super.initState();
    _document = MutableDocument.empty();

    _composer = MutableDocumentComposer();
    _composer.selectionNotifier.addListener(_hideOrShowToolbar);

    _editor = createDefaultDocumentEditor(
      document: _document,
      composer: _composer,
    );
  }

  void _hideOrShowToolbar() {
    final selection = _composer.selection;
    if (selection == null) {
      // Nothing is selected. We don't want to show a toolbar in this case.
      _popoverToolbarController.hide();
      return;
    }

    if (selection.isCollapsed) {
      // We only want to show the toolbar when a span of text
      // is selected. Therefore, we ignore collapsed selections.
      _popoverToolbarController.hide();
      return;
    }

    // We have an expanded selection. Show the toolbar.
    _popoverToolbarController.show();
  }

  @override
  void dispose() {
    _editor.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return OverlayPortal(
      controller: _popoverToolbarController,
      overlayChildBuilder: _buildPopoverToolbar,
      child: SuperEditor(editor: _editor),
    );
  }

  Widget _buildPopoverToolbar(BuildContext context) {
    return const SizedBox();
  }
}
