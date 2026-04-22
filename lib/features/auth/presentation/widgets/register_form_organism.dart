import 'package:flutter/material.dart';
import 'package:exup_energy_mobile/core/core.dart';
import 'package:exup_energy_mobile/core/widgets/widgets.dart';

class RegisterFormOrganism extends StatelessWidget {
  final TextEditingController nameController;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final TextEditingController confirmPasswordController;
  final bool isLoading;
  final VoidCallback onRegisterPressed;

  const RegisterFormOrganism({
    super.key,
    required this.nameController,
    required this.emailController,
    required this.passwordController,
    required this.confirmPasswordController,
    required this.isLoading,
    required this.onRegisterPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InputGroup(
          label: 'Nombre Completo',
          hint: 'Ej. Juan Pérez',
          controller: nameController,
          icon: Icons.person_outline,
        ),
        const SizedBox(height: AppTheme.paddingM),
        InputGroup(
          label: 'Correo Electrónico',
          hint: 'ejemplo@exup.com',
          controller: emailController,
          icon: Icons.email_outlined,
        ),
        const SizedBox(height: AppTheme.paddingM),
        InputGroup(
          label: 'Contraseña',
          hint: 'Mínimo 6 caracteres',
          controller: passwordController,
          obscureText: true,
          icon: Icons.lock_outline_rounded,
        ),
        const SizedBox(height: AppTheme.paddingM),
        InputGroup(
          label: 'Confirmar Contraseña',
          hint: 'Repite tu contraseña',
          controller: confirmPasswordController,
          obscureText: true,
          icon: Icons.lock_reset_rounded,
        ),
        const SizedBox(height: AppTheme.paddingL),
        PrimaryButton(
          text: 'Crear Cuenta',
          isLoading: isLoading,
          onPressed: onRegisterPressed,
        ),
      ],
    );
  }
}