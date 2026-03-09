import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:marquer/api/models/calendar/countdown.dart';
import 'package:marquer/api/models/calendar/create_countdown_request.dart';
import 'package:marquer/api/models/calendar/update_countdown_request.dart';
import 'package:marquer/api/services/calendar_service.dart';
import 'package:marquer/services/toast_service.dart';

final countdownsProvider = AsyncNotifierProvider<CountdownsNotifier, List<Countdown>>(
  CountdownsNotifier.new,
);

class CountdownsNotifier extends AsyncNotifier<List<Countdown>> {
  final _service = CalendarService();

  @override
  Future<List<Countdown>> build() async {
    return _service.getCountdowns();
  }

  Future<void> add(String name, String targetDate) async {
    final current = state.asData?.value;
    if (current == null) return;

    try {
      final created = await _service.createCountdown(
        CreateCountdownRequest(name: name, targetDate: targetDate),
      );
      if (!ref.mounted) return;
      state = AsyncData([...current, created]);
    } catch (e) {
      if (!ref.mounted) return;
      debugPrint(e.toString());
      ToastService.showError('Unable to add countdown! Try again later');
    }
  }

  Future<void> edit(Countdown countdown, UpdateCountdownRequest request) async {
    final current = state.asData?.value;
    if (current == null) return;

    final optimistic = countdown.copyWith(
      name: request.name,
      targetDate: request.targetDate,
      isPinned: request.isPinned,
      bgImage: request.bgImage,
    );
    state = AsyncData([
      for (final c in current) if (c.id == countdown.id) optimistic else c,
    ]);

    try {
      final updated = await _service.updateCountdown(
        countdown.id.toString(),
        request,
      );
      if (!ref.mounted) return;
      state = AsyncData([
        for (final c in state.asData!.value) if (c.id == countdown.id) updated else c,
      ]);
    } catch (e) {
      if (!ref.mounted) return;
      state = AsyncData([
        for (final c in state.asData?.value ?? current)
          if (c.id == countdown.id) countdown else c,
      ]);
      debugPrint(e.toString());
      ToastService.showError('Unable to update countdown! Try again later');
    }
  }

  Future<void> delete(Countdown countdown) async {
    final current = state.asData?.value;
    if (current == null) return;

    state = AsyncData([for (final c in current) if (c.id != countdown.id) c]);

    try {
      await _service.deleteCountdown(countdown.id.toString());
    } catch (e) {
      if (!ref.mounted) return;
      final latest = state.asData?.value ?? current;
      state = AsyncData(latest.any((c) => c.id == countdown.id) ? latest : [countdown, ...latest]);
      debugPrint(e.toString());
      ToastService.showError('Unable to delete countdown! Try again later');
    }
  }

  Future<void> togglePin(Countdown countdown) async {
    final current = state.asData?.value;
    if (current == null) return;

    final newPinned = !countdown.isPinned;

    // Optimistically update local state: unpin others if pinning
    state = AsyncData([
      for (final c in current)
        if (c.id == countdown.id)
          c.copyWith(isPinned: newPinned)
        else if (newPinned && c.isPinned)
          c.copyWith(isPinned: false)
        else
          c,
    ]);

    try {
      final updated = await _service.updateCountdown(
        countdown.id.toString(),
        UpdateCountdownRequest(isPinned: newPinned),
      );
      if (!ref.mounted) return;
      state = AsyncData([
        for (final c in state.asData!.value) if (c.id == countdown.id) updated else c,
      ]);
    } catch (e) {
      if (!ref.mounted) return;
      state = AsyncData([
        for (final c in state.asData?.value ?? current)
          if (c.id == countdown.id) countdown else c,
      ]);
      debugPrint(e.toString());
      ToastService.showError('Unable to update countdown! Try again later');
    }
  }
}
