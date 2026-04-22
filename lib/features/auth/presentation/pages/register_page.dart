import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:exup_energy_mobile/core/widgets/widgets.dart';
import 'package:exup_energy_mobile/core/core.dart';
import '../bloc/auth_bloc.dart';
import '../bloc/auth_event.dart';
import '../bloc/auth_state.dart';
import '../widgets/register_form_organism.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _clearForm() {
    _nameController.clear();
    _emailController.clear();
    _passwordController.clear();
    _confirmPasswordController.clear();
  }

  @override
  Widget build(BuildContext context) {
    // Al no definir backgroundColors, Flutter usa el 'surface' del tema
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent, // Transparente para ver el fondo del Scaffold
        elevation: 0,
        // iconTheme se hereda del tema principal, no hace falta forzarlo a negro
      ),
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthSuccess) {
            UiUtils.showSnackBar(context, "¡Cuenta creada! Inicia sesión.");
            _clearForm();
            context.go('/login'); 
          } else if (state is AuthError) {
            UiUtils.showSnackBar(context, state.message, isError: true);
          }
        },
        builder: (context, state) {
          return SingleChildScrollView(
            // Padding tokenizado (AppTheme.paddingL = 24 o 30 según definas)
            padding: const EdgeInsets.symmetric(horizontal: AppTheme.paddingL),
            child: Column(
              children: [
                const BrandText.header('Nueva Cuenta'),
                const SizedBox(height: AppTheme.paddingS),
                const BrandText.body(
                  'Únete a la red de energía más grande.',
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: AppTheme.paddingL),
                RegisterFormOrganism(
                  nameController: _nameController,
                  emailController: _emailController,
                  passwordController: _passwordController,
                  confirmPasswordController: _confirmPasswordController,
                  isLoading: state is AuthLoading,
                  onRegisterPressed: () => _handleRegister(context),
                ),
                const SizedBox(height: AppTheme.paddingL),
              ],
            ),
          );
        },
      ),
    );
  }

  void _handleRegister(BuildContext context) {
    final name = _nameController.text.trim();
    final email = _emailController.text.trim();
    final password = _passwordController.text;
    final confirmPassword = _confirmPasswordController.text;

    if (name.isEmpty || email.isEmpty || password.isEmpty) {
      UiUtils.showSnackBar(context, "Rellena todos los campos", isError: true);
      return;
    }

    if (password != confirmPassword) {
      UiUtils.showSnackBar(context, "Las contraseñas no coinciden", isError: true);
      return;
    }

    context.read<AuthBloc>().add(
      RegisterSubmittedEvent(
        name: name,
        email: email,
        password: password,
      ),
    );
  }
}