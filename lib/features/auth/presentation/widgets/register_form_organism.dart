import 'package:flutter/material.dart';
import '../../../../core/widgets/atoms/primary_button.dart';
import '../../../../core/widgets/molecules/input_group.dart';

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
        const SizedBox(height: 12),
        InputGroup(
          label: 'Correo Electrónico',
          hint: 'ejemplo@exup.com',
          controller: emailController,
          icon: Icons.email_outlined,
        ),
        const SizedBox(height: 12),
        InputGroup(
          label: 'Contraseña',
          hint: 'Mínimo 6 caracteres',
          controller: passwordController,
          obscureText: true,
          icon: Icons.lock_outline_rounded,
        ),
        const SizedBox(height: 12),
        InputGroup(
          label: 'Confirmar Contraseña',
          hint: 'Repite tu contraseña',
          controller: confirmPasswordController,
          obscureText: true,
          icon: Icons.lock_reset_rounded,
        ),
        const SizedBox(height: 30),
        PrimaryButton(
          text: 'Crear Cuenta',
          isLoading: isLoading,
          onPressed: onRegisterPressed,
        ),
      ],
    );
  }
}