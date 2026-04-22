import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:exup_energy_mobile/core/widgets/widgets.dart';
import 'package:exup_energy_mobile/core/core.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppTheme.paddingL),
          child: Column(
            children: [
              const Spacer(flex: 2),
              
              Icon(
                Icons.bolt_rounded,
                size: 100,
                color: colorScheme.primary,
              ),

              const SizedBox(height: AppTheme.paddingL),

              const BrandText.header('ExUp Energy'),

              const SizedBox(height: AppTheme.paddingS),

              const BrandText.body(
                'Encuentra la mejor energía para tu camino',
                textAlign: TextAlign.center,
              ),

              const Spacer(flex: 3),

              PrimaryButton(
                text: 'Iniciar Sesión',
                onPressed: () => context.push('/login'),
              ),

              const SizedBox(height: AppTheme.paddingM),

              TextButton(
                onPressed: () => context.go('/home'),
                child: Text(
                  'Entrar como invitado',
                  style: TextStyle(
                    color: colorScheme.primary,
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  ),
                ),
              ),

              const Spacer(),
              _buildFooter(context, colorScheme),

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFooter(BuildContext context, ColorScheme colorScheme) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const BrandText.caption('¿Eres nuevo? '),
        GestureDetector(
          onTap: () => context.push('/register'),
          child: Text(
            'Crea una cuenta aquí',
            style: TextStyle(
              color: colorScheme.primary,
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          ),
        ),
      ],
    );
  }
}