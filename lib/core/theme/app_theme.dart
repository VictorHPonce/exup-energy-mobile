import 'package:flutter/material.dart';

class AppTheme {
  // --- COLORES ---
  static const Color _seedColor = Colors.blueAccent;
  static const Color _darkBgColor = Color(0xFF121212);

  // --- TOKENS DE DISEÑO (DIMENSIONES) ---
  static const double radiusS = 8.0;
  static const double radiusM = 16.0;
  static const double radiusL = 32.0;

  static const double paddingS = 8.0;
  static const double paddingM = 16.0;
  static const double paddingL = 24.0;

  static const double iconSizeM = 24.0;
  static const double buttonHeight = 56.0;

  // TOKENS ESPECÍFICOS DE HEADER
  static const double headerRadius = 40.0;
  static const double avatarOuterRadius = 35.0;
  static const double avatarInnerRadius = 32.0;
  static const double headerPaddingTop = 60.0;

  // --- CONSTRUCCIÓN DEL TEMA ---
  static ThemeData _base(Brightness brightness) {
    final bool isDark = brightness == Brightness.dark;

    return ThemeData(
      useMaterial3: true,
      colorSchemeSeed: _seedColor,
      brightness: brightness,
      scaffoldBackgroundColor: isDark ? _darkBgColor : null,
      
      // Personalización Global de ElevatedButton
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          elevation: 0,
          minimumSize: const Size(double.infinity, buttonHeight),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radiusM),
          ),
          backgroundColor: isDark ? _seedColor.withValues(alpha: 0.8) : _seedColor,
          foregroundColor: Colors.white,
        ),
      ),
      
      // Personalización de Drawer Global
      drawerTheme: DrawerThemeData(
        backgroundColor: isDark ? _darkBgColor : Colors.white,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.horizontal(right: Radius.circular(radiusL)),
        ),
      ),
    );
  }

  static ThemeData get lightTheme => _base(Brightness.light);
  static ThemeData get darkTheme => _base(Brightness.dark);
}