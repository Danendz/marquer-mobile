import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:marquer/api/services/profile_service.dart';
import 'package:marquer/providers/optimistic_mutation.dart';

final laboratoryProvider = AsyncNotifierProvider<LaboratoryNotifier,
    Map<String, dynamic>>(LaboratoryNotifier.new);

class LaboratoryNotifier extends AsyncNotifier<Map<String, dynamic>>
    with OptimisticMutation {
  final _service = ProfileService();

  @override
  Future<Map<String, dynamic>> build() async {
    final settings = await _service.getSettings();
    return settings.labFeatures;
  }

  Future<void> toggle(String feature, bool enabled) async {
    final current = currentValue;
    if (current == null) return;

    state = AsyncData({...current, feature: enabled});

    await mutate(
      action: () async {
        final settings = await _service.upsertSettings({
          'lab_features': {...current, feature: enabled},
        });
        return settings.labFeatures;
      },
      errorMessage: 'Unable to toggle feature',
      rollback: () => current,
      onSuccess: (_, updated) => updated,
    );
  }
}
