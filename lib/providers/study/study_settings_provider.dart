import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:marquer/api/models/study/user_study_settings.dart';
import 'package:marquer/api/services/study_service.dart';
import 'package:marquer/services/toast_service.dart';

final studySettingsProvider =
    AsyncNotifierProvider<StudySettingsNotifier, UserStudySettings>(
      StudySettingsNotifier.new,
    );

class StudySettingsNotifier extends AsyncNotifier<UserStudySettings> {
  final _service = StudyService();

  @override
  Future<UserStudySettings> build() => _service.getSettings();

  Future<void> save(UserStudySettings settings) async {
    final prev = state.asData?.value;
    state = AsyncData(settings);
    try {
      final updated = await _service.upsertSettings(settings);
      if (!ref.mounted) return;
      state = AsyncData(updated);
    } catch (e) {
      if (!ref.mounted) return;
      if (prev != null) state = AsyncData(prev);
      debugPrint(e.toString());
      ToastService.showError('Unable to save settings');
    }
  }
}
