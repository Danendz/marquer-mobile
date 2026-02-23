import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
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
              data: (folders) => Column(
                children: folders.map((folder) {
                  return Card(
                    color: colors.surfaceContainer,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: ExpansionTile(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      collapsedShape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      leading: const Icon(Icons.folder),
                      title: Text(folder.name),
                      children: folder.categories.map((category) {
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
                          onTap: () {
                            ref.read(taskFilterProvider.notifier).set(CategoryFilter(
                              categoryId: category.id!,
                              categoryName: category.name,
                              categoryColor: category.color,
                            ));
                            Navigator.pop(context);
                          },
                        );
                      }).toList(),
                    ),
                  );
                }).toList(),
              ),
              error: (e, _) => Text('Error loading folders: $e'),
              loading: () => const Center(child: CircularProgressIndicator()),
            ),
          ],
        ),
      ),
    );
  }
}
