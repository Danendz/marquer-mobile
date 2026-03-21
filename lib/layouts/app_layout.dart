import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AppLayout extends StatelessWidget {
  final Widget child;
  final String path;
  static const List<String> paths = ["/notes", "/calendar", "/me"];

  const AppLayout({super.key, required this.child, required this.path});

  int _getCurrentIndex(String path) {
    if (path == "/") return 0;

    return paths.indexWhere((p) => path.startsWith(p)) + 1;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: child),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(
              color: Theme.of(context).colorScheme.outline,
              width: 1,
            ),
          ),
        ),
        child: BottomNavigationBar(
          currentIndex: _getCurrentIndex(path),
          onTap: (index) {
            switch (index) {
              case 0:
                context.go('/');
                break;
              case 1:
                context.go('/notes');
                break;
              case 2:
                context.go('/calendar');
                break;
              case 3:
                context.go('/me');
                break;
              default:
                throw Exception('Invalid index');
            }
          },
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
            BottomNavigationBarItem(icon: Icon(Icons.note), label: 'Notes'),
            BottomNavigationBarItem(icon: Icon(Icons.calendar_month), label: 'Calendar'),
            BottomNavigationBarItem(icon: Icon(Icons.person_outline), label: 'Me'),
          ],
        ),
      ),
    );
  }
}
