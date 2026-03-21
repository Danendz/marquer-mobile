import 'package:flutter_test/flutter_test.dart';
import 'package:marquer/api/models/profile/achievement.dart';
import 'package:marquer/api/models/profile/friendship.dart';
import 'package:marquer/api/models/profile/upload_url_response.dart';
import 'package:marquer/api/models/profile/upsert_profile_request.dart';
import 'package:marquer/api/models/profile/user_profile.dart';
import 'package:marquer/api/models/profile/user_settings.dart';

void main() {
  group('UserProfile', () {
    test('round-trip fromJson/toJson with all fields', () {
      final json = {
        'username': 'john_doe',
        'status': 'Working',
        'location': 'SF',
        'bio': 'Hello',
        'avatar_url': 'https://example.com/avatar.jpg',
        'cover_url': 'https://example.com/cover.jpg',
        'cover_type': 'custom',
      };
      final profile = UserProfile.fromJson(json);
      expect(profile.username, 'john_doe');
      expect(profile.avatarUrl, 'https://example.com/avatar.jpg');
      expect(profile.coverUrl, 'https://example.com/cover.jpg');
      expect(profile.coverType, 'custom');
      expect(UserProfile.fromJson(profile.toJson()), profile);
    });

    test('round-trip with null fields', () {
      final json = <String, dynamic>{
        'username': null,
        'status': null,
        'location': null,
        'bio': null,
        'avatar_url': null,
        'cover_url': null,
      };
      final profile = UserProfile.fromJson(json);
      expect(profile.username, isNull);
      expect(profile.avatarUrl, isNull);
      expect(UserProfile.fromJson(profile.toJson()), profile);
    });

    test('cover_type defaults to static', () {
      final profile = UserProfile.fromJson(<String, dynamic>{});
      expect(profile.coverType, 'static');
    });
  });

  group('Achievement', () {
    test('round-trip unlocked', () {
      final json = {
        'id': 1,
        'key': 'first_note',
        'name': 'First Note',
        'description': 'Create your first note',
        'icon': 'note_add',
        'category': 'milestone',
        'target_type': 'note_count',
        'target_value': 1,
        'unlocked': true,
        'unlocked_at': '2026-03-20T10:00:00.000000Z',
      };
      final a = Achievement.fromJson(json);
      expect(a.unlocked, true);
      expect(a.unlockedAt, '2026-03-20T10:00:00.000000Z');
      expect(a.targetType, 'note_count');
      expect(a.targetValue, 1);
      expect(Achievement.fromJson(a.toJson()), a);
    });

    test('round-trip locked with null unlockedAt', () {
      final json = {
        'id': 2,
        'key': 'note_collector',
        'name': 'Note Collector',
        'description': 'Create 10 notes',
        'icon': 'library_books',
        'category': 'milestone',
        'target_type': 'note_count',
        'target_value': 10,
        'unlocked': false,
        'unlocked_at': null,
      };
      final a = Achievement.fromJson(json);
      expect(a.unlocked, false);
      expect(a.unlockedAt, isNull);
      expect(Achievement.fromJson(a.toJson()), a);
    });
  });

  group('Friend', () {
    test('round-trip with all fields', () {
      final json = {
        'user_id': 2,
        'username': 'alice',
        'status': 'Online',
        'avatar_url': 'https://example.com/alice.jpg',
      };
      final f = Friend.fromJson(json);
      expect(f.userId, 2);
      expect(f.username, 'alice');
      expect(f.avatarUrl, 'https://example.com/alice.jpg');
      expect(Friend.fromJson(f.toJson()), f);
    });

    test('round-trip with nullable fields null', () {
      final json = {
        'user_id': 3,
        'username': null,
        'status': null,
        'avatar_url': null,
      };
      final f = Friend.fromJson(json);
      expect(f.userId, 3);
      expect(f.username, isNull);
      expect(f.avatarUrl, isNull);
      expect(Friend.fromJson(f.toJson()), f);
    });
  });

  group('FriendRequest', () {
    test('round-trip', () {
      final json = {
        'id': 10,
        'user_id': 4,
        'username': 'charlie',
        'avatar_url': 'https://example.com/charlie.jpg',
        'created_at': '2026-03-19T14:00:00.000000Z',
      };
      final r = FriendRequest.fromJson(json);
      expect(r.id, 10);
      expect(r.userId, 4);
      expect(r.createdAt, '2026-03-19T14:00:00.000000Z');
      expect(FriendRequest.fromJson(r.toJson()), r);
    });
  });

  group('UserSettings', () {
    test('round-trip with defaults', () {
      final settings = UserSettings.fromJson(<String, dynamic>{});
      expect(settings.theme, 'light');
      expect(settings.language, 'en');
      expect(settings.notificationsEnabled, true);
      expect(settings.notificationStudyReminders, true);
      expect(settings.notificationTaskReminders, true);
      expect(settings.labFeatures, isEmpty);
      expect(UserSettings.fromJson(settings.toJson()), settings);
    });

    test('round-trip with custom values', () {
      final json = {
        'theme': 'dark',
        'language': 'fr',
        'notifications_enabled': false,
        'notification_study_reminders': false,
        'notification_task_reminders': false,
        'lab_features': {'dark_mode': true},
      };
      final settings = UserSettings.fromJson(json);
      expect(settings.theme, 'dark');
      expect(settings.language, 'fr');
      expect(settings.notificationsEnabled, false);
      expect(settings.labFeatures, {'dark_mode': true});
      expect(UserSettings.fromJson(settings.toJson()), settings);
    });
  });

  group('UpsertProfileRequest', () {
    test('round-trip with all fields', () {
      final json = {
        'username': 'new_user',
        'status': 'Updated',
        'location': 'NY',
        'bio': 'Bio',
        'avatar_url': 'https://example.com/a.jpg',
        'cover_url': 'https://example.com/c.jpg',
        'cover_type': 'custom',
      };
      final req = UpsertProfileRequest.fromJson(json);
      expect(req.username, 'new_user');
      expect(req.coverType, 'custom');
      expect(UpsertProfileRequest.fromJson(req.toJson()), req);
    });

    test('round-trip with all nulls', () {
      final req = UpsertProfileRequest.fromJson(<String, dynamic>{});
      expect(req.username, isNull);
      expect(req.coverType, isNull);
      expect(UpsertProfileRequest.fromJson(req.toJson()), req);
    });
  });

  group('UploadUrlResponse', () {
    test('round-trip', () {
      final json = {
        'upload_url': 'https://s3.example.com/put',
        'public_url': 'https://cdn.example.com/img.jpg',
        'object_key': 'profiles/1/avatar/abc.jpg',
      };
      final resp = UploadUrlResponse.fromJson(json);
      expect(resp.uploadUrl, 'https://s3.example.com/put');
      expect(resp.publicUrl, 'https://cdn.example.com/img.jpg');
      expect(resp.objectKey, 'profiles/1/avatar/abc.jpg');
      expect(UploadUrlResponse.fromJson(resp.toJson()), resp);
    });
  });
}
