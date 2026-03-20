import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import '../helpers/riverpod_helpers.dart';

/// A trivial provider used only for this example test.
final _greetingProvider = Provider<String>((ref) => 'Hello, Marquer!');

/// A minimal ConsumerWidget that reads [_greetingProvider].
class _GreetingWidget extends ConsumerWidget {
  const _GreetingWidget();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final greeting = ref.watch(_greetingProvider);
    return Text(greeting);
  }
}

void main() {
  group('Example widget test', () {
    testWidgets('renders text from a Riverpod provider', (tester) async {
      await pumpWithProviders(tester, const _GreetingWidget());
      await tester.pumpAndSettle();

      expect(find.text('Hello, Marquer!'), findsOneWidget);
    });

    testWidgets('renders overridden provider value', (tester) async {
      await pumpWithProviders(
        tester,
        const _GreetingWidget(),
        overrides: [
          _greetingProvider.overrideWithValue('Testing override'),
        ],
      );
      await tester.pumpAndSettle();

      expect(find.text('Testing override'), findsOneWidget);
      expect(find.text('Hello, Marquer!'), findsNothing);
    });
  });
}
