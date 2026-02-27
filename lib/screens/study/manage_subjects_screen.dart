import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:marquer/api/models/study/study_subject.dart';
import 'package:marquer/providers/study/study_subjects_provider.dart';

class ManageSubjectsScreen extends ConsumerWidget {
  const ManageSubjectsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final subjectsAsync = ref.watch(studySubjectsProvider);
    return Scaffold(
      appBar: AppBar(title: const Text('Subjects')),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showSubjectDialog(context, ref, null),
        child: const Icon(Icons.add),
      ),
      body: RefreshIndicator(
        onRefresh: () => ref.refresh(studySubjectsProvider.future),
        child: subjectsAsync.when(
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (e, _) => Center(child: Text('Error: $e')),
          data:
              (subjects) => ListView.builder(
                physics: const AlwaysScrollableScrollPhysics(),
                itemCount: subjects.length,
                itemBuilder: (_, i) {
                final s = subjects[i];
                return ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Color(
                      int.parse(
                        s.color.replaceFirst('#', 'FF'),
                        radix: 16,
                      ),
                    ),
                    child:
                        s.isSystem
                            ? const Icon(
                              Icons.lock,
                              size: 12,
                              color: Colors.white,
                            )
                            : null,
                  ),
                  title: Text(s.name),
                  subtitle: s.isSystem ? const Text('System subject') : null,
                  trailing:
                      s.isSystem
                          ? null
                          : Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                icon: const Icon(Icons.edit),
                                onPressed:
                                    () => _showSubjectDialog(context, ref, s),
                              ),
                              IconButton(
                                icon: const Icon(Icons.delete),
                                onPressed:
                                    () => _confirmDelete(context, ref, s),
                              ),
                            ],
                          ),
                );
              },
            ),
          ),
        ),
    );
  }

  void _showSubjectDialog(
    BuildContext context,
    WidgetRef ref,
    StudySubject? existing,
  ) {
    final nameCtrl = TextEditingController(text: existing?.name ?? '');
    String color = existing?.color ?? '#4285F4';
    showDialog(
      context: context,
      builder:
          (ctx) => StatefulBuilder(
            builder:
                (ctx, setState) => AlertDialog(
                  title: Text(existing == null ? 'New Subject' : 'Edit Subject'),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextField(
                        controller: nameCtrl,
                        decoration: const InputDecoration(labelText: 'Name'),
                      ),
                      const SizedBox(height: 12),
                      Wrap(
                        spacing: 8,
                        children:
                            [
                              '#4285F4',
                              '#34A853',
                              '#FBBC05',
                              '#EA4335',
                              '#9C27B0',
                              '#FF9800',
                              '#00BCD4',
                              '#607D8B',
                            ].map(
                              (c) => GestureDetector(
                                onTap: () => setState(() => color = c),
                                child: CircleAvatar(
                                  backgroundColor: Color(
                                    int.parse(
                                      c.replaceFirst('#', 'FF'),
                                      radix: 16,
                                    ),
                                  ),
                                  radius: 16,
                                  child:
                                      color == c
                                          ? const Icon(
                                            Icons.check,
                                            color: Colors.white,
                                            size: 16,
                                          )
                                          : null,
                                ),
                              ),
                            ).toList(),
                      ),
                    ],
                  ),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.of(ctx).pop(),
                      child: const Text('Cancel'),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        if (nameCtrl.text.trim().isEmpty) return;
                        Navigator.of(ctx).pop();
                        if (existing == null) {
                          ref
                              .read(studySubjectsProvider.notifier)
                              .addSubject(nameCtrl.text.trim(), color);
                        } else {
                          ref
                              .read(studySubjectsProvider.notifier)
                              .updateSubject(
                                existing,
                                nameCtrl.text.trim(),
                                color,
                              );
                        }
                      },
                      child: const Text('Save'),
                    ),
                  ],
                ),
          ),
    );
  }

  void _confirmDelete(
    BuildContext context,
    WidgetRef ref,
    StudySubject subject,
  ) {
    showDialog(
      context: context,
      builder:
          (ctx) => AlertDialog(
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
