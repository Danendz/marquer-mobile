import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:marquer/api/models/study/study_subject.dart';
import 'package:marquer/api/models/study/upsert_study_subject_request.dart';
import 'package:marquer/api/services/study_service.dart';
import 'package:marquer/providers/optimistic_mutation.dart';

final studySubjectsProvider =
    AsyncNotifierProvider<StudySubjectsNotifier, List<StudySubject>>(
      StudySubjectsNotifier.new,
    );

class StudySubjectsNotifier extends AsyncNotifier<List<StudySubject>>
    with OptimisticMutation {
  final _service = StudyService();

  @override
  Future<List<StudySubject>> build() => _service.getSubjects();

  Future<void> addSubject(String name, String color) async {
    final current = currentValue ?? [];
    await mutate(
      action: () => _service.createSubject(
        UpsertStudySubjectRequest(name: name, color: color),
      ),
      errorMessage: 'Unable to create subject',
      onSuccess: (latest, created) => [...current, created],
    );
  }

  Future<void> updateSubject(
    StudySubject subject,
    String name,
    String color,
  ) async {
    final current = currentValue ?? [];
    state = AsyncData([
      for (final s in current)
        if (s.id == subject.id) s.copyWith(name: name, color: color) else s,
    ]);
    await mutate(
      action: () => _service.updateSubject(
        subject.id,
        UpsertStudySubjectRequest(name: name, color: color),
      ),
      errorMessage: 'Unable to update subject',
      rollback: () => current,
      onSuccess: (latest, updated) => [
        for (final s in latest) if (s.id == subject.id) updated else s,
      ],
    );
  }

  Future<void> deleteSubject(StudySubject subject) async {
    final current = currentValue ?? [];
    state = AsyncData([
      for (final s in current) if (s.id != subject.id) s,
    ]);
    await mutate(
      action: () => _service.deleteSubject(subject.id),
      errorMessage: 'Unable to delete subject',
      rollback: () => current,
    );
  }
}
