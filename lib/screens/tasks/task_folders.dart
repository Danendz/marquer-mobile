import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:marquer/components/tasks/task_folder_item.dart';
import 'package:marquer/providers/tasks/task_folders_provider.dart';
import 'package:marquer/utils/action_sheet.dart';

class TaskFoldersPage extends ConsumerWidget {
  const TaskFoldersPage({super.key});

  void _showCreateFolderDialog(BuildContext context, WidgetRef ref) {
    final controller = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('New Folder'),
        content: TextField(
          controller: controller,
          autofocus: true,
          decoration: const InputDecoration(hintText: 'Folder name'),
          onSubmitted: (value) {
            if (value.trim().isNotEmpty) {
              ref.read(taskFoldersProvider.notifier).createFolder(value.trim());
              Navigator.pop(context);
            }
          },
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              final value = controller.text.trim();
              if (value.isNotEmpty) {
                ref.read(taskFoldersProvider.notifier).createFolder(value);
                Navigator.pop(context);
              }
            },
            child: const Text('Create'),
          ),
        ],
      ),
    );
  }

  void _showFolderOptions(BuildContext context, WidgetRef ref, dynamic folder) async {
    await HapticFeedback.mediumImpact();
    if (!context.mounted) return;

    final result = await showAppActionSheet(context, const [
      AppAction(value: 'rename', icon: Icons.edit_outlined, label: 'Rename'),
      AppAction(value: 'delete', icon: Icons.delete_outline, label: 'Delete', isDestructive: true),
    ]);

    if (!context.mounted || result == null) return;

    if (result == 'rename') {
      _showRenameFolderDialog(context, ref, folder);
    } else if (result == 'delete') {
      ref.read(taskFoldersProvider.notifier).deleteFolder(folder.id);
    }
  }

  void _showRenameFolderDialog(BuildContext context, WidgetRef ref, dynamic folder) {
    final controller = TextEditingController(text: folder.name);

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Rename Folder'),
        content: TextField(
          controller: controller,
          autofocus: true,
          decoration: const InputDecoration(hintText: 'Folder name'),
          onSubmitted: (value) {
            if (value.trim().isNotEmpty) {
              ref.read(taskFoldersProvider.notifier).updateFolder(folder.id, value.trim());
              Navigator.pop(context);
            }
          },
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              final value = controller.text.trim();
              if (value.isNotEmpty) {
                ref.read(taskFoldersProvider.notifier).updateFolder(folder.id, value);
                Navigator.pop(context);
              }
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final foldersAsync = ref.watch(taskFoldersProvider);
    return foldersAsync.when(
      data: (folders) => Scaffold(
        appBar: AppBar(
          title: const Text('Manage Folders'),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          child: RefreshIndicator(
            onRefresh: () => ref.refresh(taskFoldersProvider.future),
            child: ListView.separated(
              physics: const AlwaysScrollableScrollPhysics(),
              itemCount: folders.length,
              separatorBuilder: (context, index) => const SizedBox(height: 8),
              itemBuilder: (context, index) {
                final folder = folders[index];
                return TaskFolderItem(
                  key: ValueKey(folder.id),
                  taskFolder: folder,
                  onLongPress: () => _showFolderOptions(context, ref, folder),
                );
              },
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => _showCreateFolderDialog(context, ref),
          child: const Icon(Icons.create_new_folder),
        ),
      ),
      error: (e, st) => Scaffold(
        appBar: AppBar(title: const Text('Manage Folders')),
        body: Center(child: Text('Error: $e')),
      ),
      loading: () => Scaffold(
        appBar: AppBar(title: const Text('Manage Folders')),
        body: const Center(child: CircularProgressIndicator()),
      ),
    );
  }
}
