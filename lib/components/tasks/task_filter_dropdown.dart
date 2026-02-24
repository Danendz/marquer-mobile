import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:marquer/api/models/tasks/folders/task_folder.dart';
import 'package:marquer/providers/tasks/task_filter.dart';
import 'package:marquer/providers/tasks/task_filter_provider.dart';
import 'package:marquer/providers/tasks/task_folders_provider.dart';
import 'package:marquer/utils/colors.dart';

void showTaskFilterDropdown(BuildContext context, WidgetRef ref) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    builder: (context) => DraggableScrollableSheet(
      initialChildSize: 0.6,
      maxChildSize: 0.9,
      minChildSize: 0.3,
      expand: false,
      builder: (context, scrollController) => _TaskFilterSheet(
        scrollController: scrollController,
      ),
    ),
  );
}

class _TaskFilterSheet extends ConsumerWidget {
  final ScrollController scrollController;

  const _TaskFilterSheet({required this.scrollController});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = getColors(context);
    final foldersAsync = ref.watch(taskFoldersProvider);
    final currentFilter = ref.watch(taskFilterProvider);

    return SingleChildScrollView(
      controller: scrollController,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 40,
                height: 4,
                margin: const EdgeInsets.only(bottom: 16),
                decoration: BoxDecoration(
                  color: colors.onSurface.withValues(alpha: 0.3),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            Card(
              color: colors.surfaceContainer,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                children: [
                  ListTile(
                    leading: const Icon(Icons.checklist),
                    title: const Text('All To-Do'),
                    selected: currentFilter is AllTasksFilter,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    onTap: () {
                      ref.read(taskFilterProvider.notifier).set(AllTasksFilter());
                      Navigator.pop(context);
                    },
                  ),
                  const Divider(height: 1, indent: 16, endIndent: 16),
                  ListTile(
                    leading: const Icon(Icons.delete_outline),
                    title: const Text('Recently Deleted'),
                    selected: currentFilter is RecentlyDeletedFilter,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    onTap: () {
                      ref.read(taskFilterProvider.notifier).set(RecentlyDeletedFilter());
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Folders', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                      context.go('/tasks/manage-folders');
                    },
                    child: const Text('Manage'),
                  ),
                ],
              ),
            ),
            foldersAsync.when(
              data: (folders) {
                // When a category filter is active, put its parent folder first and expand it
                List<TaskFolder> sortedFolders = folders;
                int? priorityFolderId;
                if (currentFilter is CategoryFilter) {
                  final categoryId = currentFilter.categoryId;
                  final idx = folders.indexWhere(
                    (f) => f.categories.any((c) => c.id == categoryId),
                  );
                  if (idx > 0) {
                    sortedFolders = [
                      folders[idx],
                      ...folders.sublist(0, idx),
                      ...folders.sublist(idx + 1),
                    ];
                  }
                  if (idx >= 0) priorityFolderId = folders[idx].id;
                }
                return Column(
                  children: [
                    for (int i = 0; i < sortedFolders.length; i++) ...[
                      if (i > 0) const SizedBox(height: 8),
                      _FilterFolderTile(
                        folder: sortedFolders[i],
                        initiallyExpanded: sortedFolders[i].id == priorityFolderId,
                      ),
                    ],
                  ],
                );
              },
              error: (e, _) => const Text('Failed to load folders.'),
              loading: () => const Center(child: CircularProgressIndicator()),
            ),
          ],
        ),
      ),
    );
  }
}

class _FilterFolderTile extends ConsumerStatefulWidget {
  final TaskFolder folder;
  final bool initiallyExpanded;

  const _FilterFolderTile({required this.folder, this.initiallyExpanded = false});

  @override
  ConsumerState<_FilterFolderTile> createState() => _FilterFolderTileState();
}

class _FilterFolderTileState extends ConsumerState<_FilterFolderTile> {
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
