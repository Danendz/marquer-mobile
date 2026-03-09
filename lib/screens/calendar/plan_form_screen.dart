import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:marquer/api/models/calendar/create_plan_request.dart';
import 'package:marquer/api/models/calendar/plan.dart';
import 'package:marquer/api/models/calendar/plan_schedule.dart';
import 'package:marquer/api/models/calendar/update_plan_request.dart';
import 'package:marquer/providers/calendar/plans_provider.dart';
import 'package:marquer/utils/action_sheet.dart';

class _TaskItem {
  final int? id;
  String name;
  int sortOrder;
  String? startTime;
  String? endTime;

  _TaskItem({this.id, required this.name, required this.sortOrder, this.startTime, this.endTime});

  String _fmtTime(TimeOfDay t) =>
      '${t.hour.toString().padLeft(2, '0')}:${t.minute.toString().padLeft(2, '0')}';

  TimeOfDay? get startTimeOfDay {
    if (startTime == null) return null;
    final parts = startTime!.split(':');
    return TimeOfDay(hour: int.parse(parts[0]), minute: int.parse(parts[1]));
  }

  TimeOfDay? get endTimeOfDay {
    if (endTime == null) return null;
    final parts = endTime!.split(':');
    return TimeOfDay(hour: int.parse(parts[0]), minute: int.parse(parts[1]));
  }

  void setStartTime(TimeOfDay? t) {
    startTime = t != null ? _fmtTime(t) : null;
  }

  void setEndTime(TimeOfDay? t) {
    endTime = t != null ? _fmtTime(t) : null;
  }
}

enum _ScheduleType { daily, weekly, interval, monthlyDates, monthlyWeekday }

const _weekdayLabels = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
const _weekOccurrenceLabels = ['First', 'Second', 'Third', 'Fourth', 'Last'];
const _weekOccurrenceValues = [1, 2, 3, 4, -1];

class PlanFormScreen extends ConsumerStatefulWidget {
  final Plan? plan;

  const PlanFormScreen({super.key, this.plan});

  @override
  ConsumerState<PlanFormScreen> createState() => _PlanFormScreenState();
}

class _PlanFormScreenState extends ConsumerState<PlanFormScreen> {
  late final TextEditingController _nameController;
  late _ScheduleType _scheduleType;
  late List<int> _weeklyDays;
  late int _intervalEvery;
  late List<int> _monthlyDates;
  late int _monthlyWeekdayOccurrence;
  late int _monthlyWeekdayDay;
  late DateTime _startDate;
  DateTime? _endDate;
  bool _hasEndDate = false;
  late List<_TaskItem> _tasks;
  bool _isReorderMode = false;

  bool get _isEditing => widget.plan != null;

  @override
  void initState() {
    super.initState();
    final plan = widget.plan;

    _nameController = TextEditingController(text: plan?.name ?? '');
    _startDate = plan != null ? DateTime.parse(plan.startDate) : DateTime.now();
    _endDate = plan?.endDate != null ? DateTime.parse(plan!.endDate!) : null;
    _hasEndDate = _endDate != null;

    if (plan != null) {
      _tasks = plan.tasks
          .map((t) => _TaskItem(id: t.id, name: t.name, sortOrder: t.sortOrder, startTime: t.startTime, endTime: t.endTime))
          .toList();
      _initScheduleFromPlan(plan.schedule);
    } else {
      _scheduleType = _ScheduleType.daily;
      _weeklyDays = [DateTime.now().weekday - 1]; // 0-indexed Mon
      _intervalEvery = 1;
      _monthlyDates = [DateTime.now().day];
      _monthlyWeekdayOccurrence = 1;
      _monthlyWeekdayDay = DateTime.now().weekday - 1;
      _tasks = [_TaskItem(name: '', sortOrder: 0)];
    }
  }

