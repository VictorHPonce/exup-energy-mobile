import 'package:flutter/material.dart';

//TODO: Esta clase es un placeholder para futuras expansiones de paleta de colores. Por ahora, el color principal se gestiona directamente en AppTheme, pero aquí podríamos centralizar toda la lógica de colores de la marca en el futuro.
class AppColors {
  static Color getBrandColor(BuildContext context) {
    return Theme.of(context).brightness == Brightness.light 
        ? const Color(0xFF0055FF) 
        : const Color(0xFF88AAFF);
  }
}