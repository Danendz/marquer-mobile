import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:marquer/api/models/study/study_session.dart';
import 'package:marquer/api/services/study_service.dart';

final studySessionsProvider =
    AsyncNotifierProvider<StudySessionsNotifier, List<StudySession>>(
      StudySessionsNotifier.new,
    );

class StudySessionsNotifier extends AsyncNotifier<List<StudySession>> {
  final _service = StudyService();

  @override
  Future<List<StudySession>> build() => _service.getSessions();

  void refresh() => ref.invalidateSelf();
}
