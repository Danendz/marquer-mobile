import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:marquer/api/models/calendar/plan_for_date.dart';
import 'package:marquer/api/services/calendar_service.dart';
import 'package:marquer/providers/calendar/calendar_selected_date_provider.dart';
import 'package:marquer/providers/optimistic_mutation.dart';
import 'package:marquer/utils/format.dart';

final dayPlansProvider = AsyncNotifierProvider<DayPlansNotifier, List<PlanForDate>>(
  DayPlansNotifier.new,
);

class DayPlansNotifier extends AsyncNotifier<List<PlanForDate>>
    with OptimisticMutation {
  final _service = CalendarService();

  @override
  Future<List<PlanForDate>> build() async {
    final selected = ref.watch(calendarSelectedDateProvider);
    return _service.getPlansForDate(formatDate(selected));
  }

  Future<void> toggleTask(int planId, int planTaskId) async {
    final current = currentValue;
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

    await mutate(
      action: () => _service.togglePlanTaskCompletion(planTaskId.toString(), date),
      errorMessage: 'Unable to update task! Try again later',
      rollback: () => [
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
      ],
      onSuccess: (latest, isCompleted) => [
        for (final plan in latest)
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
      ],
    );
  }
}
