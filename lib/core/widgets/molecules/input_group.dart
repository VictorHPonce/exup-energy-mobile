import 'package:flutter/material.dart';
import '../atoms/brand_text.dart';
import 'package:exup_energy_mobile/features/auth/auth.dart';

class InputGroup extends StatelessWidget {
  final String label;
  final String hint;
  final TextEditingController controller;
  final bool obscureText;
  final IconData? icon;

  const InputGroup({
    super.key,
    required this.label,
    required this.hint,
    required this.controller,
    this.obscureText = false,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        BrandText.caption(label, color: Colors.black87),
        const SizedBox(height: 8),
        CustomTextField( // Usamos el átomo que ya creamos
          controller: controller,
          label: '', // Dejamos vacío porque el label ya está arriba
          hint: hint,
          prefixIcon: icon,
          obscureText: obscureText,
        ),
      ],
    );
  }
}