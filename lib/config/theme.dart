import 'package:flutter/material.dart';
import 'package:marquer/utils/colors.dart';

final themeLight = ColorScheme(
  brightness: Brightness.light,
  primary: const Color(0xFF5777b8),
  onPrimary: const Color(0xFFFFFFFF),
  secondary: const Color(0xFF888888),
  onSecondary: hsl(240, 5.9, 10),
  error: hsl(0, 84.2, 60.2),
  onError: hsl(0, 0, 98),
  surface: const Color(0xFFC4C4C4),
  onSurface: const Color(0xFF000000),
  outline: hsl(240, 5.9, 90),
  surfaceTint: hsl(142.1, 76.2, 36.3),
);

final themeDark = ColorScheme(
  brightness: Brightness.dark,
  primary: const Color(0xFF4C66A1),
  onPrimary: const Color(0xFFFFFFFF),

  primaryContainer: const Color(0xFF324470),
  onPrimaryContainer: const Color(0xFFD6E2FF),

  surface: const Color(0xFF000000),
  onSurface: const Color(0xFFF1F0EE),

  surfaceContainer: const Color(0xFF303030),

  secondary: const Color(0xFF303030),
  onSecondary: const Color(0xFFE2E2E2),

  error: const Color(0xFFCF6679),
  onError: const Color(0xFF1B0B10),

  outline: const Color(0xFF3C4446),
  surfaceTint: const Color(0xFF4C66A1),
);

ThemeData buildTheme(ColorScheme scheme) {
  return ThemeData(
    useMaterial3: true,
    colorScheme: scheme,
    scaffoldBackgroundColor: scheme.surface,
    cardTheme: CardThemeData(
      color: scheme.surfaceContainer,
      elevation: 0,
      margin: EdgeInsets.zero,
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: scheme.surface,
      selectedItemColor: scheme.primary,
      unselectedItemColor: scheme.onSecondary,
      type: BottomNavigationBarType.fixed,
    ),
    navigationBarTheme: NavigationBarThemeData(
      indicatorColor: scheme.primary, // The pill background color
      iconTheme: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return IconThemeData(color: scheme.onPrimary); // Icon inside the pill
        }
        return IconThemeData(color: scheme.onSurfaceVariant);
      }),
    ),
  );
}
