import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:exup_energy_mobile/core/core.dart';
import 'package:exup_energy_mobile/core/widgets/widgets.dart';
import '../bloc/auth_bloc.dart';
import '../bloc/auth_event.dart';

class LoginFormOrganism extends StatelessWidget {
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final bool isLoading;

  const LoginFormOrganism({
    super.key,
    required this.emailController,
    required this.passwordController,
    required this.isLoading,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InputGroup(
          label: 'Correo Electrónico',
          hint: 'ejemplo@exup.com',
          controller: emailController,
          icon: Icons.alternate_email,
        ),
        const SizedBox(height: AppTheme.paddingL), // Usamos token
        InputGroup(
          label: 'Contraseña',
          hint: '••••••••',
          controller: passwordController,
          obscureText: true,
          icon: Icons.lock_outline_rounded,
        ),
        const SizedBox(height: AppTheme.paddingL * 1.5), // Espaciado proporcional
        
        PrimaryButton(
          text: 'Iniciar Sesión',
          isLoading: isLoading,
          onPressed: () {
            context.read<AuthBloc>().add(
              LoginSubmittedEvent(
                emailController.text, 
                passwordController.text
              ),
            );
          },
        ),
      ],
    );
  }
}