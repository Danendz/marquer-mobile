import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:marquer/services/toast_service.dart';

/// Mixin for [AsyncNotifier] providers that perform optimistic mutations.
///
/// Centralises the try/catch, `ref.mounted` guard, error logging, and toast so
/// that changing error handling is a single-file edit instead of touching every
/// provider.
mixin OptimisticMutation<T> on AsyncNotifier<T> {
  /// Shorthand for the current loaded value, or `null` if the provider hasn't
  /// finished building yet.
  T? get currentValue => state.asData?.value;

  /// Execute [action] with standard error handling.
  ///
  /// * **[action]** — the async work (usually an API call).
  /// * **[errorMessage]** — shown in a toast on failure.
  /// * **[rollback]** — if provided, called on error to compute the state to
  ///   restore. Receives the *latest* state so concurrent mutations are safe.
  /// * **[onSuccess]** — if provided, called with the latest state and the
  ///   action result to produce the new state (e.g. replacing an optimistic
  ///   placeholder with the server response).
  Future<R?> mutate<R>({
    required Future<R> Function() action,
    required String errorMessage,
    T Function()? rollback,
    T Function(T current, R result)? onSuccess,
  }) async {
    try {
      final result = await action();
      if (!ref.mounted) return null;
      if (onSuccess != null) {
        state = AsyncData(onSuccess(state.asData!.value, result));
      }
      return result;
    } catch (e) {
      if (!ref.mounted) return null;
      if (rollback != null) state = AsyncData(rollback());
      debugPrint(e.toString());
      ToastService.showError(errorMessage);
      return null;
    }
  }
}