  void _initScheduleFromPlan(PlanSchedule schedule) {
    switch (schedule) {
      case DailySchedule():
        _scheduleType = _ScheduleType.daily;
        _weeklyDays = [0];
        _intervalEvery = 1;
        _monthlyDates = [1];
        _monthlyWeekdayOccurrence = 1;
        _monthlyWeekdayDay = 0;
      case WeeklySchedule(:final days):
        _scheduleType = _ScheduleType.weekly;
        _weeklyDays = List.from(days);
        _intervalEvery = 1;
        _monthlyDates = [1];
        _monthlyWeekdayOccurrence = 1;
        _monthlyWeekdayDay = 0;
      case IntervalSchedule(:final every):
        _scheduleType = _ScheduleType.interval;
        _weeklyDays = [0];
        _intervalEvery = every;
        _monthlyDates = [1];
        _monthlyWeekdayOccurrence = 1;
        _monthlyWeekdayDay = 0;
      case MonthlyDatesSchedule(:final days):
        _scheduleType = _ScheduleType.monthlyDates;
        _weeklyDays = [0];
        _intervalEvery = 1;
        _monthlyDates = List.from(days);
        _monthlyWeekdayOccurrence = 1;
        _monthlyWeekdayDay = 0;
      case MonthlyWeekdaySchedule(:final week, :final weekday):
        _scheduleType = _ScheduleType.monthlyWeekday;
        _weeklyDays = [0];
        _intervalEvery = 1;
        _monthlyDates = [1];
        _monthlyWeekdayOccurrence = week;
        _monthlyWeekdayDay = weekday;
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  String _formatDate(DateTime d) =>
      '${d.year}-${d.month.toString().padLeft(2, '0')}-${d.day.toString().padLeft(2, '0')}';

  PlanSchedule _buildSchedule() {
    return switch (_scheduleType) {
      _ScheduleType.daily => const DailySchedule(),
      _ScheduleType.weekly => WeeklySchedule(days: List.from(_weeklyDays)),
      _ScheduleType.interval => IntervalSchedule(every: _intervalEvery),
      _ScheduleType.monthlyDates => MonthlyDatesSchedule(days: List.from(_monthlyDates)),
      _ScheduleType.monthlyWeekday => MonthlyWeekdaySchedule(
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

  void _save() {
    final name = _nameController.text.trim();
    if (name.isEmpty) return;

    final validTasks = _tasks.where((t) => t.name.trim().isNotEmpty).toList();
    if (validTasks.isEmpty) return;

    final schedule = _buildSchedule();
    final startDate = _formatDate(_startDate);
    final endDate = _hasEndDate && _endDate != null ? _formatDate(_endDate!) : null;

    if (_isEditing) {
      final request = UpdatePlanRequest(
        name: name,
        schedule: schedule,
        startDate: startDate,
        endDate: endDate,
        tasks: validTasks.asMap().entries.map((e) => UpdatePlanTaskRequest(
          id: e.value.id,
          name: e.value.name.trim(),
          sortOrder: e.key,
          startTime: e.value.startTime,
          endTime: e.value.endTime,
        )).toList(),
      );
      ref.read(plansProvider.notifier).edit(widget.plan!, request);
    } else {
      final request = CreatePlanRequest(
        name: name,
        schedule: schedule,
        startDate: startDate,
        endDate: endDate,
        tasks: validTasks.asMap().entries.map((e) => CreatePlanTaskRequest(
          name: e.value.name.trim(),
          sortOrder: e.key,
          startTime: e.value.startTime,
          endTime: e.value.endTime,
        )).toList(),
      );
      ref.read(plansProvider.notifier).add(request);
    }

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

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
          const SizedBox(height: 20),

          // Schedule type
          Text('Repeat', style: Theme.of(context).textTheme.titleSmall),
          const SizedBox(height: 8),
          _buildScheduleTypePicker(colors),
          const SizedBox(height: 12),
          _buildScheduleConfig(colors),
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

          // Tasks
          Row(
            children: [
              Expanded(child: Text('Tasks', style: Theme.of(context).textTheme.titleSmall)),
              if (_isReorderMode)
                TextButton(
                  onPressed: () => setState(() => _isReorderMode = false),
                  child: const Text('Done'),
                )
              else
                TextButton.icon(
                  onPressed: () => setState(() {
                    _tasks.add(_TaskItem(name: '', sortOrder: _tasks.length));
                  }),
                  icon: const Icon(Icons.add, size: 18),
                  label: const Text('Add'),
                ),
            ],
          ),
          const SizedBox(height: 8),
          _buildTaskList(colors),
          const SizedBox(height: 80),
        ],
      ),
    );
  }

  Widget _buildScheduleTypePicker(ColorScheme colors) {
    return Wrap(
      spacing: 8,
      children: [
        for (final type in _ScheduleType.values)
          ChoiceChip(
            label: Text(_scheduleTypeLabel(type)),
            selected: _scheduleType == type,
            onSelected: (_) => setState(() => _scheduleType = type),
          ),
      ],
    );
  }

  String _scheduleTypeLabel(_ScheduleType type) {
    return switch (type) {
      _ScheduleType.daily => 'Daily',
      _ScheduleType.weekly => 'Weekly',
      _ScheduleType.interval => 'Interval',
      _ScheduleType.monthlyDates => 'Monthly dates',
      _ScheduleType.monthlyWeekday => 'Monthly weekday',
    };
  }

  Widget _buildScheduleConfig(ColorScheme colors) {
    return switch (_scheduleType) {
      _ScheduleType.daily => const SizedBox.shrink(),
      _ScheduleType.weekly => _buildWeeklyConfig(),
      _ScheduleType.interval => _buildIntervalConfig(),
      _ScheduleType.monthlyDates => _buildMonthlyDatesConfig(),
      _ScheduleType.monthlyWeekday => _buildMonthlyWeekdayConfig(colors),
    };
  }

  Widget _buildWeeklyConfig() {
    return Wrap(
      spacing: 6,
      children: List.generate(7, (i) {
        final selected = _weeklyDays.contains(i);
        return FilterChip(
          label: Text(_weekdayLabels[i]),
          selected: selected,
          onSelected: (v) => setState(() {
            if (v) {
              _weeklyDays.add(i);
            } else if (_weeklyDays.length > 1) {
              _weeklyDays.remove(i);
            }
          }),
        );
      }),
    );
  }

  Widget _buildIntervalConfig() {
    return Row(
      children: [
        const Text('Every'),
        const SizedBox(width: 12),
        IconButton(
          onPressed: _intervalEvery > 1 ? () => setState(() => _intervalEvery--) : null,
          icon: const Icon(Icons.remove),
        ),
        Text('$_intervalEvery', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
        IconButton(
          onPressed: () => setState(() => _intervalEvery++),
          icon: const Icon(Icons.add),
        ),
        const Text('days'),
      ],
    );
  }

  Widget _buildMonthlyDatesConfig() {
    return Wrap(
      spacing: 4,
      runSpacing: 4,
      children: List.generate(31, (i) {
        final day = i + 1;
        final selected = _monthlyDates.contains(day);
        return SizedBox(
          width: 40,
          child: FilterChip(
            label: Text('$day', style: const TextStyle(fontSize: 12)),
            selected: selected,
            onSelected: (v) => setState(() {
              if (v) {
                _monthlyDates.add(day);
              } else if (_monthlyDates.length > 1) {
                _monthlyDates.remove(day);
              }
            }),
            padding: EdgeInsets.zero,
            labelPadding: EdgeInsets.zero,
          ),
        );
      }),
    );
  }

  Widget _buildMonthlyWeekdayConfig(ColorScheme colors) {
    return Row(
      children: [
        Expanded(
          child: DropdownButtonFormField<int>(
            initialValue: _weekOccurrenceValues.contains(_monthlyWeekdayOccurrence)
                ? _monthlyWeekdayOccurrence
                : 1,
            decoration: const InputDecoration(labelText: 'Occurrence', border: OutlineInputBorder()),
            items: List.generate(_weekOccurrenceLabels.length, (i) => DropdownMenuItem(
              value: _weekOccurrenceValues[i],
              child: Text(_weekOccurrenceLabels[i]),
            )),
            onChanged: (v) => setState(() => _monthlyWeekdayOccurrence = v!),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: DropdownButtonFormField<int>(
            initialValue: _monthlyWeekdayDay,
            decoration: const InputDecoration(labelText: 'Weekday', border: OutlineInputBorder()),
            items: List.generate(7, (i) => DropdownMenuItem(
              value: i,
              child: Text(_weekdayLabels[i]),
            )),
            onChanged: (v) => setState(() => _monthlyWeekdayDay = v!),
          ),
        ),
      ],
    );
  }

  Widget _buildTaskList(ColorScheme colors) {
    return ReorderableListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      buildDefaultDragHandles: false,
      itemCount: _tasks.length,
      onReorder: (oldIndex, newIndex) {
        setState(() {
          if (newIndex > oldIndex) newIndex--;
          final item = _tasks.removeAt(oldIndex);
          _tasks.insert(newIndex, item);
          for (var i = 0; i < _tasks.length; i++) {
            _tasks[i].sortOrder = i;
          }
        });
      },
      itemBuilder: (context, index) {
        final task = _tasks[index];
        return GestureDetector(
          key: ValueKey(task),
          onLongPress: _isReorderMode
              ? null
              : () async {
                  final result = await showAppActionSheet(context, const [
                    AppAction(value: 'reorder', icon: Icons.reorder, label: 'Reorder'),
                  ]);
                  if (result == 'reorder') setState(() => _isReorderMode = true);
                },
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: colors.surfaceContainer,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (_isReorderMode)
                  ReorderableDragStartListener(
                    index: index,
                    child: const Padding(
                      padding: EdgeInsets.only(top: 14),
                      child: Icon(Icons.drag_handle, size: 20),
                    ),
                  ),
                if (_isReorderMode) const SizedBox(width: 8),
                Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextField(
                          controller: TextEditingController(text: task.name),
                          decoration: InputDecoration(hintText: 'Task ${index + 1}'),
                          onChanged: (v) => task.name = v,
                        ),
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            _TimeChip(
                              label: task.startTime ?? 'Start',
                              hasValue: task.startTime != null,
                              onTap: () async {
                                final picked = await showTimePicker(
                                  context: context,
                                  initialTime: task.startTimeOfDay ?? TimeOfDay.now(),
                                );
                                if (picked != null) {
                                  setState(() {
                                    task.setStartTime(picked);
                                    final endMin = picked.hour * 60 + picked.minute + 60;
                                    if (task.endTime == null) {
                                      task.setEndTime(TimeOfDay(hour: (endMin ~/ 60) % 24, minute: endMin % 60));
                                    }
                                  });
                                }
                              },
                            ),
                            if (task.startTime != null) ...[
                              const SizedBox(width: 6),
                              _TimeChip(
                                label: task.endTime ?? 'End',
                                hasValue: task.endTime != null,
                                onTap: () async {
                                  final picked = await showTimePicker(
                                    context: context,
                                    initialTime: task.endTimeOfDay ?? TimeOfDay.now(),
                                  );
                                  if (picked != null) setState(() => task.setEndTime(picked));
                                },
                              ),
                              const SizedBox(width: 4),
                              GestureDetector(
                                onTap: () => setState(() {
                                  task.setStartTime(null);
                                  task.setEndTime(null);
                                }),
                                child: Icon(Icons.close, size: 16, color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.4)),
                              ),
                            ],
                          ],
                        ),
                        const SizedBox(height: 4),
                      ],
                    ),
                  ),
                  if (_tasks.length > 1)
                    IconButton(
                      icon: const Icon(Icons.delete_outline, size: 20),
                      onPressed: () => setState(() => _tasks.removeAt(index)),
                      visualDensity: VisualDensity.compact,
                    ),
                ],
              ),
          ),
        );
      },
    );
  }
}

class _TimeChip extends StatelessWidget {
  final String label;
  final bool hasValue;
  final VoidCallback onTap;

  const _TimeChip({required this.label, required this.hasValue, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
          color: hasValue ? colors.primaryContainer : colors.surfaceContainerHighest,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: hasValue ? colors.onPrimaryContainer : colors.onSurface.withValues(alpha: 0.6),
          ),
        ),
      ),
    );
  }
}
