import 'package:flutter/material.dart';
import 'package:marquer/api/models/tasks/tasks/task.dart';
import 'package:marquer/components/shared/color_picker_row.dart';
import 'package:marquer/utils/format.dart';

class TaskEditSheet extends StatefulWidget {
  final Task task;
  final void Function(
    String name,
    String? startTime,
    String? endTime,
    bool clearStartTime,
    bool clearEndTime,
    String? color,
  ) onSave;

  const TaskEditSheet({super.key, required this.task, required this.onSave});

  @override
  State<TaskEditSheet> createState() => _TaskEditSheetState();
}

class _TaskEditSheetState extends State<TaskEditSheet> {
  late final TextEditingController _nameController;
  TimeOfDay? _startTime;
  TimeOfDay? _endTime;
  String? _color;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.task.name);
    _startTime = _parseTime(widget.task.startTime);
    _endTime = _parseTime(widget.task.endTime);
    _color = widget.task.color;
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  TimeOfDay? _parseTime(String? timeStr) {
    if (timeStr == null) return null;
    try {
      final parts = timeStr.split(':');
      return TimeOfDay(hour: int.parse(parts[0]), minute: int.parse(parts[1]));
    } catch (_) {
      return null;
    }
  }

  Future<void> _pickStartTime() async {
    final picked = await showTimePicker(
      context: context,
      initialTime: _startTime ?? TimeOfDay.now(),
    );
    if (picked != null) {
      setState(() {
        _startTime = picked;
        if (_endTime == null ||
            _endTime!.hour * 60 + _endTime!.minute <= picked.hour * 60 + picked.minute) {
          final endMinutes = (picked.hour * 60 + picked.minute + 60).clamp(0, 23 * 60 + 59);
          _endTime = TimeOfDay(hour: endMinutes ~/ 60, minute: endMinutes % 60);
        }
      });
    }
  }

  Future<void> _pickEndTime() async {
    final picked = await showTimePicker(
      context: context,
      initialTime: _endTime ?? TimeOfDay.now(),
    );
    if (picked == null) return;
    if (_startTime != null &&
        picked.hour * 60 + picked.minute <= _startTime!.hour * 60 + _startTime!.minute) {
      return;
    }
    setState(() => _endTime = picked);
  }

  void _clearTime() => setState(() {
        _startTime = null;
        _endTime = null;
      });

  void _save() {
    final name = _nameController.text.trim();
    if (name.isEmpty) return;

    final hadStartTime = widget.task.startTime != null;
    final hadEndTime = widget.task.endTime != null;
    final newStartStr = _startTime != null ? formatTimeOfDay(_startTime!) : null;
    final newEndStr = _endTime != null ? formatTimeOfDay(_endTime!) : null;

    Navigator.pop(context);
    widget.onSave(
      name,
      newStartStr,
      newEndStr,
      hadStartTime && _startTime == null,
      hadEndTime && _endTime == null,
      _color,
    );
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final hasTime = _startTime != null;

    return Padding(
      padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Container(
        decoration: BoxDecoration(
          color: colorScheme.surface,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(24, 16, 24, 16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Center(
                  child: Container(
                    width: 36,
                    height: 4,
                    margin: const EdgeInsets.only(bottom: 16),
                    decoration: BoxDecoration(
                      color: colorScheme.onSurface.withValues(alpha: 0.25),
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ),
                Text('Edit Task', style: Theme.of(context).textTheme.titleMedium),
                const SizedBox(height: 12),
                TextField(
                  controller: _nameController,
                  autofocus: true,
                  decoration: const InputDecoration(hintText: 'Task name'),
                  onSubmitted: (_) => _save(),
                ),
                const SizedBox(height: 12),
                ColorPickerRow(
                  selectedColor: _color,
                  onColorChanged: (c) => setState(() => _color = c),
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton.icon(
                        onPressed: _pickStartTime,
                        icon: const Icon(Icons.access_time, size: 16),
                        label: Text(
                          _startTime != null ? formatTimeOfDay(_startTime!) : 'Start time',
                          style: const TextStyle(fontSize: 13),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: OutlinedButton.icon(
                        onPressed: _startTime != null ? _pickEndTime : null,
                        icon: const Icon(Icons.access_time_filled, size: 16),
                        label: Text(
                          _endTime != null ? formatTimeOfDay(_endTime!) : 'End time',
                          style: const TextStyle(fontSize: 13),
                        ),
                      ),
                    ),
                    if (hasTime) ...[
                      const SizedBox(width: 4),
                      IconButton(
                        onPressed: _clearTime,
                        icon: const Icon(Icons.close, size: 18),
                        visualDensity: VisualDensity.compact,
                      ),
                    ],
                  ],
                ),
                const SizedBox(height: 16),
                FilledButton(onPressed: _save, child: const Text('Save')),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
