import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:marquer/api/models/study/study_stats.dart';
import 'package:marquer/api/services/study_service.dart';

final studyStatsProvider = FutureProvider<StudyStats>(
  (ref) => StudyService().getStats(),
);
