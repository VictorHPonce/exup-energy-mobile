import 'package:flutter/material.dart';
import 'package:exup_energy_mobile/core/theme/app_theme.dart';
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
        // Ahora sí reconoce el fontWeight
        BrandText.caption(
          label, 
          fontWeight: FontWeight.bold, 
        ),
        const SizedBox(height: AppTheme.paddingS),
        CustomTextField(
          controller: controller,
          label: '', 
          hint: hint,
          prefixIcon: icon,
          obscureText: obscureText,
        ),
      ],
    );
  }
}