enum StudySessionStatus {
  active,
  paused,
  completed,
  cancelled;

  static StudySessionStatus fromString(String v) =>
      StudySessionStatus.values.firstWhere(
        (e) => e.name == v,
        orElse: () => StudySessionStatus.active,
      );
}
