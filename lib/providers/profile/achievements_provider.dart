import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:marquer/api/models/profile/achievement.dart';
import 'package:marquer/api/services/profile_service.dart';

final achievementsProvider = AsyncNotifierProvider<AchievementsNotifier,
    List<Achievement>>(AchievementsNotifier.new);

class AchievementsNotifier extends AsyncNotifier<List<Achievement>> {
  final _service = ProfileService();

  @override
  Future<List<Achievement>> build() => _service.getAchievements();

  Future<void> refresh() async {
    state = const AsyncLoading();
    state = AsyncData(await _service.getAchievements());
  }
}
