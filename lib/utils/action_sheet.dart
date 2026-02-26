import 'package:flutter/material.dart';
import 'package:marquer/utils/colors.dart';

class AppAction {
  final String value;
  final IconData icon;
  final String label;
  final bool isDestructive;

  const AppAction({
    required this.value,
    required this.icon,
    required this.label,
    this.isDestructive = false,
  });
}

Future<String?> showAppActionSheet(
  BuildContext context,
  List<AppAction> actions,
) {
  return showModalBottomSheet<String>(
    context: context,
    backgroundColor: Colors.transparent,
    builder: (context) => _AppActionSheet(actions: actions),
  );
}

class _AppActionSheet extends StatelessWidget {
  final List<AppAction> actions;

  const _AppActionSheet({required this.actions});

  @override
  Widget build(BuildContext context) {
    final colors = getColors(context);

    return Container(
      decoration: BoxDecoration(
        color: colors.surfaceContainer,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 36,
              height: 4,
              margin: const EdgeInsets.symmetric(vertical: 14),
              decoration: BoxDecoration(
                color: colors.onSurface.withValues(alpha: 0.25),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            ...actions.map((action) {
              final color = action.isDestructive ? Colors.red : colors.onSurface;
              return InkWell(
                onTap: () => Navigator.pop(context, action.value),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                  child: Row(
                    children: [
                      Icon(action.icon, color: color, size: 22),
                      const SizedBox(width: 16),
                      Text(
                        action.label,
                        style: TextStyle(fontSize: 16, color: color),
                      ),
                    ],
                  ),
                ),
              );
            }),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }
}
