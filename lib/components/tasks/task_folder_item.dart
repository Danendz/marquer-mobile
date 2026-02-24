import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:marquer/api/models/tasks/categories/task_category.dart';
import 'package:marquer/api/models/tasks/folders/task_folder.dart';
import 'package:marquer/components/tasks/task_category_item.dart';
import 'package:marquer/providers/tasks/task_filter.dart';
import 'package:marquer/providers/tasks/task_filter_provider.dart';
import 'package:marquer/providers/tasks/task_folders_provider.dart';
import 'package:marquer/utils/action_sheet.dart';
import 'package:marquer/utils/colors.dart';
import 'package:uuid/uuid.dart';

class TaskFolderItem extends ConsumerStatefulWidget {
  final TaskFolder taskFolder;

  const TaskFolderItem({super.key, required this.taskFolder});

  @override
  ConsumerState<TaskFolderItem> createState() => _TaskFolderItemState();
}

class _TaskFolderItemState extends ConsumerState<TaskFolderItem> {
  bool _isExpanded = false;
  bool _isRenaming = false;
  bool _isBusy = false;

  late final TextEditingController _nameCtrl;
  late final FocusNode _focusNode;

  TaskFolder get taskFolder => widget.taskFolder;

  @override
  void initState() {
    super.initState();
    _nameCtrl = TextEditingController(text: taskFolder.name);
    _focusNode = FocusNode();
    _focusNode.addListener(_onFocusChange);
  }

  @override
  void dispose() {
    _focusNode.removeListener(_onFocusChange);
    _focusNode.dispose();
    _nameCtrl.dispose();
    super.dispose();
  }

  void _onFocusChange() {
    if (!_focusNode.hasFocus && _isRenaming && !_isBusy) {
      final name = _nameCtrl.text.trim();
      if (name.isNotEmpty) {
        _submitRename();
      } else {
        setState(() {
          _isRenaming = false;
          _nameCtrl.text = taskFolder.name;
        });
      }
    }
  }

  Future<void> _submitRename() async {
    final name = _nameCtrl.text.trim();
    if (name.isEmpty || _isBusy) return;
    setState(() => _isBusy = true);
    try {
      await ref.read(taskFoldersProvider.notifier).updateFolder(taskFolder.id, name);
      if (mounted) setState(() => _isRenaming = false);
    } finally {
      if (mounted) setState(() => _isBusy = false);
    }
  }

  Future<void> _onLongPress() async {
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
        _nameCtrl.text = taskFolder.name;
      });
      WidgetsBinding.instance.addPostFrameCallback((_) => _focusNode.requestFocus());
    } else if (result == 'delete') {
      await ref.read(taskFoldersProvider.notifier).deleteFolder(taskFolder.id);
    }
  }

  void _addNewCategory() {
    ref.read(taskFoldersProvider.notifier).addCategory(
      taskFolder.id,
      TaskCategory(
        id: null,
        name: '',
        color: '#fff',
        tasksCount: 0,
        tempNewUUID: Uuid().v4(),
      ),
    );
  }

  void _navigateToFolder() {
    ref.read(taskFilterProvider.notifier).set(
      FolderFilter(folderId: taskFolder.id, folderName: taskFolder.name),
    );
    context.go('/tasks');
  }

  @override
  Widget build(BuildContext context) {
    final colors = getColors(context);

    return Material(
      color: colors.surfaceContainer,
      borderRadius: BorderRadius.circular(20),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InkWell(
            onTap: _isRenaming ? null : () => setState(() => _isExpanded = !_isExpanded),
            onLongPress: _isRenaming ? null : _onLongPress,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Row(
                children: [
                  const Icon(Icons.folder_outlined),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _isRenaming
                        ? TextField(
                            controller: _nameCtrl,
                            focusNode: _focusNode,
                            readOnly: _isBusy,
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              isDense: true,
                              contentPadding: EdgeInsets.zero,
                            ),
                            style: const TextStyle(fontSize: 14),
                            onSubmitted: (_) {
                              if (!_isBusy) _submitRename();
                            },
                            onTapOutside: (_) => _focusNode.unfocus(),
                          )
                        : Text(taskFolder.name),
                  ),
                  GestureDetector(
                    onTap: _navigateToFolder,
                    behavior: HitTestBehavior.opaque,
                    child: const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      child: Icon(Icons.arrow_forward_ios, size: 14),
                    ),
                  ),
                  const SizedBox(width: 4),
                  AnimatedRotation(
                    turns: _isExpanded ? 0.5 : 0.0,
                    duration: const Duration(milliseconds: 200),
                    curve: Curves.easeInOut,
                    child: const Icon(Icons.keyboard_arrow_down),
                  ),
                ],
              ),
            ),
          ),
          AnimatedSize(
            duration: const Duration(milliseconds: 200),
            curve: Curves.easeInOut,
            alignment: Alignment.topCenter,
            child: _isExpanded
                ? Padding(
                    padding: const EdgeInsets.only(left: 52, right: 16, bottom: 8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Divider(height: 1, thickness: 1),
                        if (taskFolder.categories.isEmpty)
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            child: Text(
                              'No categories',
                              style: TextStyle(
                                fontSize: 13,
                                color: colors.onSurface.withValues(alpha: 0.4),
                              ),
                            ),
                          ),
                        ...taskFolder.categories.map((category) {
                          if (category.id == null) {
                            return TaskCategoryItem(
                              key: ValueKey(category.tempNewUUID),
                              taskCategory: category,
                              folderId: taskFolder.id,
                              isEditable: true,
                            );
                          }
                          return TaskCategoryItem(
                            key: ValueKey(category.id),
                            taskCategory: category,
                            folderId: taskFolder.id,
                            isEditable: false,
                            onTap: () {
                              ref.read(taskFilterProvider.notifier).set(CategoryFilter(
                                categoryId: category.id!,
                                categoryName: category.name,
                                categoryColor: category.color,
                              ));
                              context.go('/tasks');
                            },
                          );
                        }),
                        TextButton.icon(
                          icon: const Icon(Icons.add, size: 16),
                          label: const Text('New Category'),
                          onPressed: _addNewCategory,
                        ),
                      ],
                    ),
                  )
                : const SizedBox.shrink(),
          ),
        ],
      ),
    );
  }
}
