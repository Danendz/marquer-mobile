import 'package:go_router/go_router.dart';
import 'package:marquer/layouts/app_layout.dart';
import 'package:marquer/screens/home.dart';
import 'package:marquer/screens/notes/notes.dart';
import 'package:marquer/screens/notes/notes_edit.dart';
import 'package:marquer/screens/notes/notes_add.dart';

final router = GoRouter(
  initialLocation: '/',
  routes: [
    ShellRoute(
      builder: (context, state, child) {
        return AppLayout(path: state.uri.toString(), child: child);
      },
      routes: [
        GoRoute(path: "/", builder: (context, state) => const HomePage()),
        GoRoute(path: "/notes", builder: (context, state) => const NotesPage()),
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
      ],
    ),
  ],
);
