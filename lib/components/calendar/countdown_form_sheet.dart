import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:marquer/utils/format.dart';

class CountdownFormSheet extends StatefulWidget {
  final String? initialName;
  final DateTime? initialDate;
  final void Function(String name, String targetDate) onSave;

  const CountdownFormSheet({
    super.key,
    this.initialName,
    this.initialDate,
    required this.onSave,
  });

  @override
  State<CountdownFormSheet> createState() => _CountdownFormSheetState();
}

class _CountdownFormSheetState extends State<CountdownFormSheet> {
  late final TextEditingController _nameController;
  DateTime? _selectedDate;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.initialName ?? '');
    _selectedDate = widget.initialDate;
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  Future<void> _pickDate() async {
    final now = DateTime.now();
    final firstDate = now.add(const Duration(days: 1));
    final lastDate = DateTime(2100);
    final initialDate = (_selectedDate != null && _selectedDate!.isAfter(firstDate))
        ? _selectedDate!
        : firstDate;
    final picked = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: firstDate,
      lastDate: lastDate,
    );
    if (picked != null) setState(() => _selectedDate = picked);
  }

  void _save() {
    final name = _nameController.text.trim();
    if (name.isEmpty || _selectedDate == null) return;
    Navigator.pop(context);
    widget.onSave(name, formatDate(_selectedDate!));
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final isEditing = widget.initialName != null;

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
                Text(
                  isEditing ? 'Edit Countdown' : 'Add Countdown',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: _nameController,
                  autofocus: true,
                  decoration: const InputDecoration(hintText: 'Countdown name'),
                  onSubmitted: (_) => _pickDate(),
                ),
                const SizedBox(height: 12),
                OutlinedButton.icon(
                  onPressed: _pickDate,
                  icon: const Icon(Icons.calendar_today_outlined, size: 18),
                  label: Text(
                    _selectedDate == null
                        ? 'Pick a date'
                        : DateFormat('MMMM d, yyyy').format(_selectedDate!),
                  ),
                ),
                const SizedBox(height: 16),
                FilledButton(
                  onPressed: _save,
                  child: Text(isEditing ? 'Save' : 'Add'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
