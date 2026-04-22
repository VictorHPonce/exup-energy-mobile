import 'package:flutter/material.dart';

class AppTheme {
  // Color principal de la marca ExUp
  static const Color _seedColor = Colors.blueAccent;

  // Tema Claro
  static ThemeData get lightTheme => ThemeData(
        useMaterial3: true,
        colorSchemeSeed: _seedColor,
        brightness: Brightness.light,
        // Aquí puedes personalizar botones globalmente
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          ),
        ),
      );

  // Tema Oscuro
  static ThemeData get darkTheme => ThemeData(
        useMaterial3: true,
        colorSchemeSeed: _seedColor,
        brightness: Brightness.dark,
        // Personalización para modo oscuro
        scaffoldBackgroundColor: const Color(0xFF121212),
      );
}