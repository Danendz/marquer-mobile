import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:marquer/providers/study/study_sessions_provider.dart';

class StudySessionsScreen extends ConsumerWidget {
  const StudySessionsScreen({super.key});

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
    final sessionsAsync = ref.watch(studySessionsProvider);
    return Scaffold(
      appBar: AppBar(title: const Text('Session History')),
      body: RefreshIndicator(
        onRefresh: () => ref.refresh(studySessionsProvider.future),
        child: sessionsAsync.when(
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (e, _) => Center(child: Text('Error: $e')),
          data:
              (sessions) =>
                  sessions.isEmpty
                      ? const Center(child: Text('No sessions yet'))
                      : ListView.builder(
                        physics: const AlwaysScrollableScrollPhysics(),
                        itemCount: sessions.length,
                        itemBuilder: (_, i) {
                        final s = sessions[i];
                        final date = DateTime.tryParse(s.startedAt);
                        return ListTile(
                          leading:
                              s.subject != null
                                  ? CircleAvatar(
                                    backgroundColor: Color(
                                      int.parse(
                                        s.subject!.color.replaceFirst(
                                          '#',
                                          'FF',
                                        ),
                                        radix: 16,
                                      ),
                                    ),
                                    radius: 12,
                                  )
                                  : const CircleAvatar(
                                    child: Icon(Icons.timer, size: 14),
                                  ),
                          title: Text(s.name),
                          subtitle: Text(s.subject?.name ?? s.timerMode.name),
                          trailing: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                _formatDuration(s.actualDurationSeconds),
                                style: Theme.of(
                                  context,
                                ).textTheme.bodyLarge?.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              if (date != null)
                                Text(
                                  '${date.day}/${date.month}/${date.year}',
                                  style:
                                      Theme.of(context).textTheme.bodySmall,
                                ),
                            ],
                          ),
                        );
                      },
                    ),
        ),
      ),
    );
  }
}
