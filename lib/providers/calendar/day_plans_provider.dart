import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:marquer/api/models/calendar/plan_for_date.dart';
import 'package:marquer/api/services/calendar_service.dart';
import 'package:marquer/providers/calendar/calendar_selected_date_provider.dart';
import 'package:marquer/utils/format.dart';
import 'package:marquer/services/toast_service.dart';

final dayPlansProvider = AsyncNotifierProvider<DayPlansNotifier, List<PlanForDate>>(
  DayPlansNotifier.new,
);

class DayPlansNotifier extends AsyncNotifier<List<PlanForDate>> {
  final _service = CalendarService();

  @override
  Future<List<PlanForDate>> build() async {
    final selected = ref.watch(calendarSelectedDateProvider);
    return _service.getPlansForDate(formatDate(selected));
  }

  Future<void> toggleTask(int planId, int planTaskId) async {
    final current = state.asData?.value;
    if (current == null) return;

    final date = formatDate(ref.read(calendarSelectedDateProvider));

    // Optimistic toggle
    state = AsyncData([
      for (final plan in current)
        if (plan.id == planId)
          plan.copyWith(
            tasks: [
              for (final task in plan.tasks)
                if (task.id == planTaskId)
                  task.copyWith(isCompleted: !task.isCompleted)
                else
                  task,
            ],
          )
        else
          plan,
    ]);

    try {
      final isCompleted = await _service.togglePlanTaskCompletion(planTaskId.toString(), date);
      if (!ref.mounted) return;
      state = AsyncData([
        for (final plan in state.asData!.value)
          if (plan.id == planId)
            plan.copyWith(
              tasks: [
                for (final task in plan.tasks)
                  if (task.id == planTaskId)
                    task.copyWith(isCompleted: isCompleted)
                  else
                    task,
              ],
            )
          else
            plan,
      ]);
    } catch (e) {
      if (!ref.mounted) return;
      // Rollback
      state = AsyncData([
        for (final plan in state.asData?.value ?? current)
          if (plan.id == planId)
            plan.copyWith(
              tasks: [
                for (final task in plan.tasks)
                  if (task.id == planTaskId)
                    task.copyWith(isCompleted: !task.isCompleted)
                  else
                    task,
              ],
            )
          else
            plan,
      ]);
      debugPrint(e.toString());
      ToastService.showError('Unable to update task! Try again later');
    }
  }
}
