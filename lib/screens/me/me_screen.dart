import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:marquer/providers/auth/auth_provider.dart';
import 'package:marquer/providers/profile/profile_provider.dart';

class MeScreen extends ConsumerWidget {
  const MeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profileAsync = ref.watch(profileProvider);
    final authState = ref.watch(authProvider);
    final theme = Theme.of(context);
    final cs = theme.colorScheme;

    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () => ref.refresh(profileProvider.future),
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            // Cover + Avatar + Info card
            _ProfileHeader(
              profileAsync: profileAsync,
              user: authState.user,
              colorScheme: cs,
              theme: theme,
              onEditTap: () => context.push('/me/edit-profile'),
            ),
            const SizedBox(height: 16),
            // Section list
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  _SectionTile(
                    icon: Icons.people_outlined,
                    label: 'Friends',
                    onTap: () => context.push('/me/friends'),
                  ),
                  _SectionTile(
                    icon: Icons.collections_bookmark_outlined,
                    label: 'Collections',
                    enabled: false,
                    onTap: () {},
                  ),
                  _SectionTile(
                    icon: Icons.emoji_events_outlined,
                    label: 'Achievements',
                    onTap: () => context.push('/me/achievements'),
                  ),
                  _SectionTile(
                    icon: Icons.settings_outlined,
                    label: 'Settings',
                    onTap: () => context.push('/me/settings'),
                  ),
                  _SectionTile(
                    icon: Icons.science_outlined,
                    label: 'Laboratory',
                    onTap: () => context.push('/me/laboratory'),
                  ),
                  const SizedBox(height: 24),
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton.icon(
                      onPressed: () =>
                          ref.read(authProvider.notifier).logout(),
                      icon: Icon(Icons.logout, color: cs.error),
                      label: Text(
                        'Logout',
                        style: TextStyle(color: cs.error),
                      ),
                      style: OutlinedButton.styleFrom(
                        side: BorderSide(color: cs.error.withValues(alpha: 0.3)),
                        padding: const EdgeInsets.symmetric(vertical: 14),
                      ),
                    ),
                  ),
                  const SizedBox(height: 32),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ProfileHeader extends StatelessWidget {
  final AsyncValue profileAsync;
  final dynamic user;
  final ColorScheme colorScheme;
  final ThemeData theme;
  final VoidCallback onEditTap;

  const _ProfileHeader({
    required this.profileAsync,
    required this.user,
    required this.colorScheme,
    required this.theme,
    required this.onEditTap,
  });

  @override
  Widget build(BuildContext context) {
    final profile = profileAsync.asData?.value;
    final userName = user?.name ?? '';
    final joinDate = user?.createdAt ?? '';

    return Stack(
      clipBehavior: Clip.none,
      children: [
        // Cover
        Container(
          height: 160,
          width: double.infinity,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                colorScheme.primaryContainer,
                colorScheme.primary.withValues(alpha: 0.3),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        // Info card overlapping cover
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 120, 16, 0),
          child: Card(
            elevation: 2,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: InkWell(
              onTap: onEditTap,
              borderRadius: BorderRadius.circular(16),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(100, 16, 16, 16),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            userName,
                            style: theme.textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 2),
                          Text(
                            [
                              if (profile?.location != null &&
                                  profile!.location!.isNotEmpty)
                                profile.location,
                              if (joinDate.isNotEmpty) _formatJoinDate(joinDate),
                            ].join(' \u00b7 '),
                            style: theme.textTheme.bodySmall?.copyWith(
                              color: colorScheme.onSurfaceVariant,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          if (profile?.status != null &&
                              profile!.status!.isNotEmpty) ...[
                            const SizedBox(height: 6),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 2),
                              decoration: BoxDecoration(
                                color: colorScheme.primaryContainer,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Text(
                                profile.status!,
                                style: theme.textTheme.labelSmall?.copyWith(
                                  color: colorScheme.onPrimaryContainer,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ] else ...[
                            const SizedBox(height: 6),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 2),
                              decoration: BoxDecoration(
                                border:
                                    Border.all(color: colorScheme.outline),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Text(
                                '+ Status',
                                style: theme.textTheme.labelSmall?.copyWith(
                                  color: colorScheme.onSurfaceVariant,
                                ),
                              ),
                            ),
                          ],
                        ],
                      ),
                    ),
                    Icon(
                      Icons.chevron_right,
                      color: colorScheme.onSurfaceVariant,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        // Avatar positioned over the card
        Positioned(
          left: 32,
          top: 96,
          child: CircleAvatar(
            radius: 36,
            backgroundColor: colorScheme.surfaceContainer,
            child: profile?.avatarUrl != null
                ? ClipOval(
                    child: Image.network(
                      profile!.avatarUrl!,
                      width: 72,
                      height: 72,
                      fit: BoxFit.cover,
                    ),
                  )
                : Icon(
                    Icons.person,
                    size: 36,
                    color: colorScheme.onSurfaceVariant,
                  ),
          ),
        ),
      ],
    );
  }

  String _formatJoinDate(String isoDate) {
    try {
      final date = DateTime.parse(isoDate);
      final months = [
        '', 'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
        'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec',
      ];
      return 'Joined ${months[date.month]} ${date.year}';
    } catch (_) {
      return '';
    }
  }
}

class _SectionTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool enabled;
  final VoidCallback onTap;

  const _SectionTile({
    required this.icon,
    required this.label,
    required this.onTap,
    this.enabled = true,
  });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final tt = Theme.of(context).textTheme;

    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: ListTile(
        leading: Icon(
          icon,
          color: enabled ? cs.onSurface : cs.onSurfaceVariant.withValues(alpha: 0.5),
        ),
        title: Text(
          label.toUpperCase(),
          style: tt.titleSmall?.copyWith(
            fontWeight: FontWeight.w600,
            letterSpacing: 0.5,
            color: enabled ? cs.onSurface : cs.onSurfaceVariant.withValues(alpha: 0.5),
          ),
        ),
        trailing: Icon(
          Icons.chevron_right,
          color: enabled ? cs.onSurfaceVariant : cs.onSurfaceVariant.withValues(alpha: 0.3),
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        onTap: enabled ? onTap : null,
      ),
    );
  }
}
