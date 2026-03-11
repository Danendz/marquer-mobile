import 'package:flutter/material.dart';

class CircleCheckbox extends StatelessWidget {
  final bool checked;
  final VoidCallback? onTap;
  final Color color;

  const CircleCheckbox({
    super.key,
    required this.checked,
    required this.onTap,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 24,
        height: 24,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: checked ? color : Colors.transparent,
          border: checked ? null : Border.all(color: color, width: 2),
        ),
        child: checked
            ? const Icon(Icons.check, size: 16, color: Colors.white)
            : null,
      ),
    );
  }
}
