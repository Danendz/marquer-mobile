import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mocktail/mocktail.dart';
import 'package:marquer/api/models/api_response.dart';
import 'package:marquer/api/models/notes/list_note.dart';
import 'package:marquer/api/models/notes/note.dart';
import 'package:marquer/api/models/notes/create_note_request.dart';
import 'package:marquer/providers/notes/notes_provider.dart';

import '../../../helpers/mock_api_service.dart';
import '../../../helpers/riverpod_helpers.dart';
import '../../../helpers/test_setup.dart';

void main() {
  late MockApiService mockApi;

  setUp(() async {
    final env = await setUpTestEnvironment();
    mockApi = env.api;
  });

  tearDown(() => GetIt.instance.reset());

  void stubGetNotes(List<Map<String, dynamic>> notes) {
    when(
      () => mockApi.get<List<ListNote>>(
        '/notes',
        fromJsonT: any(named: 'fromJsonT'),
      ),
    ).thenAnswer((inv) async {
      final fromJsonT =
          inv.namedArguments[#fromJsonT] as List<ListNote> Function(Object?);
      return ApiResponse<List<ListNote>>(
        status: 200, success: true, message: 'OK',
        data: fromJsonT(notes),
      );
    });
  }

  group('notesProvider', () {
    test('build fetches notes from service', () async {
      stubGetNotes([
        {'id': 1, 'title': 'Note 1', 'created_at': 'c', 'updated_at': 'u'},
        {'id': 2, 'title': 'Note 2', 'created_at': 'c', 'updated_at': 'u'},
      ]);

      final container = createTestContainer();
      final notes = await container.read(notesProvider.future);

      expect(notes, hasLength(2));
      expect(notes[0].title, 'Note 1');
    });

    test('create adds note to list', () async {
      stubGetNotes([]);

      when(
        () => mockApi.post<Note>(
          '/notes',
          body: any(named: 'body'),
          fromJsonT: any(named: 'fromJsonT'),
        ),
      ).thenAnswer((inv) async {
        final fromJsonT =
            inv.namedArguments[#fromJsonT] as Note Function(Object?);
        return ApiResponse<Note>(
          status: 201, success: true, message: 'Created',
          data: fromJsonT({
            'id': 1, 'title': 'new note', 'content': '[]',
            'created_at': 'c', 'updated_at': 'u',
          }),
        );
      });

      final container = createTestContainer();
      await container.read(notesProvider.future);
      expect(container.read(notesProvider).value, isEmpty);

      await container.read(notesProvider.notifier).create(
        CreateNoteRequest(title: 'new note', content: '[]'),
      );

      expect(container.read(notesProvider).value, hasLength(1));
      expect(container.read(notesProvider).value![0].title, 'new note');
    });

    test('delete removes note from list', () async {
      stubGetNotes([
        {'id': 1, 'title': 'Note 1', 'created_at': 'c', 'updated_at': 'u'},
      ]);

      when(() => mockApi.delete('/notes/1')).thenAnswer(
        (inv) async => ApiResponse<Null>(
          status: 200, success: true, message: 'Deleted', data: null,
        ),
      );

      final container = createTestContainer();
      await container.read(notesProvider.future);
      expect(container.read(notesProvider).value, hasLength(1));

      await container.read(notesProvider.notifier).delete(1);

      expect(container.read(notesProvider).value, isEmpty);
    });
  });
}
