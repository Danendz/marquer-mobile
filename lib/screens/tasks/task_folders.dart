import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:marquer/components/tasks/task_folder_item.dart';
import 'package:marquer/providers/tasks/task_folders_provider.dart';

class TaskFoldersPage extends ConsumerWidget {
  const TaskFoldersPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final foldersAsync = ref.watch(taskFoldersProvider);
    return foldersAsync.when(
      data: (folders) => Scaffold(
        body: Padding(
          padding: const EdgeInsetsGeometry.all(10),
          child: ListView(
            children: [
              Padding(
                padding: const EdgeInsetsGeometry.only(
                  left: 10,
                  right: 10,
                  bottom: 5,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text('Folders', style: TextStyle(fontSize: 18)),
                    TextButton(child: Text('Manage'), onPressed: () {},)
                  ],
                ),
              ),
              ...folders.map(
                (folder) => TaskFolderItem(
                  key: ValueKey(folder.id),
                  taskFolder: folder,
                ),
              ),
            ],
          ),
        ),
      ),
      error: (e, st) => Text('Error: $e'),
      loading: () => const Center(child: CircularProgressIndicator()),
    );
  }
}
