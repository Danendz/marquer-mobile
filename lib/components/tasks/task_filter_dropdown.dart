import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:marquer/api/models/tasks/folders/task_folder.dart';
import 'package:marquer/components/tasks/filter_folder_tile.dart';
import 'package:marquer/providers/tasks/task_filter.dart';
import 'package:marquer/providers/tasks/task_filter_provider.dart';
import 'package:marquer/providers/tasks/task_folders_provider.dart';
import 'package:marquer/utils/colors.dart';

void showTaskFilterDropdown(BuildContext context) {
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
                      FilterFolderTile(
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
