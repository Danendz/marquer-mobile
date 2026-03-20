import 'dart:math';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:marquer/api/models/calendar/countdown.dart';
import 'package:marquer/api/models/calendar/create_countdown_request.dart';
import 'package:marquer/api/models/calendar/update_countdown_request.dart';
import 'package:marquer/api/services/calendar_service.dart';
import 'package:marquer/providers/optimistic_mutation.dart';

final countdownsProvider = AsyncNotifierProvider<CountdownsNotifier, List<Countdown>>(
  CountdownsNotifier.new,
);

class CountdownsNotifier extends AsyncNotifier<List<Countdown>>
    with OptimisticMutation {
  final _service = CalendarService();

  @override
  Future<List<Countdown>> build() async {
    return _service.getCountdowns();
  }

  Future<String> _randomBgImage() async {
    final manifest = await AssetManifest.loadFromAssetBundle(rootBundle);
    final assets = manifest.listAssets().where((k) => k.startsWith('assets/timer_bg/')).toList();
    if (assets.isEmpty) return 'default.jpg';
    return assets[Random().nextInt(assets.length)].split('/').last;
  }

  Future<void> add(String name, String targetDate) async {
    final current = currentValue;
    if (current == null) return;

    await mutate(
      action: () async => _service.createCountdown(
        CreateCountdownRequest(name: name, targetDate: targetDate, bgImage: await _randomBgImage()),
      ),
      errorMessage: 'Unable to add countdown! Try again later',
      onSuccess: (latest, created) => [...latest, created],
    );
  }

  Future<void> edit(Countdown countdown, UpdateCountdownRequest request) async {
    final current = currentValue;
    if (current == null) return;

    final optimistic = countdown.copyWith(
      name: request.name ?? countdown.name,
      targetDate: request.targetDate ?? countdown.targetDate,
      isPinned: request.isPinned ?? countdown.isPinned,
      bgImage: request.bgImage ?? countdown.bgImage,
    );
    state = AsyncData([
      for (final c in current) if (c.id == countdown.id) optimistic else c,
    ]);

    await mutate(
      action: () => _service.updateCountdown(countdown.id.toString(), request),
      errorMessage: 'Unable to update countdown! Try again later',
      rollback: () => [
        for (final c in state.asData?.value ?? current)
          if (c.id == countdown.id) countdown else c,
      ],
      onSuccess: (latest, updated) => [
        for (final c in latest) if (c.id == countdown.id) updated else c,
      ],
    );
  }

  Future<void> delete(Countdown countdown) async {
    final current = currentValue;
    if (current == null) return;

    state = AsyncData([for (final c in current) if (c.id != countdown.id) c]);

    await mutate(
      action: () => _service.deleteCountdown(countdown.id.toString()),
      errorMessage: 'Unable to delete countdown! Try again later',
      rollback: () {
        final latest = state.asData?.value ?? current;
        return latest.any((c) => c.id == countdown.id) ? latest : [countdown, ...latest];
      },
    );
  }

  Future<void> togglePin(Countdown countdown) async {
    final current = currentValue;
    if (current == null) return;

    final newPinned = !countdown.isPinned;
    state = AsyncData([
      for (final c in current)
        if (c.id == countdown.id)
          c.copyWith(isPinned: newPinned)
        else if (newPinned && c.isPinned)
          c.copyWith(isPinned: false)
        else
          c,
    ]);

    await mutate(
      action: () => _service.updateCountdown(
        countdown.id.toString(),
        UpdateCountdownRequest(isPinned: newPinned),
      ),
      errorMessage: 'Unable to update countdown! Try again later',
      rollback: () => [
        for (final c in state.asData?.value ?? current)
          if (c.id == countdown.id) countdown else c,
      ],
      onSuccess: (latest, updated) => [
        for (final c in latest) if (c.id == countdown.id) updated else c,
      ],
    );
  }
}
