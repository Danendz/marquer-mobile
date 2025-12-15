import 'package:flutter/material.dart';
import 'package:marquer/utils/colors.dart';

final themeLight = ColorScheme(
  brightness: Brightness.light,
  primary: hsl(142.1, 76.2, 36.3),
  onPrimary: hsl(355.7, 100, 97.3),
  secondary: hsl(240, 4.8, 95.9),
  onSecondary: hsl(240, 5.9, 10),
  error: hsl(0, 84.2, 60.2),
  onError: hsl(0, 0, 98),
  surface: hsl(0, 0, 100),
  onSurface: hsl(240, 10, 3.9),
  outline: hsl(240, 5.9, 90),
  surfaceTint: hsl(142.1, 76.2, 36.3), // ring/primary tint
);

final themeDark = ColorScheme(
  brightness: Brightness.dark,
  primary: const Color(0xFF7FAF7A),      // мягкий neutral green
  onPrimary: const Color(0xFF122015),
  secondary: const Color(0xFF8FA19A),
  onSecondary: const Color(0xFF111615),
  error: const Color(0xFFCF6679),
  onError: const Color(0xFF1B0B10),
  surface: const Color(0xFF14181B),
  onSurface: const Color(0xFFE0E3E3),
  outline: const Color(0xFF3C4446),
  surfaceTint: const Color(0xFF5F9364),
);

ThemeData buildTheme(ColorScheme scheme) {
  return ThemeData(
    useMaterial3: true,
    colorScheme: scheme,
    scaffoldBackgroundColor: scheme.surface,
    cardTheme: CardThemeData(
      color: scheme.surface,
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: scheme.surface,
    ),
  );
}
