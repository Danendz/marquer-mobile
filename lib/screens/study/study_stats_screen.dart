import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:marquer/api/models/study/study_session.dart';
import 'package:marquer/providers/study/study_stats_provider.dart';

class StudyStatsScreen extends ConsumerWidget {
  const StudyStatsScreen({super.key});

  String _formatDuration(int seconds) {
    final h = seconds ~/ 3600;
    final m = (seconds % 3600) ~/ 60;
    final s = seconds % 60;
    if (h > 0) return '${h}h ${m}m';
    if (m > 0) return '${m}m ${s}s';
    return '${s}s';
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final statsAsync = ref.watch(studyStatsProvider);
    return Scaffold(
      appBar: AppBar(title: const Text('Study Stats')),
      body: RefreshIndicator(
        onRefresh: () => ref.refresh(studyStatsProvider.future),
        child: statsAsync.when(
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (e, _) => Center(child: Text('Error: $e')),
          data:
              (stats) => Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Card(
                      color: Theme.of(context).colorScheme.primaryContainer,
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Today's total",
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                            Text(
                              _formatDuration(stats.todayTotalSeconds),
                              style: Theme.of(
                                context,
                              ).textTheme.headlineSmall?.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                      physics: const AlwaysScrollableScrollPhysics(),
                      itemCount: stats.sessions.length,
                      itemBuilder:
                          (_, i) => _SessionTile(
                            session: stats.sessions[i],
                            formatDuration: _formatDuration,
                          ),
                    ),
                  ),
                ],
              ),
        ),
      ),
    );
  }
}

class _SessionTile extends StatelessWidget {
  final StudySession session;
  final String Function(int) formatDuration;

  const _SessionTile({required this.session, required this.formatDuration});

  @override
  Widget build(BuildContext context) {
    final date = DateTime.tryParse(session.startedAt);
    return ListTile(
      leading:
          session.subject != null
              ? CircleAvatar(
                backgroundColor: Color(
                  int.parse(
                    session.subject!.color.replaceFirst('#', 'FF'),
                    radix: 16,
                  ),
                ),
                radius: 8,
              )
              : const CircleAvatar(child: Icon(Icons.timer, size: 12)),
      title: Text(session.name),
      subtitle: Text(session.subject?.name ?? session.timerMode.name),
      trailing: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            formatDuration(session.actualDurationSeconds),
            style: Theme.of(
              context,
            ).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.bold),
          ),
          if (date != null)
            Text(
              '${date.day}/${date.month}',
              style: Theme.of(context).textTheme.bodySmall,
            ),
        ],
      ),
    );
  }
}
