import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:marquer/api/models/study/study_session.dart';

part 'study_stats.freezed.dart';
part 'study_stats.g.dart';

@freezed
abstract class StudyStats with _$StudyStats {
  @JsonSerializable(explicitToJson: true)
  const factory StudyStats({
    @JsonKey(name: 'today_total_seconds') @Default(0) int todayTotalSeconds,
    required List<StudySession> sessions,
  }) = _StudyStats;

  factory StudyStats.fromJson(Map<String, dynamic> json) =>
      _$StudyStatsFromJson(json);
}
