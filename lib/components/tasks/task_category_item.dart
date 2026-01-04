import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:marquer/api/models/tasks/categories/task_category.dart';
import 'package:marquer/providers/tasks/task_folders_provider.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:marquer/utils/colors.dart';

class TaskCategoryItem extends ConsumerStatefulWidget {
  final TaskCategory taskCategory;
  final int folderId;
  final bool isEditable;

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
  late final TextEditingController _nameCtrl;

  int get folderId => widget.folderId;

  bool get isEditable => widget.isEditable;
  bool _colorUpdating = false;
  bool _saving = false;
  bool _deleting = false;

  @override
  void initState() {
    super.initState();
    _nameCtrl = TextEditingController(text: taskCategory.name);
  }

  @override
  void dispose() {
    _nameCtrl.dispose();
    super.dispose();
  }

  Future<void> _openPicker(WidgetRef ref) async {
    Color temp = colorFromHex(taskCategory.color) ?? const Color(0xffffffff);

    final picked = await showDialog<Color>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Pick a color'),
        content: SingleChildScrollView(
          child: ColorPicker(
            pickerColor: temp,
            onColorChanged: (c) => temp = c,
            enableAlpha: true,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(dialogContext, temp),
            child: const Text('OK'),
          ),
        ],
      ),
    );

    if (mounted && picked != null) {
      _updateColor(ref, taskCategory.copyWith(color: colorToHex(picked), name: _nameCtrl.text));
    }
  }

  Future<void> _updateColor(WidgetRef ref, TaskCategory category) async {
    setState(() {
      _colorUpdating = true;
    });

    try {
      await ref
          .read(taskFoldersProvider.notifier)
          .updateCategory(folderId, category);
    } finally {
      setState(() {
        _colorUpdating = false;
      });
    }
  }

  Future<void> saveCategory(WidgetRef ref) async {
    setState(() {
      _saving = true;
    });
    try {
      final taskFoldersStore = ref.read(taskFoldersProvider.notifier);
      final updatedCategory = taskCategory.copyWith(name: _nameCtrl.text);

      if (taskCategory.id == null) {
        await taskFoldersStore.saveNewCategory(folderId, updatedCategory);
      } else {
        await taskFoldersStore.updateCategory(folderId, updatedCategory);
      }
    } finally {
      setState(() {
        _saving = false;
      });
    }
  }

  Future<void> deleteCategory(WidgetRef ref) async {
    setState(() {
      _deleting = true;
    });
    try {
      final taskFoldersStore = ref.read(taskFoldersProvider.notifier);
      await taskFoldersStore.deleteCategory(folderId, taskCategory);
    } finally {
      setState(() {
        _deleting = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final colors = getColors(context);

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        InkWell(
          onTap: () => _openPicker(ref),
          child: _colorUpdating
              ? SizedBox(
                  width: 20,
                  height: 20,
                  child: const CircularProgressIndicator(strokeWidth: 3),
                )
              : Row(
                  children: [
                    Container(
                      width: 10,
                      height: 20,
                      decoration: BoxDecoration(
                        color: colorFromHex(taskCategory.color),
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(2),
                          bottomLeft: Radius.circular(2),
                        ),
                      ),
                    ),
                    Container(
                      width: 10,
                      height: 20,
                      decoration: BoxDecoration(
                        color: colorFromHex(
                          taskCategory.color,
                        )?.withValues(alpha: 0.5),
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(2),
                          bottomRight: Radius.circular(2),
                        ),
                      ),
                    ),
                  ],
                ),
        ),

        const SizedBox(width: 15),

        Expanded(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(5),
                    topLeft: Radius.circular(5),
                  ),
                ),
                contentPadding: const EdgeInsets.only(left: 10, right: 10),
                title: Row(
                  children: [
                    Expanded(
                      child: isEditable
                          ? TextField(
                              controller: _nameCtrl,
                              readOnly: _deleting || _saving,
                              decoration: const InputDecoration(
                                isDense: true,
                                border: OutlineInputBorder(),
                              ),
                            )
                          : Text(taskCategory.name),
                    ),

                    const SizedBox(width: 20),

                    if (isEditable) ...[
                      IconButton(
                        icon: _saving
                            ? SizedBox(
                                width: 15,
                                height: 15,
                                child: const CircularProgressIndicator(
                                  strokeWidth: 3,
                                ),
                              )
                            : const Icon(Icons.check, color: Colors.green),
                        onPressed: _saving || _deleting
                            ? null
                            : () => saveCategory(ref),
                        padding: EdgeInsets.zero,
                        constraints: BoxConstraints(),
                        style: ButtonStyle(
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        ),
                      ),
                      IconButton(
                        icon: _deleting
                            ? SizedBox(
                                width: 15,
                                height: 15,
                                child: const CircularProgressIndicator(
                                  strokeWidth: 3,
                                ),
                              )
                            : Icon(Icons.delete, color: Colors.red),
                        onPressed: _saving || _deleting ? null : () => deleteCategory(ref),
                        padding: EdgeInsets.only(left: 10),
                        constraints: BoxConstraints(),
                        style: ButtonStyle(
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        ),
                      ),
                    ] else
                      Text(taskCategory.tasksCount.toString()),
                  ],
                ),
                onTap: () {},
              ),
              Divider(
                height: 1,
                thickness: 1,
                indent: 10,
                color: colors.onSecondary.withValues(alpha: 0.1),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
