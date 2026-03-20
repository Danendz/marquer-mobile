import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:marquer/api/models/calendar/create_plan_request.dart';
import 'package:marquer/api/models/calendar/plan.dart';
import 'package:marquer/api/models/calendar/update_plan_request.dart';
import 'package:marquer/api/services/calendar_service.dart';
import 'package:marquer/providers/calendar/calendar_overview_provider.dart';
import 'package:marquer/providers/calendar/day_plans_provider.dart';
import 'package:marquer/providers/optimistic_mutation.dart';

final plansProvider = AsyncNotifierProvider<PlansNotifier, List<Plan>>(
  PlansNotifier.new,
);

class PlansNotifier extends AsyncNotifier<List<Plan>>
    with OptimisticMutation {
  final _service = CalendarService();

  @override
  Future<List<Plan>> build() async {
    return _service.getPlans();
  }

  void _invalidateCalendar() {
    ref.invalidate(calendarOverviewProvider);
    ref.invalidate(dayPlansProvider);
  }

  Future<bool> add(CreatePlanRequest request) async {
    final current = currentValue;
    if (current == null) return false;

    final result = await mutate(
      action: () => _service.createPlan(request),
      errorMessage: 'Unable to create plan! Try again later',
      onSuccess: (latest, created) {
        _invalidateCalendar();
        return [...latest, created];
      },
    );
    return result != null;
  }

  Future<bool> edit(Plan plan, UpdatePlanRequest request) async {
    final current = currentValue;
    if (current == null) return false;

    final result = await mutate(
      action: () => _service.updatePlan(plan.id.toString(), request),
      errorMessage: 'Unable to update plan! Try again later',
      onSuccess: (latest, updated) {
        _invalidateCalendar();
        return [for (final p in latest) if (p.id == plan.id) updated else p];
      },
    );
    return result != null;
  }

  Future<void> delete(Plan plan) async {
    final current = currentValue;
    if (current == null) return;

    state = AsyncData([for (final p in current) if (p.id != plan.id) p]);

    await mutate(
      action: () => _service.deletePlan(plan.id.toString()),
      errorMessage: 'Unable to delete plan! Try again later',
      rollback: () {
        final latest = state.asData?.value ?? current;
        if (latest.any((p) => p.id == plan.id)) return latest;
        final originalIdx = current.indexWhere((p) => p.id == plan.id);
        if (originalIdx < 0) return [plan, ...latest];
        final copy = [...latest];
        copy.insert(originalIdx.clamp(0, copy.length), plan);
        return copy;
      },
      onSuccess: (latest, _) {
        _invalidateCalendar();
        return latest;
      },
    );
  }

  Future<void> toggleActive(Plan plan) async {
    final current = currentValue;
    if (current == null) return;

    final optimistic = plan.copyWith(isActive: !plan.isActive);
    state = AsyncData([
      for (final p in current) if (p.id == plan.id) optimistic else p,
    ]);

    await mutate(
      action: () {
        final request = UpdatePlanRequest(
          name: plan.name,
          schedule: plan.schedule,
          startDate: plan.startDate,
          endDate: plan.endDate,
          isActive: !plan.isActive,
          tasks: plan.tasks.map((t) => UpdatePlanTaskRequest(id: t.id, name: t.name, sortOrder: t.sortOrder, startTime: t.startTime, endTime: t.endTime)).toList(),
        );
        return _service.updatePlan(plan.id.toString(), request);
      },
      errorMessage: 'Unable to update plan! Try again later',
      rollback: () => [
        for (final p in state.asData?.value ?? current) if (p.id == plan.id) plan else p,
      ],
      onSuccess: (latest, updated) {
        _invalidateCalendar();
        return [for (final p in latest) if (p.id == plan.id) updated else p];
      },
    );
  }
}
