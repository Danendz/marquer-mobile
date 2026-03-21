/// Profile fixture data for tests.
library;

const Map<String, dynamic> profileJson1 = {
  'username': 'john_doe',
  'status': 'Working on something cool',
  'location': 'San Francisco',
  'bio': 'Software developer and coffee enthusiast',
  'avatar_url': 'https://example.com/avatar.jpg',
  'cover_url': 'https://example.com/cover.jpg',
  'cover_type': 'custom',
};

const Map<String, dynamic> profileJson2 = {
  'username': null,
  'status': null,
  'location': null,
  'bio': null,
  'avatar_url': null,
  'cover_url': null,
  'cover_type': 'static',
};

const Map<String, dynamic> achievementUnlockedJson = {
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

const Map<String, dynamic> achievementLockedJson = {
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

const Map<String, dynamic> friendJson1 = {
  'user_id': 2,
  'username': 'alice',
  'status': 'Online',
  'avatar_url': 'https://example.com/alice.jpg',
};

const Map<String, dynamic> friendJson2 = {
  'user_id': 3,
  'username': 'bob',
  'status': null,
  'avatar_url': null,
};

const Map<String, dynamic> friendRequestJson1 = {
  'id': 10,
  'user_id': 4,
  'username': 'charlie',
  'avatar_url': 'https://example.com/charlie.jpg',
  'created_at': '2026-03-19T14:00:00.000000Z',
};

const Map<String, dynamic> friendRequestJson2 = {
  'id': 11,
  'user_id': 5,
  'username': 'diana',
  'avatar_url': null,
  'created_at': '2026-03-20T08:00:00.000000Z',
};

const Map<String, dynamic> settingsDefaultJson = {
  'theme': 'light',
  'language': 'en',
  'notifications_enabled': true,
  'notification_study_reminders': true,
  'notification_task_reminders': true,
  'lab_features': <String, dynamic>{},
};

const Map<String, dynamic> settingsCustomJson = {
  'theme': 'dark',
  'language': 'fr',
  'notifications_enabled': false,
  'notification_study_reminders': false,
  'notification_task_reminders': false,
  'lab_features': {'dark_mode': true, 'ai_assist': false},
};

const Map<String, dynamic> uploadUrlJson = {
  'upload_url': 'https://s3.example.com/presigned-put-url',
  'public_url': 'https://cdn.example.com/profiles/1/avatar/abc.jpg',
  'object_key': 'profiles/1/avatar/abc.jpg',
};

const Map<String, dynamic> upsertProfileRequestJson = {
  'username': 'new_user',
  'status': 'Updated status',
  'location': 'New York',
  'bio': 'Updated bio',
  'avatar_url': 'https://example.com/new-avatar.jpg',
  'cover_url': 'https://example.com/new-cover.jpg',
  'cover_type': 'custom',
};

/// A typical successful API response wrapping a single profile.
Map<String, dynamic> singleProfileResponse({
  Map<String, dynamic> profile = profileJson1,
}) =>
    {
      'status': 200,
      'success': true,
      'message': 'Success',
      'data': profile,
    };

/// A typical successful API response wrapping a list of friends.
Map<String, dynamic> friendsListResponse({
  List<Map<String, dynamic>> friends = const [friendJson1, friendJson2],
}) =>
    {
      'status': 200,
      'success': true,
      'message': 'Success',
      'data': friends,
    };

/// A typical successful API response wrapping a list of friend requests.
Map<String, dynamic> friendRequestsListResponse({
  List<Map<String, dynamic>> requests = const [
    friendRequestJson1,
    friendRequestJson2,
  ],
}) =>
    {
      'status': 200,
      'success': true,
      'message': 'Success',
      'data': requests,
    };

/// A typical successful API response wrapping achievements.
Map<String, dynamic> achievementsListResponse({
  List<Map<String, dynamic>> achievements = const [
    achievementUnlockedJson,
    achievementLockedJson,
  ],
}) =>
    {
      'status': 200,
      'success': true,
      'message': 'Success',
      'data': achievements,
    };

/// A typical successful API response wrapping settings.
Map<String, dynamic> settingsResponse({
  Map<String, dynamic> settings = settingsDefaultJson,
}) =>
    {
      'status': 200,
      'success': true,
      'message': 'Success',
      'data': settings,
    };

/// A typical successful API response wrapping upload URL.
Map<String, dynamic> uploadUrlResponse({
  Map<String, dynamic> data = uploadUrlJson,
}) =>
    {
      'status': 200,
      'success': true,
      'message': 'Success',
      'data': data,
    };
