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
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0, 
        backgroundColor: Colors.white, 
        iconTheme: const IconThemeData(color: Colors.black)
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
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Column(
              children: [
                const BrandText.header('Nueva Cuenta'),
                const SizedBox(height: 10),
                const BrandText.body('Únete a la red de energía más grande.'),
                const SizedBox(height: 30),
                RegisterFormOrganism(
                  nameController: _nameController,
                  emailController: _emailController,
                  passwordController: _passwordController,
                  confirmPasswordController: _confirmPasswordController,
                  isLoading: state is AuthLoading,
                  onRegisterPressed: () => _handleRegister(context),
                ),
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