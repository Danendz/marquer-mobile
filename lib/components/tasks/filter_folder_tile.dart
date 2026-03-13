import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:marquer/api/models/tasks/folders/task_folder.dart';
import 'package:marquer/providers/tasks/task_filter.dart';
import 'package:marquer/providers/tasks/task_filter_provider.dart';
import 'package:marquer/utils/colors.dart';

class FilterFolderTile extends ConsumerStatefulWidget {
  final TaskFolder folder;
  final bool initiallyExpanded;

  const FilterFolderTile({super.key, required this.folder, this.initiallyExpanded = false});

  @override
  ConsumerState<FilterFolderTile> createState() => _FilterFolderTileState();
}

class _FilterFolderTileState extends ConsumerState<FilterFolderTile> {
  late bool _isExpanded;

  @override
  void initState() {
    super.initState();
    _isExpanded = widget.initiallyExpanded;
  }

  TaskFolder get folder => widget.folder;

  @override
  Widget build(BuildContext context) {
    final colors = getColors(context);
    final currentFilter = ref.watch(taskFilterProvider);

    return Material(
      color: colors.surfaceContainer,
      borderRadius: BorderRadius.circular(20),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InkWell(
            onTap: () => setState(() => _isExpanded = !_isExpanded),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Row(
                children: [
                  const Icon(Icons.folder_outlined),
                  const SizedBox(width: 12),
                  Expanded(child: Text(folder.name)),
                  GestureDetector(
                    onTap: () {
                      ref.read(taskFilterProvider.notifier).set(
                        FolderFilter(folderId: folder.id, folderName: folder.name),
                      );
                      Navigator.pop(context);
                      context.go('/tasks');
                    },
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
                        if (folder.categories.isEmpty)
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
                        ...folder.categories.map((category) {
                          final isSelected = currentFilter is CategoryFilter &&
                              currentFilter.categoryId == category.id;
                          return ListTile(
                            leading: Container(
                              width: 12,
                              height: 12,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: colorFromHex(category.color) ?? Colors.white,
                              ),
                            ),
                            title: Text(category.name),
                            trailing: Text(
                              '${category.tasksCount}',
                              style: TextStyle(color: colors.onSurface.withValues(alpha: 0.5)),
                            ),
                            selected: isSelected,
                            onTap: category.id == null
                                ? null
                                : () {
                                    ref.read(taskFilterProvider.notifier).set(CategoryFilter(
                                      categoryId: category.id!,
                                      categoryName: category.name,
                                      categoryColor: category.color,
                                    ));
                                    Navigator.pop(context);
                                  },
                          );
                        }),
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
