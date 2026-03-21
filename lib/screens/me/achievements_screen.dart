import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:marquer/providers/profile/achievements_provider.dart';

class AchievementsScreen extends ConsumerWidget {
  const AchievementsScreen({super.key});

  static const _iconMap = <String, IconData>{
    'note_add': Icons.note_add,
    'library_books': Icons.library_books,
    'auto_stories': Icons.auto_stories,
    'task_alt': Icons.task_alt,
    'checklist': Icons.checklist,
    'school': Icons.school,
    'local_fire_department': Icons.local_fire_department,
    'timer': Icons.timer,
    'alarm': Icons.alarm,
    'event_note': Icons.event_note,
    'person': Icons.person,
    'palette': Icons.palette,
  };

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final achievementsAsync = ref.watch(achievementsProvider);
    final theme = Theme.of(context);
    final cs = theme.colorScheme;

    return Scaffold(
      appBar: AppBar(title: const Text('Achievements')),
      body: achievementsAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Error: $e')),
        data: (achievements) => GridView.builder(
          padding: const EdgeInsets.all(16),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            childAspectRatio: 0.85,
          ),
          itemCount: achievements.length,
          itemBuilder: (context, index) {
            final a = achievements[index];
            final unlocked = a.unlocked;
            final icon = _iconMap[a.icon] ?? Icons.emoji_events;

            return Card(
              color: unlocked
                  ? cs.primaryContainer.withValues(alpha: 0.5)
                  : cs.surfaceContainer,
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      icon,
                      size: 36,
                      color: unlocked
                          ? cs.primary
                          : cs.onSurfaceVariant.withValues(alpha: 0.3),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      a.name,
                      style: theme.textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.w600,
                        color: unlocked
                            ? cs.onSurface
                            : cs.onSurfaceVariant.withValues(alpha: 0.5),
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      a.description,
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: unlocked
                            ? cs.onSurfaceVariant
                            : cs.onSurfaceVariant.withValues(alpha: 0.4),
                      ),
                      textAlign: TextAlign.center,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    if (unlocked && a.unlockedAt != null) ...[
                      const SizedBox(height: 4),
                      Text(
                        _formatDate(a.unlockedAt!),
                        style: theme.textTheme.labelSmall?.copyWith(
                          color: cs.primary,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  String _formatDate(String iso) {
    try {
      final d = DateTime.parse(iso);
      return '${d.day}/${d.month}/${d.year}';
    } catch (_) {
      return '';
    }
  }
}
