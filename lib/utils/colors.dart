import 'package:flutter/material.dart';

Color hsl(double h, double sPercent, double lPercent, {double a = 1}) {
  return HSLColor.fromAHSL(a, h, sPercent / 100, lPercent / 100).toColor();
}

ColorScheme getColors(BuildContext context) {
  return Theme.of(context).colorScheme;
}

Color hexToColor(String hex) {
  final stripped = hex.startsWith('#') ? hex.substring(1) : hex;
  final normalized = stripped.length == 6 ? 'FF$stripped' : stripped;
  if (normalized.length != 8) return Colors.black;
  final parsed = int.tryParse(normalized, radix: 16);
  return parsed != null ? Color(parsed) : Colors.black;
}