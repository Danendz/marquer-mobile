import 'package:flutter/material.dart';
import 'package:marquer/api/models/tasks/folders/task_folder.dart';
import 'package:marquer/api/services/tasks_service.dart';
import 'package:marquer/components/tasks/task_folder_item.dart';

class TaskFoldersPage extends StatefulWidget {
  const TaskFoldersPage({super.key});

  @override
  State<TaskFoldersPage> createState() => _TaskFoldersPageState();
}

class _TaskFoldersPageState extends State<TaskFoldersPage> {
  List<TaskFolder> _taskFolders = [];
  bool _isLoading = true;
  final TasksService _tasksService = TasksService();

  @override
  void initState() {
    super.initState();
    _fetchTaskFolders();
  }

  void _fetchTaskFolders() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final data = await _tasksService.getFolders();

      setState(() {
        _taskFolders = data;
      });
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }
    return Scaffold(
      body: Padding(
        padding: const EdgeInsetsGeometry.all(10),
        child: ListView(
          children: _taskFolders
              .map(
                (folder) => TaskFolderItem(
                  key: ValueKey(folder.id),
                  taskFolder: folder,
                ),
              )
              .toList(),
        ),
      ),
    );
  }
}
