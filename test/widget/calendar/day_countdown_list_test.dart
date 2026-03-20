import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:marquer/api/models/calendar/countdown.dart';
import 'package:marquer/components/calendar/day_countdown_list.dart';
import 'package:marquer/providers/calendar/countdowns_provider.dart';
import 'package:marquer/services/toast_service.dart';

import '../../helpers/test_setup.dart';

void main() {
  setUp(() async {
    await setUpTestEnvironment();
  });

  tearDown(() => GetIt.instance.reset());

  group('DayCountdownList', () {
    testWidgets('shows nothing when no countdowns match selected date', (tester) async {
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            countdownsProvider.overrideWith(() => _EmptyCountdownsNotifier()),
          ],
          child: MaterialApp(
            scaffoldMessengerKey: ToastService.messengerKey,
            home: const Scaffold(body: DayCountdownList()),
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('Countdowns'), findsNothing);
    });
  });
}

class _EmptyCountdownsNotifier extends CountdownsNotifier {
  @override
  Future<List<Countdown>> build() async => [];
}
