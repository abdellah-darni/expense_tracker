import 'package:expense_tracker/core/theme/app_theme.dart';
import 'package:flutter/material.dart';

class BlueTheme {
  static ThemeData get light {
    return ThemeData(
      brightness: Brightness.light,
      textTheme: AppTheme.baseTextTheme,
      colorScheme: const ColorScheme.light(
        primary: Color(0xFF324A5F),
        secondary: Color(0xFF97F6C7),
        surface: Color(0xFFF6FAFF),
        onSurface: Color(0xFF171C20),
        shadow: Colors.black26,
        tertiary: Color(0xC79FB9D3),
        onTertiary: Color(0xFF43474C),

        primaryContainer: Color(0xFF1F3040), // Using this as Gradient Start
        secondaryContainer: Color(0xFF486975), // Using this as Gradient End
      ),
    );
  }

  static ThemeData get dark {
    return ThemeData(
      brightness: Brightness.dark,
      textTheme: AppTheme.baseTextTheme.apply(
        bodyColor: const Color(0xFFF6FAFF),
        displayColor: const Color(0xFFF6FAFF),
      ),
      colorScheme: const ColorScheme.dark(
        primary: Color(0xFF5A809E),
        secondary: Color(0xFF97F6C7),
        surface: Color(0xFF121A21),
        onSurface: Color(0xFFF6FAFF),
        shadow: Colors.black54,
        tertiary: Color(0xFF24313D),
        onTertiary: Color(0xFFA5B8C7),

        primaryContainer: Color(0xFF1A2836),
        secondaryContainer: Color(0xFF344D5E),
      ),
    );
  }
}
