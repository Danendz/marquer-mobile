import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:marquer/api/models/calendar/countdown.dart';
import 'package:marquer/api/models/calendar/plan.dart';
import 'package:marquer/api/models/study/study_session.dart';
import 'package:marquer/layouts/app_layout.dart';
import 'package:marquer/providers/auth/auth_provider.dart';
import 'package:marquer/screens/calendar/countdown_detail_screen.dart';
import 'package:marquer/screens/calendar/countdown_settings_screen.dart';
import 'package:marquer/screens/home.dart';
import 'package:marquer/screens/notes/notes.dart';
import 'package:marquer/screens/notes/notes_edit.dart';
import 'package:marquer/screens/notes/notes_add.dart';
import 'package:marquer/screens/calendar/calendar_screen.dart';
import 'package:marquer/screens/calendar/plan_form_screen.dart';
import 'package:marquer/screens/me/me_screen.dart';
import 'package:marquer/screens/me/edit_profile_screen.dart';
import 'package:marquer/screens/study/active_timer_screen.dart';
import 'package:marquer/screens/study/manage_subjects_screen.dart';
import 'package:marquer/screens/study/study_stats_screen.dart';

import '../screens/auth/login.dart';
import '../screens/auth/register.dart';
import '../screens/splash.dart';
import '../screens/tasks/tasks.dart';
import '../screens/tasks/task_folders.dart';

final rootNavKey = GlobalKey<NavigatorState>();

GoRouter createRouter(WidgetRef ref, ChangeNotifier refreshNotifier) {
  return GoRouter(
    navigatorKey: rootNavKey,
    initialLocation: '/splash',
    refreshListenable: refreshNotifier,
    redirect: (context, state) {
      final authState = ref.read(authProvider);
      final loc = state.matchedLocation;

      final isSplash = loc == '/splash';
      final isLogin = loc == '/login' || loc == '/register';

      if (authState.status == AuthStatus.unknown) {
        return isSplash ? null : '/splash';
      }

      if (authState.status == AuthStatus.unauthenticated) {
        return isLogin ? null : '/login';
      }

      if (authState.status == AuthStatus.authenticated) {
        if (isSplash || isLogin) return '/';
      }

      return null;
    },
    routes: [
      GoRoute(path: '/splash', builder: (context, state) => const SplashPage()),
      GoRoute(path: '/login', builder: (context, state) => LoginPage()),
      GoRoute(path: '/register', builder: (context, state) => RegisterPage()),
      GoRoute(
        path: '/study/active',
        builder: (context, state) {
          final session = state.extra as StudySession?;
          return ActiveTimerScreen(session: session);
        },
      ),
      GoRoute(
        path: '/countdown/detail',
        builder: (context, state) {
          final countdown = state.extra as Countdown;
          return CountdownDetailScreen(initialCountdown: countdown);
        },
      ),
      GoRoute(
        path: '/countdown/settings',
        builder: (context, state) {
          final countdown = state.extra as Countdown;
          return CountdownSettingsScreen(countdown: countdown);
        },
      ),
      GoRoute(
        path: '/calendar/plan/form',
        builder: (context, state) {
          final plan = state.extra as Plan?;
          return PlanFormScreen(plan: plan);
        },
      ),
      GoRoute(
        path: '/me/edit-profile',
        builder: (context, state) => const EditProfileScreen(),
      ),
      ShellRoute(
        builder: (context, state, child) {
          return AppLayout(path: state.uri.toString(), child: child);
        },
        routes: [
          GoRoute(path: "/", builder: (context, state) => const HomePage()),
          GoRoute(path: "/notes", builder: (context, state) => const NotesPage()),
          GoRoute(path: "/notes/add", builder: (context, state) => const NotesAddPage()),
          GoRoute(
            path: "/notes/:id",
            builder: (context, state) {
              final id = state.pathParameters['id'];
              return NotesEditPage(id: id!);
            },
          ),
          GoRoute(path: "/tasks", builder: (context, state) => const TasksPage()),
          GoRoute(path: "/tasks/manage-folders", builder: (context, state) => const TaskFoldersPage()),
          GoRoute(path: '/study/stats', builder: (context, state) => const StudyStatsScreen()),
          GoRoute(path: '/study/subjects', builder: (context, state) => const ManageSubjectsScreen()),
          GoRoute(path: '/calendar', builder: (context, state) => const CalendarScreen()),
          GoRoute(path: '/me', builder: (context, state) => const MeScreen()),
        ],
      ),
    ],
  );
}
