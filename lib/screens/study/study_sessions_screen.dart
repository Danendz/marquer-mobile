import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:marquer/components/study/session_card.dart';
import 'package:marquer/providers/study/study_sessions_provider.dart';

class StudySessionsScreen extends ConsumerWidget {
  const StudySessionsScreen({super.key});

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
          data: (sessions) => sessions.isEmpty
              ? const Center(child: Text('No sessions yet'))
              : ListView.separated(
                  physics: const AlwaysScrollableScrollPhysics(),
                  padding: const EdgeInsets.all(16),
                  itemCount: sessions.length,
                  separatorBuilder: (_, _) => const SizedBox(height: 12),
                  itemBuilder: (_, i) => SessionCard(session: sessions[i]),
                ),
        ),
      ),
    );
  }
}
