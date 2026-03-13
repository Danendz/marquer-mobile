import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:marquer/api/models/tasks/tasks/task_status.dart';
import 'package:marquer/components/tasks/task_filter_dropdown.dart';
import 'package:marquer/components/tasks/task_item_card.dart';
import 'package:marquer/providers/tasks/task_filter.dart';
import 'package:marquer/providers/tasks/task_filter_provider.dart';
import 'package:marquer/providers/tasks/task_folders_provider.dart';
import 'package:marquer/providers/tasks/tasks_provider.dart';
import 'package:marquer/screens/tasks/widgets/completed_tasks_section.dart';
import 'package:marquer/screens/tasks/widgets/task_add_input.dart';
import 'package:marquer/screens/tasks/widgets/tasks_empty_state.dart';
import 'package:marquer/utils/action_sheet.dart';

class TasksPage extends ConsumerStatefulWidget {
  const TasksPage({super.key});

  @override
  ConsumerState<TasksPage> createState() => _TasksPageState();
}

class _TasksPageState extends ConsumerState<TasksPage> {
  bool _isAdding = false;
  bool _completedExpanded = false;
  bool _suppressStopOnFocusLoss = false;
  final _addController = TextEditingController();
  final _addFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _addFocusNode.addListener(_onAddFocusChange);
  }

  void _onAddFocusChange() {
    if (!_addFocusNode.hasFocus && _isAdding) {
      if (_suppressStopOnFocusLoss) return;
      final name = _addController.text.trim();
      if (name.isNotEmpty) {
        final filter = ref.read(taskFilterProvider);
        int? categoryId;
        if (filter is CategoryFilter) categoryId = filter.categoryId;
        ref.read(tasksProvider.notifier).addTask(name, categoryId);
      }
      _stopAdding();
    }
  }

  @override
  void dispose() {
    _addFocusNode.removeListener(_onAddFocusChange);
    _addController.dispose();
    _addFocusNode.dispose();
    super.dispose();
  }

  String _filterTitle(TaskFilter filter) {
    return switch (filter) {
      AllTasksFilter() => 'All To-Do',
      CategoryFilter(:final categoryName) => categoryName,
      FolderFilter(:final folderName) => folderName,
      RecentlyDeletedFilter() => 'Recently Deleted',
    };
  }

  void _startAdding() {
    setState(() => _isAdding = true);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _addFocusNode.requestFocus();
    });
  }

  void _stopAdding() {
    setState(() {
      _isAdding = false;
      _addController.clear();
    });
  }

  Future<void> _submitTask() async {
    final name = _addController.text.trim();
    if (name.isEmpty) return;

    final filter = ref.read(taskFilterProvider);
    int? categoryId;

    if (filter is CategoryFilter) {
      categoryId = filter.categoryId;
    }

    _suppressStopOnFocusLoss = true;
    ref.read(tasksProvider.notifier).addTask(name, categoryId);
    _addController.clear();
    _addFocusNode.requestFocus();
    _suppressStopOnFocusLoss = false;
  }

  @override
  Widget build(BuildContext context) {
    final filter = ref.watch(taskFilterProvider);
    final tasksAsync = ref.watch(tasksProvider);
    ref.watch(taskFoldersProvider); // preload for category picker
    final isDeletedView = filter is RecentlyDeletedFilter;

    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: const Icon(Icons.arrow_back),
                  onPressed: () => context.go('/'),
                ),
                GestureDetector(
                  onTap: () => showTaskFilterDropdown(context),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        _filterTitle(filter),
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(width: 4),
                      const Icon(Icons.arrow_drop_down),
                    ],
                  ),
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (filter is! AllTasksFilter)
                      IconButton(
                        icon: const Icon(Icons.close),
                        tooltip: 'Reset filter',
                        onPressed: () => ref.read(taskFilterProvider.notifier).set(AllTasksFilter()),
                      ),
                    IconButton(
                      icon: const Icon(Icons.more_vert),
                      onPressed: () async {
                        final result = await showAppActionSheet(context, const [
                          AppAction(value: 'manage', icon: Icons.folder_outlined, label: 'Manage Folders'),
                        ]);
                        if (result == 'manage' && context.mounted) {
                          context.go('/tasks/manage-folders');
                        }
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            child: tasksAsync.when(
              data: (tasks) {
                final activeTasks = tasks
                    .where((t) => t.status != TaskStatus.done && t.status != TaskStatus.cancelled)
                    .toList();
                final completedTasks = tasks
                    .where((t) => t.status == TaskStatus.done)
                    .toList();

                final showCompleted = !isDeletedView && completedTasks.isNotEmpty;

                if (!_isAdding && activeTasks.isEmpty && completedTasks.isEmpty && !isDeletedView) {
                  return RefreshIndicator(
                    onRefresh: () => ref.refresh(tasksProvider.future),
                    child: ListView(
                      physics: const AlwaysScrollableScrollPhysics(),
                      children: const [
                        TasksEmptyState(
                          icon: Icons.check_circle_outline,
                          message: 'No tasks yet',
                        ),
                      ],
                    ),
                  );
                }

                if (isDeletedView && tasks.isEmpty) {
                  return RefreshIndicator(
                    onRefresh: () => ref.refresh(tasksProvider.future),
                    child: ListView(
                      physics: const AlwaysScrollableScrollPhysics(),
                      children: const [
                        TasksEmptyState(
                          icon: Icons.delete_outline,
                          message: 'No deleted tasks',
                        ),
                      ],
                    ),
                  );
                }

                return GestureDetector(
                  onTap: () {
                    if (_isAdding) _addFocusNode.unfocus();
                  },
                  behavior: HitTestBehavior.translucent,
                  child: RefreshIndicator(
                    onRefresh: () => ref.refresh(tasksProvider.future),
                    child: ListView(
                      physics: const AlwaysScrollableScrollPhysics(),
                      children: [
                        if (_isAdding)
                          TaskAddInput(
                            controller: _addController,
                            focusNode: _addFocusNode,
                            onSubmit: _submitTask,
                          ),
                        if (isDeletedView)
                          ...tasks.map((task) => TaskItemCard(
                                key: ValueKey(task.id),
                                task: task,
                              )),
                        if (!isDeletedView) ...[
                          ...activeTasks.map((task) => TaskItemCard(
                                key: ValueKey(task.id),
                                task: task,
                              )),
                          if (showCompleted)
                            CompletedTasksSection(
                              tasks: completedTasks,
                              expanded: _completedExpanded,
                              onToggle: () => setState(() => _completedExpanded = !_completedExpanded),
                            ),
                        ],
                      ],
                    ),
                  ),
                );
              },
              error: (e, _) => RefreshIndicator(
                onRefresh: () => ref.refresh(tasksProvider.future),
                child: ListView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  children: const [
                    SizedBox(
                      height: 400,
                      child: Center(child: Text('Failed to load tasks. Pull down to retry.')),
                    ),
                  ],
                ),
              ),
              loading: () => const Center(child: CircularProgressIndicator()),
            ),
          ),
        ],
      ),
      floatingActionButton: isDeletedView
          ? null
          : FloatingActionButton(
              onPressed: _startAdding,
              child: const Icon(Icons.add),
            ),
    );
  }
}
