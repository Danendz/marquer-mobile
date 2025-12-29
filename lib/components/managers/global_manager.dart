import 'package:flutter/material.dart';
import 'package:marquer/components/managers/update_manager.dart';

class GlobalManager extends StatelessWidget {
  const GlobalManager({
    super.key,
    required this.child,
    required this.rootNavKey,
  });

  final Widget child;
  final GlobalKey<NavigatorState> rootNavKey;

  @override
  Widget build(BuildContext context) {
    return UpdateManager(rootNavKey: rootNavKey, child: child);
  }
}
