import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:marquer/api/models/tasks/categories/task_category.dart';
import 'package:marquer/providers/tasks/task_folders_provider.dart';
import 'package:marquer/utils/action_sheet.dart';
import 'package:marquer/utils/colors.dart';

class TaskCategoryItem extends ConsumerStatefulWidget {
  final TaskCategory taskCategory;
  final int folderId;
  final bool isEditable; // true = new unsaved category

  const TaskCategoryItem({
    super.key,
    required this.taskCategory,
    required this.folderId,
    required this.isEditable,
  });

  @override
  ConsumerState<TaskCategoryItem> createState() => _TaskCategoryItemState();
}

class _TaskCategoryItemState extends ConsumerState<TaskCategoryItem> {
  TaskCategory get taskCategory => widget.taskCategory;
  int get folderId => widget.folderId;

  late final TextEditingController _nameCtrl;
  late final FocusNode _focusNode;
  bool _isRenaming = false;
  bool _isBusy = false;

  bool get _isEditing => widget.isEditable || _isRenaming;

  @override
  void initState() {
    super.initState();
    _nameCtrl = TextEditingController(text: taskCategory.name);
    _focusNode = FocusNode();
    _focusNode.addListener(_onFocusChange);
    if (widget.isEditable) {
      WidgetsBinding.instance.addPostFrameCallback((_) => _focusNode.requestFocus());
    }
  }

  @override
  void dispose() {
    _focusNode.removeListener(_onFocusChange);
    _focusNode.dispose();
    _nameCtrl.dispose();
    super.dispose();
  }

  void _onFocusChange() {
    if (!_focusNode.hasFocus && _isEditing && !_isBusy) {
      final name = _nameCtrl.text.trim();
      if (name.isNotEmpty) {
        _save();
      } else if (widget.isEditable) {
        _discard();
      } else {
        setState(() => _isRenaming = false);
        _nameCtrl.text = taskCategory.name;
      }
    }
  }

  Future<void> _save() async {
    final name = _nameCtrl.text.trim();
    if (name.isEmpty || _isBusy) return;
    setState(() => _isBusy = true);
    try {
      final notifier = ref.read(taskFoldersProvider.notifier);
      if (taskCategory.id == null) {
        await notifier.saveNewCategory(folderId, taskCategory.copyWith(name: name));
      } else {
        await notifier.updateCategory(folderId, taskCategory.copyWith(name: name));
        if (mounted) setState(() => _isRenaming = false);
      }
    } finally {
      if (mounted) setState(() => _isBusy = false);
    }
  }

  Future<void> _discard() async {
    await ref.read(taskFoldersProvider.notifier).deleteCategory(folderId, taskCategory);
  }

  Future<void> _openColorPicker() async {
    Color temp = colorFromHex(taskCategory.color) ?? const Color(0xffffffff);
    final picked = await showDialog<Color>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Pick a color'),
        content: SingleChildScrollView(
          child: ColorPicker(
            pickerColor: temp,
            onColorChanged: (c) => temp = c,
            enableAlpha: false,
          ),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Cancel')),
          TextButton(onPressed: () => Navigator.pop(ctx, temp), child: const Text('OK')),
        ],
      ),
    );
    if (mounted && picked != null) {
      setState(() => _isBusy = true);
      try {
        await ref.read(taskFoldersProvider.notifier).updateCategory(
          folderId,
          taskCategory.copyWith(color: colorToHex(picked), name: _nameCtrl.text.trim()),
        );
      } finally {
        if (mounted) setState(() => _isBusy = false);
      }
    }
  }

  Future<void> _onLongPress() async {
    if (widget.isEditable) return;
    await HapticFeedback.mediumImpact();
    if (!mounted) return;
    final result = await showAppActionSheet(context, const [
      AppAction(value: 'rename', icon: Icons.edit_outlined, label: 'Rename'),
      AppAction(value: 'delete', icon: Icons.delete_outline, label: 'Delete', isDestructive: true),
    ]);
    if (!mounted || result == null) return;
    if (result == 'rename') {
      setState(() {
        _isRenaming = true;
        _nameCtrl.text = taskCategory.name;
      });
      WidgetsBinding.instance.addPostFrameCallback((_) => _focusNode.requestFocus());
    } else if (result == 'delete') {
      await ref.read(taskFoldersProvider.notifier).deleteCategory(folderId, taskCategory);
    }
  }

  @override
  Widget build(BuildContext context) {
    final colors = getColors(context);
    final catColor = colorFromHex(taskCategory.color) ?? colors.primary;

    if (_isEditing) {
      return Container(
        margin: const EdgeInsets.only(top: 6, bottom: 2),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        decoration: BoxDecoration(
          color: colors.surface,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            GestureDetector(
              onTap: _openColorPicker,
              child: _ColorDot(color: catColor),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: TextField(
                controller: _nameCtrl,
                focusNode: _focusNode,
                readOnly: _isBusy,
                decoration: const InputDecoration(
                  hintText: 'Category name...',
                  border: InputBorder.none,
                  isDense: true,
                  contentPadding: EdgeInsets.zero,
                ),
                onSubmitted: (_) => _save(),
              ),
            ),
          ],
        ),
      );
    }

    return GestureDetector(
      onLongPress: _onLongPress,
      behavior: HitTestBehavior.opaque,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Row(
          children: [
            GestureDetector(
              onTap: _openColorPicker,
              child: _ColorDot(color: catColor),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(taskCategory.name, style: const TextStyle(fontSize: 14)),
            ),
            Text(
              taskCategory.tasksCount.toString(),
              style: TextStyle(fontSize: 13, color: colors.onSurface.withValues(alpha: 0.4)),
            ),
          ],
        ),
      ),
    );
  }
}

class _ColorDot extends StatelessWidget {
  final Color color;

  const _ColorDot({required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 18,
      height: 18,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
        border: Border.all(
          color: color.withValues(alpha: 0.6),
          width: 2,
        ),
      ),
    );
  }
}
