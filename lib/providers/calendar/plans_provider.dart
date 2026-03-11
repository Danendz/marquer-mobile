import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:marquer/api/models/calendar/create_plan_request.dart';
import 'package:marquer/api/models/calendar/plan.dart';
import 'package:marquer/api/models/calendar/update_plan_request.dart';
import 'package:marquer/api/services/calendar_service.dart';
import 'package:marquer/providers/calendar/calendar_overview_provider.dart';
import 'package:marquer/providers/calendar/day_plans_provider.dart';
import 'package:marquer/services/toast_service.dart';

final plansProvider = AsyncNotifierProvider<PlansNotifier, List<Plan>>(
  PlansNotifier.new,
);

class PlansNotifier extends AsyncNotifier<List<Plan>> {
  final _service = CalendarService();

  @override
  Future<List<Plan>> build() async {
    return _service.getPlans();
  }

  Future<bool> add(CreatePlanRequest request) async {
    final current = state.asData?.value;
    if (current == null) return false;

    try {
      final created = await _service.createPlan(request);
      if (!ref.mounted) return false;
      state = AsyncData([...current, created]);
      ref.invalidate(calendarOverviewProvider);
      ref.invalidate(dayPlansProvider);
      return true;
    } catch (e) {
      if (!ref.mounted) return false;
      debugPrint(e.toString());
      ToastService.showError('Unable to create plan! Try again later');
      return false;
    }
  }

  Future<bool> edit(Plan plan, UpdatePlanRequest request) async {
    final current = state.asData?.value;
    if (current == null) return false;

    try {
      final updated = await _service.updatePlan(plan.id.toString(), request);
      if (!ref.mounted) return false;
      state = AsyncData([
        for (final p in state.asData!.value) if (p.id == plan.id) updated else p,
      ]);
      ref.invalidate(calendarOverviewProvider);
      ref.invalidate(dayPlansProvider);
      return true;
    } catch (e) {
      if (!ref.mounted) return false;
      debugPrint(e.toString());
      ToastService.showError('Unable to update plan! Try again later');
      return false;
    }
  }

  Future<void> delete(Plan plan) async {
    final current = state.asData?.value;
    if (current == null) return;

    state = AsyncData([for (final p in current) if (p.id != plan.id) p]);

    try {
      await _service.deletePlan(plan.id.toString());
    } catch (e) {
      if (!ref.mounted) return;
      final latest = state.asData?.value ?? current;
      state = AsyncData(latest.any((p) => p.id == plan.id) ? latest : [plan, ...latest]);
      debugPrint(e.toString());
      ToastService.showError('Unable to delete plan! Try again later');
    }
  }

  Future<void> toggleActive(Plan plan) async {
    final current = state.asData?.value;
    if (current == null) return;

    final optimistic = plan.copyWith(isActive: !plan.isActive);
    state = AsyncData([
      for (final p in current) if (p.id == plan.id) optimistic else p,
    ]);

    try {
      final request = UpdatePlanRequest(
        name: plan.name,
        schedule: plan.schedule,
        startDate: plan.startDate,
        endDate: plan.endDate,
        isActive: !plan.isActive,
        tasks: plan.tasks.map((t) => UpdatePlanTaskRequest(id: t.id, name: t.name, sortOrder: t.sortOrder)).toList(),
      );
      final updated = await _service.updatePlan(plan.id.toString(), request);
      if (!ref.mounted) return;
      state = AsyncData([
        for (final p in state.asData!.value) if (p.id == plan.id) updated else p,
      ]);
    } catch (e) {
      if (!ref.mounted) return;
      state = AsyncData([
        for (final p in state.asData?.value ?? current) if (p.id == plan.id) plan else p,
      ]);
      debugPrint(e.toString());
      ToastService.showError('Unable to update plan! Try again later');
    }
  }
}
