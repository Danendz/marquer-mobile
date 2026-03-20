import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:marquer/api/models/api_response.dart';
import 'package:marquer/api/models/tasks/folders/task_folder.dart';
import 'package:marquer/components/tasks/task_filter_dropdown.dart';
import 'package:marquer/providers/tasks/task_filter.dart';
import 'package:marquer/providers/tasks/task_filter_provider.dart';
import 'package:marquer/services/toast_service.dart';
import 'package:mocktail/mocktail.dart';

import '../../helpers/mock_api_service.dart';
import '../../helpers/test_setup.dart';

void main() {
  late MockApiService mockApi;

  setUp(() async {
    final env = await setUpTestEnvironment();
    mockApi = env.api;
  });

  tearDown(() => GetIt.instance.reset());

  void stubEmptyFolders() {
    when(
      () => mockApi.get<List<TaskFolder>>(
        '/task-folders',
        query: any(named: 'query'),
        fromJsonT: any(named: 'fromJsonT'),
      ),
    ).thenAnswer((inv) async {
      final fromJsonT =
          inv.namedArguments[#fromJsonT] as List<TaskFolder> Function(Object?);
      return ApiResponse<List<TaskFolder>>(
        status: 200,
        success: true,
        message: 'OK',
        data: fromJsonT([]),
      );
    });
  }

  group('TaskFilterDropdown (showTaskFilterDropdown)', () {
    testWidgets('shows All To-Do and Recently Deleted options', (tester) async {
      stubEmptyFolders();

      await tester.pumpWidget(
        ProviderScope(
          child: MaterialApp(
            scaffoldMessengerKey: ToastService.messengerKey,
            home: Builder(
              builder: (context) => Scaffold(
                body: ElevatedButton(
                  onPressed: () => showTaskFilterDropdown(context),
                  child: const Text('Open Filter'),
                ),
              ),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();

      // Open filter dropdown
      await tester.tap(find.text('Open Filter'));
      await tester.pumpAndSettle();

      expect(find.text('All To-Do'), findsOneWidget);
      expect(find.text('Recently Deleted'), findsOneWidget);
      expect(find.text('Folders'), findsOneWidget);
    });

    testWidgets('tapping All To-Do sets filter and closes sheet', (tester) async {
      stubEmptyFolders();

      late ProviderContainer container;
      await tester.pumpWidget(
        ProviderScope(
          child: Builder(
            builder: (context) {
              return MaterialApp(
                scaffoldMessengerKey: ToastService.messengerKey,
                home: Consumer(
                  builder: (context, ref, _) {
                    container = ProviderScope.containerOf(context);
                    // Start with a different filter to verify it changes
                    return Scaffold(
                      body: ElevatedButton(
                        onPressed: () => showTaskFilterDropdown(context),
                        child: const Text('Open Filter'),
                      ),
                    );
                  },
                ),
              );
            },
          ),
        ),
      );
      await tester.pumpAndSettle();

      // Set a non-default filter first
      container.read(taskFilterProvider.notifier).set(RecentlyDeletedFilter());

      await tester.tap(find.text('Open Filter'));
      await tester.pumpAndSettle();

      await tester.tap(find.text('All To-Do'));
      await tester.pumpAndSettle();

      expect(container.read(taskFilterProvider), isA<AllTasksFilter>());
    });
  });
}
