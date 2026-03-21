import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:marquer/providers/profile/laboratory_provider.dart';

class LaboratoryScreen extends ConsumerWidget {
  const LaboratoryScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final labAsync = ref.watch(laboratoryProvider);
    final theme = Theme.of(context);
    final cs = theme.colorScheme;

    return Scaffold(
      appBar: AppBar(title: const Text('Laboratory')),
      body: labAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Error: $e')),
        data: (features) {
          if (features.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.science_outlined, size: 64,
                      color: cs.onSurfaceVariant.withValues(alpha: 0.3)),
                  const SizedBox(height: 16),
                  Text(
                    'No experiments yet',
                    style: theme.textTheme.titleMedium?.copyWith(
                      color: cs.onSurfaceVariant,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Experimental features will appear here',
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: cs.onSurfaceVariant.withValues(alpha: 0.7),
                    ),
                  ),
                ],
              ),
            );
          }

          return ListView.builder(
            itemCount: features.length,
            itemBuilder: (context, index) {
              final key = features.keys.elementAt(index);
              final enabled = features[key] == true;
              return SwitchListTile(
                title: Text(key.replaceAll('_', ' ')),
                value: enabled,
                onChanged: (v) {
                  ref.read(laboratoryProvider.notifier).toggle(key, v);
                },
              );
            },
          );
        },
      ),
    );
  }
}
