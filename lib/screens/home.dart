import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:marquer/api/services/study_service.dart';
import 'package:marquer/providers/study/study_stats_provider.dart';
import 'package:marquer/screens/study/create_session_sheet.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _checkActiveSession());
  }

  Future<void> _checkActiveSession() async {
    try {
      final sessions = await StudyService().getSessions(status: 'active');
      if (!mounted) return;
      if (sessions.isNotEmpty) {
        final session = sessions.first;
        showDialog(
          context: context,
          barrierDismissible: false,
          builder:
              (ctx) => AlertDialog(
                title: const Text('Active Session'),
                content: Text(
                  'You have an active study session: "${session.name}". Resume it?',
                ),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(ctx).pop();
                      // Cancel on server
                      StudyService().cancelSession(session.id);
                    },
                    child: const Text('Cancel Session'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(ctx).pop();
                      context.push('/study/active', extra: session);
                    },
                    child: const Text('Resume'),
                  ),
                ],
              ),
        );
      }
    } catch (_) {}
  }

  String _formatDuration(int seconds) {
    if (seconds < 60) return '${seconds}s';
    final h = seconds ~/ 3600;
    final m = (seconds % 3600) ~/ 60;
    if (h > 0) return '${h}h ${m}m';
    return '${m}m';
  }

  @override
  Widget build(BuildContext context) {
    final statsAsync = ref.watch(studyStatsProvider);
    final todaySeconds = statsAsync.asData?.value.todayTotalSeconds ?? 0;
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      appBar: AppBar(title: const Text('Marquer')),
      body: RefreshIndicator(
        onRefresh: () => ref.refresh(studyStatsProvider.future),
        child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Stats card
            Card(
              color: colorScheme.primaryContainer,
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Row(
                  children: [
                    Icon(
                      Icons.timer,
                      size: 40,
                      color: colorScheme.onPrimaryContainer,
                    ),
                    const SizedBox(width: 16),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Today's Study Time",
                          style: theme.textTheme.labelMedium?.copyWith(
                            color: colorScheme.onPrimaryContainer,
                          ),
                        ),
                        Text(
                          todaySeconds > 0
                              ? _formatDuration(todaySeconds)
                              : '0m',
                          style: theme.textTheme.headlineMedium?.copyWith(
                            color: colorScheme.onPrimaryContainer,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            // Grid tiles
            Expanded(
              child: GridView.count(
                physics: const AlwaysScrollableScrollPhysics(),
                crossAxisCount: 2,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                children: [
                  _Tile(
                    icon: Icons.play_circle_fill,
                    label: 'Start Study',
                    color: colorScheme.primary,
                    onTap: () => _showCreateSessionSheet(context),
                  ),
                  _Tile(
                    icon: Icons.insert_chart_outlined_rounded,
                    label: 'Study Stats',
                    color: Colors.teal,
                    onTap: () => context.push('/study/stats'),
                  ),
                  _Tile(
                    icon: Icons.format_list_numbered,
                    label: 'Session History',
                    color: Colors.deepPurple,
                    onTap: () => context.push('/study/sessions'),
                  ),
                  _Tile(
                    icon: Icons.category,
                    label: 'Subjects',
                    color: Colors.orange,
                    onTap: () => context.push('/study/subjects'),
                  ),
                ],
              ),
            ),
          ],
        ),
        ),
      ),
    );
  }

  void _showCreateSessionSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => const CreateSessionSheet(),
    );
  }
}

class _Tile extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  final VoidCallback onTap;

  const _Tile({
    required this.icon,
    required this.label,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 48, color: color),
              const SizedBox(height: 12),
              Text(
                label,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.titleSmall,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
