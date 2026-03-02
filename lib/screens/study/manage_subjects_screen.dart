import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:marquer/api/models/study/study_subject.dart';
import 'package:marquer/providers/study/study_subjects_provider.dart';
import 'package:marquer/screens/study/subject_form_sheet.dart';
import 'package:marquer/utils/action_sheet.dart';
import 'package:marquer/utils/colors.dart';

class ManageSubjectsScreen extends ConsumerWidget {
  const ManageSubjectsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final subjectsAsync = ref.watch(studySubjectsProvider);
    return Scaffold(
      appBar: AppBar(title: const Text('Subjects')),
      floatingActionButton: FloatingActionButton(
        onPressed: () => showSubjectFormSheet(context),
        child: const Icon(Icons.add),
      ),
      body: RefreshIndicator(
        onRefresh: () => ref.refresh(studySubjectsProvider.future),
        child: subjectsAsync.when(
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (e, _) => Center(child: Text('Error: $e')),
          data: (subjects) => GridView.builder(
            padding: const EdgeInsets.all(16),
            physics: const AlwaysScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 12,
              crossAxisSpacing: 12,
              childAspectRatio: 1.4,
            ),
            itemCount: subjects.length,
            itemBuilder: (_, i) {
              final s = subjects[i];
              return _SubjectTile(
                subject: s,
                onTap: s.isSystem
                    ? null
                    : () => showSubjectFormSheet(context, subject: s),
                onLongPress: s.isSystem
                    ? null
                    : () => _showActions(context, ref, s),
              );
            },
          ),
        ),
      ),
    );
  }

  void _showActions(
    BuildContext context,
    WidgetRef ref,
    StudySubject s,
  ) async {
    final result = await showAppActionSheet(context, [
      AppAction(value: 'edit', icon: Icons.edit_outlined, label: 'Edit'),
      AppAction(
        value: 'delete',
        icon: Icons.delete_outline,
        label: 'Delete',
        isDestructive: true,
      ),
    ]);
    if (!context.mounted) return;
    if (result == 'edit') showSubjectFormSheet(context, subject: s);
    if (result == 'delete') _confirmDelete(context, ref, s);
  }

  void _confirmDelete(
    BuildContext context,
    WidgetRef ref,
    StudySubject subject,
  ) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Delete Subject?'),
        content: Text('Delete "${subject.name}"?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(ctx).pop();
              ref
                  .read(studySubjectsProvider.notifier)
                  .deleteSubject(subject);
            },
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }
}

class _SubjectTile extends StatelessWidget {
  final StudySubject subject;
  final VoidCallback? onTap;
  final VoidCallback? onLongPress;

  const _SubjectTile({
    required this.subject,
    this.onTap,
    this.onLongPress,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final subjectColor = hexToColor(subject.color);

    return Container(
      decoration: BoxDecoration(
        color: subjectColor.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: subjectColor.withValues(alpha: 0.3)),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: onTap,
        onLongPress: onLongPress,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    width: 32,
                    height: 32,
                    decoration: BoxDecoration(
                      color: subjectColor,
                      shape: BoxShape.circle,
                    ),
                  ),
                  const Spacer(),
                  if (subject.isSystem)
                    Icon(
                      Icons.lock_outline,
                      size: 16,
                      color: colorScheme.onSurfaceVariant,
                    ),
                ],
              ),
              const Spacer(),
              Text(
                subject.name,
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
