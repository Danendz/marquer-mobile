import 'package:json_annotation/json_annotation.dart';

enum StudySessionStatus {
  @JsonValue('active')
  active,
  @JsonValue('paused')
  paused,
  @JsonValue('completed')
  completed,
  @JsonValue('cancelled')
  cancelled;

  static StudySessionStatus fromString(String v) =>
      StudySessionStatus.values.firstWhere(
        (e) => e.name == v,
        orElse: () => StudySessionStatus.active,
      );
}
