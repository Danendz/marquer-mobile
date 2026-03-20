import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:marquer/api/models/calendar/create_plan_request.dart';
import 'package:marquer/api/models/calendar/plan.dart';
import 'package:marquer/api/models/calendar/update_plan_request.dart';
import 'package:marquer/components/calendar/add_event_sheet.dart';
import 'package:marquer/components/shared/color_picker_row.dart';
import 'package:marquer/providers/calendar/plan_form_notifier.dart';
import 'package:marquer/providers/calendar/plans_provider.dart';
import 'package:marquer/screens/calendar/widgets/plan_date_range_section.dart';
import 'package:marquer/screens/calendar/widgets/plan_event_list.dart';
import 'package:marquer/screens/calendar/widgets/schedule_config.dart';
import 'package:marquer/utils/format.dart';

class PlanFormScreen extends ConsumerStatefulWidget {
  final Plan? plan;

  const PlanFormScreen({super.key, this.plan});

  @override
  ConsumerState<PlanFormScreen> createState() => _PlanFormScreenState();
}

class _PlanFormScreenState extends ConsumerState<PlanFormScreen> {
  late final TextEditingController _nameController;

  bool get _isEditing => widget.plan != null;

  @override
  void initState() {
    super.initState();
    final plan = widget.plan;
    _nameController = TextEditingController(text: plan?.name ?? '');

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (plan != null) {
        ref.read(planFormProvider.notifier).loadFromPlan(plan);
      } else {
        ref.invalidate(planFormProvider);
        // Set sensible defaults for a new plan
        final notifier = ref.read(planFormProvider.notifier);
        notifier.setWeeklyDays([DateTime.now().weekday - 1]);
        notifier.setMonthlyDates([DateTime.now().day]);
        notifier.setMonthlyWeekdayDay(DateTime.now().weekday - 1);
      }
    });

    _nameController.addListener(() {
      ref.read(planFormProvider.notifier).setName(_nameController.text);
    });
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  Future<void> _pickDate({required bool isStart}) async {
    final formState = ref.read(planFormProvider);
    final picked = await showDatePicker(
      context: context,
      initialDate: isStart
          ? formState.startDate
          : (formState.endDate ??
              formState.startDate.add(const Duration(days: 30))),
      firstDate: isStart ? DateTime(2020) : formState.startDate,
      lastDate: DateTime(2100),
    );
    if (picked == null) return;
    final notifier = ref.read(planFormProvider.notifier);
    if (isStart) {
      notifier.setStartDate(picked);
    } else {
      notifier.setEndDate(picked);
    }
  }

  Future<void> _save() async {
    final formState = ref.read(planFormProvider);
    if (formState.validate() != null) return;

    final validTasks = formState.validTasks;
    final schedule = formState.buildSchedule();
    final startDate = formatDate(formState.startDate);
    final endDate = formState.hasEndDate && formState.endDate != null
        ? formatDate(formState.endDate!)
        : null;

    bool success;
    if (_isEditing) {
      final request = UpdatePlanRequest(
        name: formState.name.trim(),
        schedule: schedule,
        startDate: startDate,
        endDate: endDate,
        color: formState.color,
        tasks: validTasks
            .asMap()
            .entries
            .map((e) => UpdatePlanTaskRequest(
                  id: e.value.id,
                  name: e.value.name.trim(),
                  sortOrder: e.key,
                  startTime: e.value.startTime,
                  endTime: e.value.endTime,
                ))
            .toList(),
      );
      success =
          await ref.read(plansProvider.notifier).edit(widget.plan!, request);
    } else {
      final request = CreatePlanRequest(
        name: formState.name.trim(),
        schedule: schedule,
        startDate: startDate,
        endDate: endDate,
        color: formState.color,
        tasks: validTasks
            .asMap()
            .entries
            .map((e) => CreatePlanTaskRequest(
                  name: e.value.name.trim(),
                  sortOrder: e.key,
                  startTime: e.value.startTime,
                  endTime: e.value.endTime,
                ))
            .toList(),
      );
      success = await ref.read(plansProvider.notifier).add(request);
    }

    if (!mounted) return;
    if (success) {
      Navigator.pop(context);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('Failed to save plan. Please try again.')),
      );
    }
  }

  void _addEvent() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => AddEventSheet(
        onSave: (name, startTime, endTime, date, color) {
          final formState = ref.read(planFormProvider);
          ref.read(planFormProvider.notifier).addTask(PlanTaskItem(
                name: name,
                sortOrder: formState.tasks.length,
                startTime: startTime,
                endTime: endTime,
              ));
        },
      ),
    );
  }

  void _editEvent(int index) {
    final formState = ref.read(planFormProvider);
    final task = formState.tasks[index];
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => AddEventSheet(
        initialName: task.name,
        initialStartTime: task.startTimeOfDay,
        initialEndTime: task.endTimeOfDay,
        onSave: (name, startTime, endTime, date, color) {
          ref.read(planFormProvider.notifier).updateTask(
                index,
                PlanTaskItem(
                  id: task.id,
                  name: name,
                  sortOrder: task.sortOrder,
                  startTime: startTime,
                  endTime: endTime,
                ),
              );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final formState = ref.watch(planFormProvider);
    final notifier = ref.read(planFormProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        title: Text(_isEditing ? 'Edit Plan' : 'New Plan'),
        actions: [
          TextButton(
            onPressed: _save,
            child: const Text('Save'),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Name
          TextField(
            controller: _nameController,
            autofocus: !_isEditing,
            decoration: const InputDecoration(
              labelText: 'Plan name',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 12),
          ColorPickerRow(
            selectedColor: formState.color,
            onColorChanged: (c) => notifier.setColor(c),
          ),
          const SizedBox(height: 20),

          // Schedule
          ScheduleConfigSection(
            type: formState.scheduleType,
            weeklyDays: formState.weeklyDays,
            intervalEvery: formState.intervalEvery,
            monthlyDates: formState.monthlyDates,
            monthlyWeekdayOccurrence: formState.monthlyWeekdayOccurrence,
            monthlyWeekdayDay: formState.monthlyWeekdayDay,
            onTypeChanged: (t) => notifier.setScheduleType(t),
            onWeeklyDaysChanged: (d) => notifier.setWeeklyDays(d),
            onIntervalChanged: (v) => notifier.setIntervalEvery(v),
            onMonthlyDatesChanged: (d) => notifier.setMonthlyDates(d),
            onMonthlyWeekdayOccurrenceChanged: (v) =>
                notifier.setMonthlyWeekdayOccurrence(v),
            onMonthlyWeekdayDayChanged: (v) =>
                notifier.setMonthlyWeekdayDay(v),
          ),
          const SizedBox(height: 20),

          // Dates
          PlanDateRangeSection(
            startDate: formState.startDate,
            hasEndDate: formState.hasEndDate,
            endDate: formState.endDate,
            onPickStart: () => _pickDate(isStart: true),
            onPickEnd: () => _pickDate(isStart: false),
            onEndDateToggle: (v) => notifier.setHasEndDate(v),
          ),
          const SizedBox(height: 20),

          // Events
          Row(
            children: [
              Expanded(
                  child: Text('Events',
                      style: Theme.of(context).textTheme.titleSmall)),
              TextButton.icon(
                onPressed: _addEvent,
                icon: const Icon(Icons.add, size: 18),
                label: const Text('Add'),
              ),
            ],
          ),
          const SizedBox(height: 8),
          PlanEventList(
            tasks: formState.tasks,
            onEdit: _editEvent,
            onDelete: (i) => notifier.removeTask(i),
          ),
          const SizedBox(height: 80),
        ],
      ),
    );
  }
}
