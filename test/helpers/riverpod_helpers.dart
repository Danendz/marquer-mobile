import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/misc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:marquer/services/toast_service.dart';

/// Creates a [ProviderContainer] with optional overrides and auto-disposes
/// it at the end of the test.
ProviderContainer createTestContainer({
  List<Override> overrides = const [],
}) {
  final container = ProviderContainer(overrides: overrides);
  addTearDown(container.dispose);
  return container;
}

/// Pumps a widget wrapped in [ProviderScope] and [MaterialApp] with the
/// [ToastService.messengerKey] wired up so toast calls are safe.
Future<void> pumpWithProviders(
  WidgetTester tester,
  Widget child, {
  List<Override> overrides = const [],
}) async {
  await tester.pumpWidget(
    ProviderScope(
      overrides: overrides,
      child: MaterialApp(
        scaffoldMessengerKey: ToastService.messengerKey,
        home: child,
      ),
    ),
  );
}
