import 'package:flutter_test/flutter_test.dart';
import 'package:marquer/api/models/study/study_session.dart';
import 'package:marquer/api/models/study/study_session_status.dart';
import 'package:marquer/api/models/study/study_subject.dart';
import 'package:marquer/api/models/study/study_stats.dart';
import 'package:marquer/api/models/study/timer_mode.dart';
import 'package:marquer/api/models/study/user_study_settings.dart';

void main() {
  group('StudySubject', () {
    test('round-trip', () {
      final json = {
        'id': 1, 'name': 'Math', 'color': '#4285F4',
        'is_system': false, 'created_at': '2026-01-01',
      };
      final obj = StudySubject.fromJson(json);
      expect(obj.isSystem, false);
      expect(StudySubject.fromJson(obj.toJson()), obj);
    });
  });

  group('StudySession', () {
    test('round-trip with all fields', () {
      final json = {
        'id': 1, 'user_id': 10, 'study_subject_id': 2,
        'name': 'Study', 'timer_mode': 'pomodoro', 'status': 'completed',
        'planned_duration_seconds': 1500, 'actual_duration_seconds': 1200,
        'started_at': '2026-01-01T10:00:00Z', 'ended_at': '2026-01-01T10:20:00Z',
        'pomodoro_work_minutes': 25, 'pomodoro_short_break_minutes': 5,
        'pomodoro_long_break_minutes': 15, 'pomodoro_cycles': 4,
        'pomodoro_completed_cycles': 2, 'subject': null,
        'created_at': 'c', 'updated_at': 'u',
      };
      final session = StudySession.fromJson(json);
      expect(session.timerMode, TimerMode.pomodoro);
      expect(session.status, StudySessionStatus.completed);
      expect(session.actualDurationSeconds, 1200);
      expect(StudySession.fromJson(session.toJson()), session);
    });

    test('defaults actualDurationSeconds to 0 when null', () {
      final json = {
        'id': 1, 'user_id': 1, 'name': 'S',
        'timer_mode': 'count_up', 'status': 'active',
        'actual_duration_seconds': null,
        'started_at': 's', 'created_at': 'c', 'updated_at': 'u',
      };
      final session = StudySession.fromJson(json);
      expect(session.actualDurationSeconds, 0);
    });

    test('round-trip with nested subject', () {
      final json = {
        'id': 1, 'user_id': 1, 'name': 'S',
        'timer_mode': 'count_up', 'status': 'active',
        'actual_duration_seconds': 0, 'started_at': 's',
        'pomodoro_completed_cycles': 0,
        'subject': {'id': 1, 'name': 'Math', 'color': '#F', 'is_system': false, 'created_at': 'c'},
        'created_at': 'c', 'updated_at': 'u',
      };
      final session = StudySession.fromJson(json);
      expect(session.subject?.name, 'Math');
      expect(StudySession.fromJson(session.toJson()), session);
    });
  });

  group('StudyStats', () {
    test('round-trip', () {
      final json = {
        'today_total_seconds': 3600,
        'sessions': [
          {
            'id': 1, 'user_id': 1, 'name': 'S',
            'timer_mode': 'count_up', 'status': 'completed',
            'actual_duration_seconds': 3600, 'started_at': 's',
            'pomodoro_completed_cycles': 0,
            'created_at': 'c', 'updated_at': 'u',
          },
        ],
      };
      final stats = StudyStats.fromJson(json);
      expect(stats.todayTotalSeconds, 3600);
      expect(stats.sessions, hasLength(1));
    });
  });

  group('UserStudySettings', () {
    test('round-trip with defaults', () {
      final obj = UserStudySettings();
      expect(obj.defaultWorkMinutes, 25);
      expect(obj.defaultCycles, 4);
      expect(UserStudySettings.fromJson(obj.toJson()), obj);
    });

    test('fromJson with missing keys uses defaults', () {
      final obj = UserStudySettings.fromJson({});
      expect(obj.defaultWorkMinutes, 25);
      expect(obj.defaultShortBreakMinutes, 5);
    });
  });
}
