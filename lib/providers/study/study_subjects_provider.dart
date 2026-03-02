import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:marquer/api/models/study/study_subject.dart';
import 'package:marquer/api/models/study/upsert_study_subject_request.dart';
import 'package:marquer/api/services/study_service.dart';
import 'package:marquer/services/toast_service.dart';

final studySubjectsProvider =
    AsyncNotifierProvider<StudySubjectsNotifier, List<StudySubject>>(
      StudySubjectsNotifier.new,
    );

class StudySubjectsNotifier extends AsyncNotifier<List<StudySubject>> {
  final _service = StudyService();

  @override
  Future<List<StudySubject>> build() => _service.getSubjects();

  Future<void> addSubject(String name, String color) async {
    final current = state.asData?.value ?? [];
    try {
      final created = await _service.createSubject(
        UpsertStudySubjectRequest(name: name, color: color),
      );
      if (!ref.mounted) return;
      state = AsyncData([...current, created]);
    } catch (e) {
      debugPrint(e.toString());
      ToastService.showError('Unable to create subject');
    }
  }

  Future<void> updateSubject(
    StudySubject subject,
    String name,
    String color,
  ) async {
    final current = state.asData?.value ?? [];
    state = AsyncData([
      for (final s in current)
        if (s.id == subject.id) s.copyWith(name: name, color: color) else s,
    ]);
    try {
      final updated = await _service.updateSubject(
        subject.id,
        UpsertStudySubjectRequest(name: name, color: color),
      );
      if (!ref.mounted) return;
      state = AsyncData([
        for (final s in state.asData!.value)
          if (s.id == subject.id) updated else s,
      ]);
    } catch (e) {
      if (!ref.mounted) return;
      state = AsyncData(current);
      debugPrint(e.toString());
      ToastService.showError('Unable to update subject');
    }
  }

  Future<void> deleteSubject(StudySubject subject) async {
    final current = state.asData?.value ?? [];
    state = AsyncData([
      for (final s in current)
        if (s.id != subject.id) s,
    ]);
    try {
      await _service.deleteSubject(subject.id);
    } catch (e) {
      if (!ref.mounted) return;
      state = AsyncData(current);
      debugPrint(e.toString());
      ToastService.showError('Unable to delete subject');
    }
  }
}
