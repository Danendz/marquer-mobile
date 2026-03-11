import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:marquer/api/models/calendar/create_plan_request.dart';
import 'package:marquer/api/models/calendar/plan.dart';
import 'package:marquer/api/models/calendar/plan_schedule.dart';
import 'package:marquer/api/models/calendar/update_plan_request.dart';
import 'package:marquer/components/calendar/add_event_sheet.dart';
import 'package:marquer/components/shared/color_picker_row.dart';
import 'package:marquer/providers/calendar/plans_provider.dart';
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
  late ScheduleType _scheduleType;
  late List<int> _weeklyDays;
  late int _intervalEvery;
  late List<int> _monthlyDates;
  late int _monthlyWeekdayOccurrence;
  late int _monthlyWeekdayDay;
  late DateTime _startDate;
  DateTime? _endDate;
  bool _hasEndDate = false;
  late List<PlanTaskItem> _tasks;
  String? _color;

  bool get _isEditing => widget.plan != null;

  @override
  void initState() {
    super.initState();
    final plan = widget.plan;

    _nameController = TextEditingController(text: plan?.name ?? '');
    _startDate = plan != null ? DateTime.parse(plan.startDate) : DateTime.now();
    _endDate = plan?.endDate != null ? DateTime.parse(plan!.endDate!) : null;
    _hasEndDate = _endDate != null;
    _color = plan?.color;

    if (plan != null) {
      _tasks = plan.tasks
          .map((t) => PlanTaskItem(id: t.id, name: t.name, sortOrder: t.sortOrder, startTime: t.startTime, endTime: t.endTime))
          .toList();
      _initScheduleFromPlan(plan.schedule);
    } else {
      _scheduleType = ScheduleType.daily;
      _weeklyDays = [DateTime.now().weekday - 1]; // 0-indexed Mon
      _intervalEvery = 1;
      _monthlyDates = [DateTime.now().day];
      _monthlyWeekdayOccurrence = 1;
      _monthlyWeekdayDay = DateTime.now().weekday - 1;
      _tasks = [];
    }
  }

  void _initScheduleFromPlan(PlanSchedule schedule) {
    switch (schedule) {
      case DailySchedule():
        _scheduleType = ScheduleType.daily;
        _weeklyDays = [0];
        _intervalEvery = 1;
        _monthlyDates = [1];
        _monthlyWeekdayOccurrence = 1;
        _monthlyWeekdayDay = 0;
        break;
      case WeeklySchedule(:final days):
        _scheduleType = ScheduleType.weekly;
        _weeklyDays = List.from(days);
        _intervalEvery = 1;
        _monthlyDates = [1];
        _monthlyWeekdayOccurrence = 1;
        _monthlyWeekdayDay = 0;
        break;
      case IntervalSchedule(:final every):
        _scheduleType = ScheduleType.interval;
        _weeklyDays = [0];
        _intervalEvery = every;
        _monthlyDates = [1];
        _monthlyWeekdayOccurrence = 1;
        _monthlyWeekdayDay = 0;
        break;
      case MonthlyDatesSchedule(:final days):
        _scheduleType = ScheduleType.monthlyDates;
        _weeklyDays = [0];
        _intervalEvery = 1;
        _monthlyDates = List.from(days);
        _monthlyWeekdayOccurrence = 1;
        _monthlyWeekdayDay = 0;
        break;
      case MonthlyWeekdaySchedule(:final week, :final weekday):
        _scheduleType = ScheduleType.monthlyWeekday;
        _weeklyDays = [0];
        _intervalEvery = 1;
        _monthlyDates = [1];
        _monthlyWeekdayOccurrence = week;
        _monthlyWeekdayDay = weekday;
        break;
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  PlanSchedule _buildSchedule() {
    return switch (_scheduleType) {
      ScheduleType.daily => const DailySchedule(),
      ScheduleType.weekly => WeeklySchedule(days: List.from(_weeklyDays)),
      ScheduleType.interval => IntervalSchedule(every: _intervalEvery),
      ScheduleType.monthlyDates => MonthlyDatesSchedule(days: List.from(_monthlyDates)),
      ScheduleType.monthlyWeekday => MonthlyWeekdaySchedule(
        week: _monthlyWeekdayOccurrence,
        weekday: _monthlyWeekdayDay,
      ),
    };
  }

  Future<void> _pickDate({required bool isStart}) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: isStart ? _startDate : (_endDate ?? _startDate.add(const Duration(days: 30))),
      firstDate: isStart ? DateTime(2020) : _startDate,
      lastDate: DateTime(2100),
    );
    if (picked == null) return;
    setState(() {
      if (isStart) {
        _startDate = picked;
        if (_endDate != null && _endDate!.isBefore(_startDate)) {
          _endDate = null;
          _hasEndDate = false;
        }
      } else {
        _endDate = picked;
      }
    });
  }

  Future<void> _save() async {
    final name = _nameController.text.trim();
    if (name.isEmpty) return;

    final validTasks = _tasks.where((t) => t.name.trim().isNotEmpty).toList();
    if (validTasks.isEmpty) return;

    // Sort by time: no startTime first, then ascending
    validTasks.sort((a, b) {
      if (a.startTime == null && b.startTime == null) return 0;
      if (a.startTime == null) return -1;
      if (b.startTime == null) return 1;
      return a.startTime!.compareTo(b.startTime!);
    });

    final schedule = _buildSchedule();
    final startDate = formatDate(_startDate);
    final endDate = _hasEndDate && _endDate != null ? formatDate(_endDate!) : null;

    bool success;
    if (_isEditing) {
      final request = UpdatePlanRequest(
        name: name,
        schedule: schedule,
        startDate: startDate,
        endDate: endDate,
        color: _color,
        tasks: validTasks.asMap().entries.map((e) => UpdatePlanTaskRequest(
          id: e.value.id,
          name: e.value.name.trim(),
          sortOrder: e.key,
          startTime: e.value.startTime,
          endTime: e.value.endTime,
        )).toList(),
      );
      success = await ref.read(plansProvider.notifier).edit(widget.plan!, request);
    } else {
      final request = CreatePlanRequest(
        name: name,
        schedule: schedule,
        startDate: startDate,
        endDate: endDate,
        color: _color,
        tasks: validTasks.asMap().entries.map((e) => CreatePlanTaskRequest(
          name: e.value.name.trim(),
          sortOrder: e.key,
          startTime: e.value.startTime,
          endTime: e.value.endTime,
        )).toList(),
      );
      success = await ref.read(plansProvider.notifier).add(request);
    }

    if (!mounted) return;
    if (success) {
      Navigator.pop(context);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to save plan. Please try again.')),
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
          setState(() => _tasks.add(PlanTaskItem(
            name: name,
            sortOrder: _tasks.length,
            startTime: startTime,
            endTime: endTime,
          )));
        },
      ),
    );
  }

  void _editEvent(int index) {
    final task = _tasks[index];
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => AddEventSheet(
        initialName: task.name,
        initialStartTime: task.startTimeOfDay,
        initialEndTime: task.endTimeOfDay,
        onSave: (name, startTime, endTime, date, color) {
          setState(() {
            _tasks[index].name = name;
            _tasks[index].startTime = startTime;
            _tasks[index].endTime = endTime;
          });
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
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
            selectedColor: _color,
            onColorChanged: (c) => setState(() => _color = c),
          ),
          const SizedBox(height: 20),

          // Schedule
          ScheduleConfigSection(
            type: _scheduleType,
            weeklyDays: _weeklyDays,
            intervalEvery: _intervalEvery,
            monthlyDates: _monthlyDates,
            monthlyWeekdayOccurrence: _monthlyWeekdayOccurrence,
            monthlyWeekdayDay: _monthlyWeekdayDay,
            onTypeChanged: (t) => setState(() => _scheduleType = t),
            onWeeklyDaysChanged: (d) => setState(() => _weeklyDays = d),
            onIntervalChanged: (v) => setState(() => _intervalEvery = v),
            onMonthlyDatesChanged: (d) => setState(() => _monthlyDates = d),
            onMonthlyWeekdayOccurrenceChanged: (v) => setState(() => _monthlyWeekdayOccurrence = v),
            onMonthlyWeekdayDayChanged: (v) => setState(() => _monthlyWeekdayDay = v),
          ),
          const SizedBox(height: 20),

          // Dates
          Text('Date range', style: Theme.of(context).textTheme.titleSmall),
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: () => _pickDate(isStart: true),
                  icon: const Icon(Icons.calendar_today_outlined, size: 16),
                  label: Text(DateFormat('MMM d, yyyy').format(_startDate)),
                ),
              ),
              const SizedBox(width: 8),
              Switch(
                value: _hasEndDate,
                onChanged: (v) => setState(() {
                  _hasEndDate = v;
                  if (!v) _endDate = null;
                }),
              ),
              const Text('End'),
            ],
          ),
          if (_hasEndDate) ...[
            const SizedBox(height: 8),
            OutlinedButton.icon(
              onPressed: () => _pickDate(isStart: false),
              icon: const Icon(Icons.calendar_today_outlined, size: 16),
              label: Text(
                _endDate != null ? DateFormat('MMM d, yyyy').format(_endDate!) : 'Pick end date',
              ),
            ),
          ],
          const SizedBox(height: 20),

          // Events
          Row(
            children: [
              Expanded(child: Text('Events', style: Theme.of(context).textTheme.titleSmall)),
              TextButton.icon(
                onPressed: _addEvent,
                icon: const Icon(Icons.add, size: 18),
                label: const Text('Add'),
              ),
            ],
          ),
          const SizedBox(height: 8),
          PlanEventList(
            tasks: _tasks,
            onEdit: _editEvent,
            onDelete: (i) => setState(() => _tasks.removeAt(i)),
          ),
          const SizedBox(height: 80),
        ],
      ),
    );
  }
}
