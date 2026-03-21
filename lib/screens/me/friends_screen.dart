import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:marquer/providers/profile/friends_provider.dart';

class FriendsScreen extends ConsumerWidget {
  const FriendsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final friendsAsync = ref.watch(friendsProvider);
    final requestsAsync = ref.watch(pendingRequestsProvider);
    final theme = Theme.of(context);
    final cs = theme.colorScheme;

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Friends'),
          bottom: const TabBar(
            tabs: [Tab(text: 'Friends'), Tab(text: 'Requests')],
          ),
        ),
        body: TabBarView(
          children: [
            // Friends tab
            friendsAsync.when(
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (e, _) => Center(child: Text('Error: $e')),
              data: (friends) {
                if (friends.isEmpty) {
                  return Center(
                    child: Text(
                      'No friends yet',
                      style: theme.textTheme.bodyLarge?.copyWith(
                        color: cs.onSurfaceVariant,
                      ),
                    ),
                  );
                }
                return ListView.builder(
                  itemCount: friends.length,
                  itemBuilder: (context, index) {
                    final f = friends[index];
                    return ListTile(
                      leading: CircleAvatar(
                        backgroundImage: f.avatarUrl != null
                            ? NetworkImage(f.avatarUrl!)
                            : null,
                        child: f.avatarUrl == null
                            ? const Icon(Icons.person)
                            : null,
                      ),
                      title: Text(f.username ?? 'User #${f.userId}'),
                      subtitle: f.status != null ? Text(f.status!) : null,
                      trailing: IconButton(
                        icon: const Icon(Icons.person_remove),
                        onPressed: () => ref
                            .read(friendsProvider.notifier)
                            .removeFriend(f.userId),
                      ),
                    );
                  },
                );
              },
            ),
            // Requests tab
            requestsAsync.when(
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (e, _) => Center(child: Text('Error: $e')),
              data: (requests) {
                if (requests.isEmpty) {
                  return Center(
                    child: Text(
                      'No pending requests',
                      style: theme.textTheme.bodyLarge?.copyWith(
                        color: cs.onSurfaceVariant,
                      ),
                    ),
                  );
                }
                return ListView.builder(
                  itemCount: requests.length,
                  itemBuilder: (context, index) {
                    final r = requests[index];
                    return ListTile(
                      leading: CircleAvatar(
                        backgroundImage: r.avatarUrl != null
                            ? NetworkImage(r.avatarUrl!)
                            : null,
                        child: r.avatarUrl == null
                            ? const Icon(Icons.person)
                            : null,
                      ),
                      title: Text(r.username ?? 'User #${r.userId}'),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: Icon(Icons.check, color: cs.primary),
                            onPressed: () => ref
                                .read(pendingRequestsProvider.notifier)
                                .accept(r.id),
                          ),
                          IconButton(
                            icon: Icon(Icons.close, color: cs.error),
                            onPressed: () => ref
                                .read(pendingRequestsProvider.notifier)
                                .reject(r.id),
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
