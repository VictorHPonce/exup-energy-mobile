import 'package:flutter/material.dart';

class AppTheme {
  static const Color _seedColor = Colors.blueAccent;

  static ThemeData _base(Brightness brightness) => ThemeData(
        useMaterial3: true,
        colorSchemeSeed: _seedColor,
        brightness: brightness,
        // Centralizamos el estilo de botones para no repetirlo en el átomo
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            elevation: 0,
            minimumSize: const Size(double.infinity, 56),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            // Esto asegura que el botón use colores del esquema automáticamente
            backgroundColor: brightness == Brightness.light 
                ? _seedColor 
                : Colors.blueAccent.withValues(alpha: 0.8),
            foregroundColor: Colors.white,
          ),
        ),
      );

  static ThemeData get lightTheme => _base(Brightness.light);

  static ThemeData get darkTheme => _base(Brightness.dark).copyWith(
        scaffoldBackgroundColor: const Color(0xFF121212),
      );
}