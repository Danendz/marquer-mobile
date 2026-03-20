import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/misc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:marquer/services/toast_service.dart';
import 'package:mocktail/mocktail.dart';

class MockGoRouter extends Mock implements GoRouter {}

/// Pumps a widget wrapped in [InheritedGoRouter] + [ProviderScope] + [MaterialApp]
/// so that `context.go()`, `context.push()`, etc. resolve to the mock.
///
/// Returns the [MockGoRouter] so callers can verify navigation calls.
Future<MockGoRouter> pumpWithRouter(
  WidgetTester tester,
  Widget child, {
  List<Override> overrides = const [],
}) async {
  final mockRouter = MockGoRouter();

  when(() => mockRouter.go(any(), extra: any(named: 'extra')))
      .thenReturn(null);
  when(() => mockRouter.push(any(), extra: any(named: 'extra')))
      .thenAnswer((_) async => null);
  when(() => mockRouter.pop(any())).thenReturn(null);

  await tester.pumpWidget(
    ProviderScope(
      overrides: overrides,
      child: MaterialApp(
        scaffoldMessengerKey: ToastService.messengerKey,
        home: InheritedGoRouter(
          goRouter: mockRouter,
          child: child,
        ),
      ),
    ),
  );

  return mockRouter;
}
