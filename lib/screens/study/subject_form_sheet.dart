import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:marquer/api/models/study/study_subject.dart';
import 'package:marquer/providers/study/study_subjects_provider.dart';
import 'package:marquer/utils/colors.dart';

const _kColors = [
  '#4285F4', '#1A73E8', '#34A853', '#0F9D58',
  '#FBBC05', '#F9AB00', '#EA4335', '#D93025',
  '#9C27B0', '#7B1FA2', '#FF9800', '#E65100',
  '#00BCD4', '#0097A7', '#607D8B', '#455A64',
  '#E91E63', '#795548',
];

void showSubjectFormSheet(BuildContext context, {StudySubject? subject}) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (_) => SubjectFormSheet(existing: subject),
  );
}

class SubjectFormSheet extends ConsumerStatefulWidget {
  final StudySubject? existing;

  const SubjectFormSheet({super.key, this.existing});

  @override
  ConsumerState<SubjectFormSheet> createState() => _SubjectFormSheetState();
}

class _SubjectFormSheetState extends ConsumerState<SubjectFormSheet> {
  late final TextEditingController _nameCtrl;
  late String _selectedColor;
  bool _loading = false;

  @override
  void initState() {
    super.initState();
    _nameCtrl = TextEditingController(text: widget.existing?.name ?? '');
    _selectedColor = widget.existing?.color ?? '#4285F4';
  }

  @override
  void dispose() {
    _nameCtrl.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    final name = _nameCtrl.text.trim();
    if (name.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Subject name is required')),
      );
      return;
    }
    setState(() => _loading = true);
    try {
      final notifier = ref.read(studySubjectsProvider.notifier);
      if (widget.existing == null) {
        await notifier.addSubject(name, _selectedColor);
      } else {
        await notifier.updateSubject(widget.existing!, name, _selectedColor);
      }
      if (!mounted) return;
      Navigator.pop(context);
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final inputFill = colorScheme.onSurface.withValues(alpha: 0.06);
    final inputBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide.none,
    );
    final isEdit = widget.existing != null;

    return Container(
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainer,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.only(
            left: 24,
            right: 24,
            bottom: MediaQuery.of(context).viewInsets.bottom + 24,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Drag handle
              Center(
                child: Container(
                  width: 36,
                  height: 4,
                  margin: const EdgeInsets.symmetric(vertical: 14),
                  decoration: BoxDecoration(
                    color: colorScheme.onSurface.withValues(alpha: 0.25),
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),

              // Title row
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: colorScheme.primary.withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(
                      Icons.palette_outlined,
                      color: colorScheme.primary,
                      size: 22,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        isEdit ? 'Edit Subject' : 'New Subject',
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        isEdit
                            ? 'Modify subject details'
                            : 'Add a new study subject',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 24),

              // Name field
              TextField(
                controller: _nameCtrl,
                autofocus: true,
                decoration: InputDecoration(
                  labelText: 'Subject name',
                  filled: true,
                  fillColor: inputFill,
                  border: inputBorder,
                  enabledBorder: inputBorder,
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: colorScheme.primary, width: 1.5),
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // Color label
              Text(
                'Color',
                style: Theme.of(context).textTheme.labelMedium?.copyWith(
                  color: colorScheme.onSurfaceVariant,
                ),
              ),
              const SizedBox(height: 10),

              // Color palette
              Wrap(
                spacing: 10,
                runSpacing: 10,
                children: _kColors.map((hex) {
                  final isSelected = _selectedColor == hex;
                  return GestureDetector(
                    onTap: () => setState(() => _selectedColor = hex),
                    child: Container(
                      width: 36,
                      height: 36,
                      decoration: BoxDecoration(
                        color: hexToColor(hex),
                        shape: BoxShape.circle,
                        border: isSelected
                            ? Border.all(color: colorScheme.onSurface, width: 2.5)
                            : null,
                      ),
                      child: isSelected
                          ? const Icon(Icons.check, color: Colors.white, size: 18)
                          : null,
                    ),
                  );
                }).toList(),
              ),
              const SizedBox(height: 24),

              // Save button
              SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                  onPressed: _loading ? null : _save,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: colorScheme.primary,
                    foregroundColor: colorScheme.onPrimary,
                    disabledBackgroundColor:
                        colorScheme.primary.withValues(alpha: 0.5),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                  child: _loading
                      ? const SizedBox(
                          height: 18,
                          width: 18,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : Text(
                          isEdit ? 'Save Changes' : 'Add Subject',
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
