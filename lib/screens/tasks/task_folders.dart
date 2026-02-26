import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:marquer/components/tasks/task_folder_item.dart';
import 'package:marquer/providers/tasks/task_folders_provider.dart';
import 'package:marquer/utils/colors.dart';

class TaskFoldersPage extends ConsumerStatefulWidget {
  const TaskFoldersPage({super.key});

  @override
  ConsumerState<TaskFoldersPage> createState() => _TaskFoldersPageState();
}

class _TaskFoldersPageState extends ConsumerState<TaskFoldersPage> {
  bool _isAdding = false;
  final TextEditingController _addController = TextEditingController();
  final FocusNode _addFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _addFocusNode.addListener(_onAddFocusChange);
  }

  @override
  void dispose() {
    _addFocusNode.removeListener(_onAddFocusChange);
    _addFocusNode.dispose();
    _addController.dispose();
    super.dispose();
  }

  void _onAddFocusChange() {
    if (!_addFocusNode.hasFocus && _isAdding) {
      final name = _addController.text.trim();
      if (name.isNotEmpty) {
        ref.read(taskFoldersProvider.notifier).createFolder(name);
      }
      _stopAdding();
    }
  }

  void _startAdding() {
    setState(() {
      _isAdding = true;
      _addController.clear();
    });
    WidgetsBinding.instance.addPostFrameCallback((_) => _addFocusNode.requestFocus());
  }

  void _stopAdding() {
    setState(() => _isAdding = false);
    _addController.clear();
  }

  Future<void> _submitCreate() async {
    final name = _addController.text.trim();
    if (name.isEmpty) return;
    _addController.clear();
    await ref.read(taskFoldersProvider.notifier).createFolder(name);
    if (mounted) _addFocusNode.requestFocus();
  }

  @override
  Widget build(BuildContext context) {
    final colors = getColors(context);
    final foldersAsync = ref.watch(taskFoldersProvider);
    return foldersAsync.when(
      data: (folders) => Scaffold(
        appBar: AppBar(
          title: const Text('Manage Folders'),
          leading: BackButton(onPressed: () => context.go('/tasks')),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          child: RefreshIndicator(
            onRefresh: () => ref.refresh(taskFoldersProvider.future),
            child: ListView(
              physics: const AlwaysScrollableScrollPhysics(),
              children: [
                for (int i = 0; i < folders.length; i++) ...[
                  if (i > 0) const SizedBox(height: 8),
                  TaskFolderItem(
                    key: ValueKey(folders[i].id),
                    taskFolder: folders[i],
                  ),
                ],
                if (_isAdding) ...[
                  if (folders.isNotEmpty) const SizedBox(height: 8),
                  Container(
                    decoration: BoxDecoration(
                      color: colors.surfaceContainer,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      child: Row(
                        children: [
                          const Icon(Icons.folder_outlined),
                          const SizedBox(width: 12),
                          Expanded(
                            child: TextField(
                              controller: _addController,
                              focusNode: _addFocusNode,
                              onTapOutside: (_) => _addFocusNode.unfocus(),
                              decoration: const InputDecoration(
                                hintText: 'Folder name...',
                                border: InputBorder.none,
                                isDense: true,
                                contentPadding: EdgeInsets.zero,
                              ),
                              style: const TextStyle(fontSize: 14),
                              onSubmitted: (_) => _submitCreate(),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: _startAdding,
          child: const Icon(Icons.create_new_folder),
        ),
      ),
      error: (e, st) => Scaffold(
        appBar: AppBar(
          title: const Text('Manage Folders'),
          leading: BackButton(onPressed: () => context.go('/tasks')),
        ),
        body: const Center(child: Text('Failed to load folders.')),
      ),
      loading: () => Scaffold(
        appBar: AppBar(
          title: const Text('Manage Folders'),
          leading: BackButton(onPressed: () => context.go('/tasks')),
        ),
        body: const Center(child: CircularProgressIndicator()),
      ),
    );
  }
}
