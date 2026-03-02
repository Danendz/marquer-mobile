class CompleteStudySessionRequest {
  final int actualDurationSeconds;
  final int? pomodoroCompletedCycles;

  CompleteStudySessionRequest({
    required this.actualDurationSeconds,
    this.pomodoroCompletedCycles,
  });

  Map<String, dynamic> toJson() {
    final m = <String, dynamic>{
      'actual_duration_seconds': actualDurationSeconds,
    };
    if (pomodoroCompletedCycles != null) {
      m['pomodoro_completed_cycles'] = pomodoroCompletedCycles;
    }
    return m;
  }
}
