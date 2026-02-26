import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:marquer/providers/tasks/task_filter.dart';

final taskFilterProvider =
    NotifierProvider<TaskFilterNotifier, TaskFilter>(TaskFilterNotifier.new);

class TaskFilterNotifier extends Notifier<TaskFilter> {
  @override
  TaskFilter build() => AllTasksFilter();

  void set(TaskFilter filter) {
    state = filter;
  }
}
