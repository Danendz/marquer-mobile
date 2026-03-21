import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:marquer/providers/profile/laboratory_provider.dart';
import 'package:marquer/screens/me/laboratory_screen.dart';

import '../../helpers/mock_router.dart';
import '../../helpers/test_setup.dart';

class _LoadedLabNotifier extends LaboratoryNotifier {
  @override
  Future<Map<String, dynamic>> build() async =>
      {'dark_mode': true, 'ai_assist': false};
}

class _EmptyLabNotifier extends LaboratoryNotifier {
  @override
  Future<Map<String, dynamic>> build() async => {};
}

void main() {
  setUp(() async {
    await setUpTestEnvironment();
  });

  tearDown(() => GetIt.instance.reset());

  group('LaboratoryScreen', () {
    testWidgets('renders Laboratory app bar', (tester) async {
      await pumpWithRouter(tester, const LaboratoryScreen(), overrides: [
        laboratoryProvider.overrideWith(() => _EmptyLabNotifier()),
      ]);
      await tester.pumpAndSettle();

      expect(find.text('Laboratory'), findsOneWidget);
    });

    testWidgets('empty state shows message', (tester) async {
      await pumpWithRouter(tester, const LaboratoryScreen(), overrides: [
        laboratoryProvider.overrideWith(() => _EmptyLabNotifier()),
      ]);
      await tester.pumpAndSettle();

      expect(find.text('No experiments yet'), findsOneWidget);
      expect(find.text('Experimental features will appear here'),
          findsOneWidget);
    });

    testWidgets('feature toggles render with readable names', (tester) async {
      await pumpWithRouter(tester, const LaboratoryScreen(), overrides: [
        laboratoryProvider.overrideWith(() => _LoadedLabNotifier()),
      ]);
      await tester.pumpAndSettle();

      // Underscores replaced with spaces
      expect(find.text('dark mode'), findsOneWidget);
      expect(find.text('ai assist'), findsOneWidget);
    });

    testWidgets('switch values match feature state', (tester) async {
      await pumpWithRouter(tester, const LaboratoryScreen(), overrides: [
        laboratoryProvider.overrideWith(() => _LoadedLabNotifier()),
      ]);
      await tester.pumpAndSettle();

      final switches = tester.widgetList<SwitchListTile>(
        find.byType(SwitchListTile),
      );
      expect(switches.first.value, true); // dark_mode
      expect(switches.last.value, false); // ai_assist
    });
  });
}
