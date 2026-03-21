import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:marquer/providers/profile/settings_provider.dart';
import 'package:marquer/providers/profile/theme_provider.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settingsAsync = ref.watch(settingsProvider);
    final theme = Theme.of(context);
    final cs = theme.colorScheme;

    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: settingsAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Error: $e')),
        data: (settings) => ListView(
          children: [
            // Theme
            ListTile(
              leading: Icon(
                settings.theme == 'dark' ? Icons.dark_mode : Icons.light_mode,
                color: cs.primary,
              ),
              title: const Text('Theme'),
              subtitle: Text(settings.theme == 'dark' ? 'Dark' : 'Light'),
              trailing: Switch(
                value: settings.theme == 'dark',
                onChanged: (dark) {
                  final newTheme = dark ? 'dark' : 'light';
                  ref.read(settingsProvider.notifier).updateTheme(newTheme);
                  ref.read(themeProvider.notifier).setTheme(
                    dark ? ThemeMode.dark : ThemeMode.light,
                  );
                },
              ),
            ),
            const Divider(height: 1),
            // Language
            ListTile(
              leading: Icon(Icons.language, color: cs.primary),
              title: const Text('Language'),
              subtitle: Text(_languageName(settings.language)),
              trailing: DropdownButton<String>(
                value: settings.language,
                underline: const SizedBox(),
                items: const [
                  DropdownMenuItem(value: 'en', child: Text('English')),
                  DropdownMenuItem(value: 'fr', child: Text('Fran\u00e7ais')),
                  DropdownMenuItem(value: 'zh_CN', child: Text('\u4e2d\u6587')),
                ],
                onChanged: (lang) {
                  if (lang != null) {
                    ref.read(settingsProvider.notifier).updateLanguage(lang);
                  }
                },
              ),
            ),
            const Divider(height: 1),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                'Notifications',
                style: theme.textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: cs.onSurfaceVariant,
                ),
              ),
            ),
            SwitchListTile(
              secondary: Icon(Icons.notifications_outlined, color: cs.primary),
              title: const Text('Notifications'),
              subtitle: const Text('Enable all notifications'),
              value: settings.notificationsEnabled,
              onChanged: (v) {
                ref.read(settingsProvider.notifier).updateNotifications({
                  'notifications_enabled': v,
                });
              },
            ),
            SwitchListTile(
              secondary: const SizedBox(width: 24),
              title: const Text('Study reminders'),
              value: settings.notificationStudyReminders,
              onChanged: settings.notificationsEnabled
                  ? (v) {
                      ref.read(settingsProvider.notifier).updateNotifications({
                        'notification_study_reminders': v,
                      });
                    }
                  : null,
            ),
            SwitchListTile(
              secondary: const SizedBox(width: 24),
              title: const Text('Task reminders'),
              value: settings.notificationTaskReminders,
              onChanged: settings.notificationsEnabled
                  ? (v) {
                      ref.read(settingsProvider.notifier).updateNotifications({
                        'notification_task_reminders': v,
                      });
                    }
                  : null,
            ),
          ],
        ),
      ),
    );
  }

  String _languageName(String code) {
    switch (code) {
      case 'fr':
        return 'Fran\u00e7ais';
      case 'zh_CN':
        return '\u4e2d\u6587';
      default:
        return 'English';
    }
  }
}
