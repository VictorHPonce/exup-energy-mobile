import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart'; // ¡Asegúrate de este import!
import '../../../../core/widgets/atoms/primary_button.dart';
import '../../../../core/widgets/molecules/input_group.dart';
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
        const SizedBox(height: 24),
        InputGroup(
          label: 'Contraseña',
          hint: '••••••••',
          controller: passwordController,
          obscureText: true,
          icon: Icons.lock_outline_rounded,
        ),
        const SizedBox(height: 40),
        PrimaryButton(
          text: 'Iniciar Sesión',
          isLoading: isLoading,
          onPressed: () {
            // DISPARO DEL EVENTO
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