import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: .center,
          children: [
            const Text('Home'),
            ElevatedButton(onPressed: () => context.go("/notes"), child: const Text("Go to notes")),
            ElevatedButton(onPressed: () => context.go("/notes/add"), child: const Text("Go to create page")),
            ElevatedButton(onPressed: () => context.go("/notes/123"), child: const Text("Go to edit page"))
          ],
        ),
      ),
    );
  }
}
