import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:marquer/api/models/study/store_study_session_request.dart';
import 'package:marquer/api/models/study/study_subject.dart';
import 'package:marquer/api/models/study/timer_mode.dart';

final sessionFormProvider =
    NotifierProvider<SessionFormNotifier, SessionFormState>(
  SessionFormNotifier.new,
);

class SessionFormState {
  final String name;
  final TimerMode mode;
  final StudySubject? subject;
  final int countDownMinutes;
  final bool customCountDown;
  final int workMinutes;
  final int shortBreakMinutes;
  final int longBreakMinutes;
  final int cycles;
  final bool loading;

  const SessionFormState({
    this.name = '',
    this.mode = TimerMode.countUp,
    this.subject,
    this.countDownMinutes = 30,
    this.customCountDown = false,
    this.workMinutes = 25,
    this.shortBreakMinutes = 5,
    this.longBreakMinutes = 15,
    this.cycles = 4,
    this.loading = false,
  });

  SessionFormState copyWith({
    String? name,
    TimerMode? mode,
    StudySubject? subject,
    int? countDownMinutes,
    bool? customCountDown,
    int? workMinutes,
    int? shortBreakMinutes,
    int? longBreakMinutes,
    int? cycles,
    bool? loading,
  }) => SessionFormState(
    name: name ?? this.name,
    mode: mode ?? this.mode,
    subject: subject ?? this.subject,
    countDownMinutes: countDownMinutes ?? this.countDownMinutes,
    customCountDown: customCountDown ?? this.customCountDown,
    workMinutes: workMinutes ?? this.workMinutes,
    shortBreakMinutes: shortBreakMinutes ?? this.shortBreakMinutes,
    longBreakMinutes: longBreakMinutes ?? this.longBreakMinutes,
    cycles: cycles ?? this.cycles,
    loading: loading ?? this.loading,
  );

  /// Validates the form and returns an error message, or null if valid.
  String? validate() {
    if (name.trim().isEmpty) return 'Session name is required';
    if (mode == TimerMode.countDown && countDownMinutes < 1) {
      return 'Duration must be at least 1 minute';
    }
    if (mode == TimerMode.pomodoro) {
      if (workMinutes < 1) return 'Work duration must be at least 1 minute';
      if (shortBreakMinutes < 1) return 'Short break must be at least 1 minute';
      if (longBreakMinutes < 1) return 'Long break must be at least 1 minute';
      if (cycles < 1) return 'Must have at least 1 cycle';
    }
    return null;
  }

  /// Builds the API request from current state.
  StoreStudySessionRequest toRequest() => StoreStudySessionRequest(
    name: name.trim(),
    studySubjectId: subject?.id,
    timerMode: mode,
    plannedDurationSeconds:
        mode == TimerMode.countDown ? countDownMinutes * 60 : null,
    pomodoroWorkMinutes: mode == TimerMode.pomodoro ? workMinutes : null,
    pomodoroShortBreakMinutes:
        mode == TimerMode.pomodoro ? shortBreakMinutes : null,
    pomodoroLongBreakMinutes:
        mode == TimerMode.pomodoro ? longBreakMinutes : null,
    pomodoroCycles: mode == TimerMode.pomodoro ? cycles : null,
  );
}

class SessionFormNotifier extends Notifier<SessionFormState> {
  @override
  SessionFormState build() => const SessionFormState();

  void setName(String name) => state = state.copyWith(name: name);
  void setMode(TimerMode mode) => state = state.copyWith(mode: mode);
  void setSubject(StudySubject? subject) =>
      state = state.copyWith(subject: subject);
  void setCountDownMinutes(int minutes) =>
      state = state.copyWith(countDownMinutes: minutes.clamp(1, 600));
  void setCustomCountDown(bool custom) =>
      state = state.copyWith(customCountDown: custom);
  void setWorkMinutes(int minutes) =>
      state = state.copyWith(workMinutes: minutes);
  void setShortBreakMinutes(int minutes) =>
      state = state.copyWith(shortBreakMinutes: minutes);
  void setLongBreakMinutes(int minutes) =>
      state = state.copyWith(longBreakMinutes: minutes);
  void setCycles(int cycles) => state = state.copyWith(cycles: cycles);
  void setLoading(bool loading) => state = state.copyWith(loading: loading);

  /// Loads defaults from study settings.
  void loadDefaults({
    int workMinutes = 25,
    int shortBreakMinutes = 5,
    int longBreakMinutes = 15,
    int cycles = 4,
  }) {
    state = state.copyWith(
      workMinutes: workMinutes,
      shortBreakMinutes: shortBreakMinutes,
      longBreakMinutes: longBreakMinutes,
      cycles: cycles,
    );
  }
}
