import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:exup_energy_mobile/core/theme/app_theme.dart';
import 'package:exup_energy_mobile/core/utils/ui_utils.dart';
import 'package:exup_energy_mobile/features/auth/auth.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.transparent, elevation: 0),
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthSuccess) {
            context.go('/home');
          } else if (state is AuthError) {
            UiUtils.showSnackBar(context, state.message, isError: true);
          }
        },
        builder: (context, state) {
          return SingleChildScrollView(
            padding: const EdgeInsets.symmetric(
              horizontal: AppTheme.paddingL,
            ), // Tokenizado
            child: Column(
              children: [
                const SizedBox(height: AppTheme.paddingL),
                Icon(Icons.bolt, size: 80, color: colorScheme.primary),
                const SizedBox(height: AppTheme.paddingL),

                LoginFormOrganism(
                  emailController: _emailController,
                  passwordController: _passwordController,
                  isLoading: state is AuthLoading,
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
