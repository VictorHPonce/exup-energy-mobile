import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeCubit extends Cubit<ThemeMode> {
  final SharedPreferences _prefs;
  static const String _themeKey = 'theme_mode';

  ThemeCubit(this._prefs) : super(ThemeMode.system) {
    _loadTheme();
  }

  // Cargar preferencia guardada al iniciar
  void _loadTheme() {
    final savedTheme = _prefs.getString(_themeKey);
    if (savedTheme == 'dark') emit(ThemeMode.dark);
    if (savedTheme == 'light') emit(ThemeMode.light);
  }

  // Cambiar tema y guardar
  void toggleTheme(bool isDark) {
    final newMode = isDark ? ThemeMode.dark : ThemeMode.light;
    emit(newMode);
    _prefs.setString(_themeKey, isDark ? 'dark' : 'light');
  }
}