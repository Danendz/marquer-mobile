import 'package:flutter/material.dart';

final themeLight = ColorScheme(
  brightness: Brightness.light,
  primary: const Color(0xFF4A7AE8),
  onPrimary: const Color(0xFFFFFFFF),
  primaryContainer: const Color(0xFFD6E3FF),
  onPrimaryContainer: const Color(0xFF1B3A6B),
  secondary: const Color(0xFF5E6A78),
  onSecondary: const Color(0xFFFFFFFF),
  secondaryContainer: const Color(0xFFDEE4EE),
  onSecondaryContainer: const Color(0xFF1A2029),
  surface: const Color(0xFFFFFFFF),
  onSurface: const Color(0xFF1A1C1E),
  surfaceContainer: const Color(0xFFF2F4F7),
  surfaceContainerHighest: const Color(0xFFE4E7EC),
  onSurfaceVariant: const Color(0xFF6B7280),
  error: const Color(0xFFDC2626),
  onError: const Color(0xFFFFFFFF),
  outline: const Color(0xFFD1D5DB),
  outlineVariant: const Color(0xFFE5E7EB),
  surfaceTint: const Color(0xFF4A7AE8),
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

  onSurfaceVariant: const Color(0xFF9E9E9E),
  outline: const Color(0xFF363739),
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
      unselectedItemColor: scheme.onSurfaceVariant,
      type: BottomNavigationBarType.fixed,
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: scheme.surface,
      foregroundColor: scheme.onSurface,
      elevation: 0,
      scrolledUnderElevation: 0.5,
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
