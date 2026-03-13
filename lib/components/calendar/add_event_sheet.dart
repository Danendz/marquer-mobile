import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:marquer/components/calendar/widgets/event_day_selector.dart';
import 'package:marquer/components/shared/color_picker_row.dart';
import 'package:marquer/providers/calendar/calendar_day_events_provider.dart';
import 'package:marquer/utils/format.dart';

class AddEventSheet extends ConsumerStatefulWidget {
  final TimeOfDay? initialStartTime;
  final TimeOfDay? initialEndTime;
  final String? initialDate;
  final List<DateTime>? weekDays;
  final String? initialName;
  final void Function(String name, String? startTime, String? endTime, String date, String? color)? onSave;

  const AddEventSheet({
    super.key,
    this.initialStartTime,
    this.initialEndTime,
    this.initialDate,
    this.weekDays,
    this.initialName,
    this.onSave,
  });

  @override
  ConsumerState<AddEventSheet> createState() => _AddEventSheetState();
}

class _AddEventSheetState extends ConsumerState<AddEventSheet> {
  final _controller = TextEditingController();
  TimeOfDay? _startTime;
  TimeOfDay? _endTime;
  DateTime? _selectedDate;
  String? _color;

  static const _dayLabels = ['M', 'T', 'W', 'T', 'F', 'S', 'S'];

  @override
  void initState() {
    super.initState();
    _startTime = widget.initialStartTime;
    _endTime = widget.initialEndTime;
    if (widget.initialDate != null) {
      _selectedDate = DateTime.parse(widget.initialDate!);
    }
    _controller.text = widget.initialName ?? '';
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
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

  Future<void> _save() async {
    final name = _controller.text.trim();
    if (name.isEmpty) return;
    Navigator.pop(context);

    final startStr = _startTime != null ? formatTimeOfDay(_startTime!) : null;
    final endStr = _endTime != null ? formatTimeOfDay(_endTime!) : null;

    final dateStr = _selectedDate != null ? formatDate(_selectedDate!) : (widget.initialDate ?? '');
    if (widget.onSave != null) {
      widget.onSave!(name, startStr, endStr, dateStr, _color);
    } else {
      await ref.read(calendarDayEventsProvider.notifier).addEvent(
            name,
            startTime: startStr,
            endTime: endStr,
            date: _selectedDate != null ? formatDate(_selectedDate!) : widget.initialDate,
            color: _color,
          );
    }
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
                Text(widget.initialName != null ? 'Edit Event' : 'Add Event', style: Theme.of(context).textTheme.titleMedium),
                const SizedBox(height: 12),
                if (widget.weekDays != null) ...[
                  EventDaySelector(
                    days: widget.weekDays!,
                    selected: _selectedDate,
                    colorScheme: colorScheme,
                    dayLabels: _dayLabels,
                    onSelect: (d) => setState(() => _selectedDate = d),
                  ),
                  const SizedBox(height: 12),
                ],
                TextField(
                  controller: _controller,
                  autofocus: true,
                  decoration: const InputDecoration(hintText: 'Event name'),
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
