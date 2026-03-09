import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:marquer/api/models/study/study_session.dart';
import 'package:marquer/layouts/app_layout.dart';
import 'package:marquer/screens/home.dart';
import 'package:marquer/screens/notes/notes.dart';
import 'package:marquer/screens/notes/notes_edit.dart';
import 'package:marquer/screens/notes/notes_add.dart';
import 'package:marquer/screens/calendar/calendar_screen.dart';
import 'package:marquer/screens/study/active_timer_screen.dart';
import 'package:marquer/screens/study/manage_subjects_screen.dart';
import 'package:marquer/screens/study/study_stats_screen.dart';

import '../screens/auth/login.dart';
import '../screens/auth/register.dart';
import '../screens/splash.dart';
import '../screens/tasks/tasks.dart';
import '../screens/tasks/task_folders.dart';
import '../stores/auth_store.dart';

final rootNavKey = GlobalKey<NavigatorState>();
final getIt = GetIt.instance;

GoRouter createRouter() {
  final auth = getIt<AuthStore>();

  return GoRouter(
    navigatorKey: rootNavKey,
    initialLocation: '/splash',
    refreshListenable: auth,
    redirect: (context, state) {
      final loc = state.matchedLocation;

      final isSplash = loc == '/splash';
      final isLogin = loc == '/login' || loc == '/register';

      if (auth.status == AuthStatus.unknown) {
        return isSplash ? null : '/splash';
      }

      if (auth.status == AuthStatus.unauthenticated) {
        return isLogin ? null : '/login';
      }

      if (auth.status == AuthStatus.authenticated) {
        if (isSplash || isLogin) return '/';
      }

      return null;
    },
    routes: [
      GoRoute(path: '/splash', builder: (context, state) => const SplashPage()),
      GoRoute(path: '/login', builder: (context, state) => LoginPage()),
      GoRoute(path: '/register', builder: (context, state) => RegisterPage()),
      // Full-screen routes (outside ShellRoute — no bottom nav)
      GoRoute(
        path: '/study/active',
        builder: (context, state) {
          final session = state.extra as StudySession?;
          return ActiveTimerScreen(session: session);
        },
      ),
      ShellRoute(
        builder: (context, state, child) {
          return AppLayout(path: state.uri.toString(), child: child);
        },
        routes: [
          GoRoute(path: "/", builder: (context, state) => const HomePage()),
          GoRoute(
            path: "/notes",
            builder: (context, state) => const NotesPage(),
          ),
          GoRoute(
            path: "/notes/add",
            builder: (context, state) => const NotesAddPage(),
          ),
          GoRoute(
            path: "/notes/:id",
            builder: (context, state) {
              final id = state.pathParameters['id'];
              return NotesEditPage(id: id!);
            },
          ),
          GoRoute(
            path: "/tasks",
            builder: (context, state) => const TasksPage(),
          ),
          GoRoute(
            path: "/tasks/manage-folders",
            builder: (context, state) => const TaskFoldersPage(),
          ),
          GoRoute(
            path: '/study/stats',
            builder: (context, state) => const StudyStatsScreen(),
          ),
          GoRoute(
            path: '/study/subjects',
            builder: (context, state) => const ManageSubjectsScreen(),
          ),
          GoRoute(
            path: '/calendar',
            builder: (context, state) => const CalendarScreen(),
          ),
        ],
      ),
    ],
  );
}
