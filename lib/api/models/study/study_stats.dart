import 'package:marquer/api/models/study/study_session.dart';

class StudyStats {
  final int todayTotalSeconds;
  final List<StudySession> sessions;

  StudyStats({required this.todayTotalSeconds, required this.sessions});

  factory StudyStats.fromJson(Map<String, dynamic> json) => StudyStats(
    todayTotalSeconds: json['today_total_seconds'] as int? ?? 0,
    sessions:
        (json['sessions'] as List<dynamic>)
            .map((e) => StudySession.fromJson(e as Map<String, dynamic>))
            .toList(),
  );
}
