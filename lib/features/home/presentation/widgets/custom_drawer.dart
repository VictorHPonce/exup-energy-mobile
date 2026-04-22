import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:exup_energy_mobile/features/auth/auth.dart';
import 'package:exup_energy_mobile/core/widgets/widgets.dart';
import 'package:exup_energy_mobile/core/theme/app_theme.dart';
import 'package:go_router/go_router.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {

    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        // Lógica de datos de usuario
        final String name = (state is AuthSuccess) ? state.user.name : "Invitado";
        final String email = (state is AuthSuccess) ? state.user.email : "Explorando ExUp Energy";
        final bool isGuest = state is! AuthSuccess;

        return Drawer(
          // No hace falta poner backgroundColor ni shape, ya están en el AppTheme!
          child: Column(
            children: [
              CustomDrawerHeader(
                name: name,
                email: email,
                isGuest: isGuest,
              ),

              const SizedBox(height: AppTheme.paddingM),

              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: AppTheme.paddingM),
                  child: ListView(
                    padding: EdgeInsets.zero,
                    children: [
                      const _SectionTitle(title: "Navegación"),
                      DrawerItem(
                        icon: Icons.home_rounded,
                        label: 'Inicio',
                        onTap: () => Navigator.pop(context),
                      ),
                      DrawerItem(
                        icon: Icons.map_rounded,
                        label: 'Mapa de Estaciones',
                        onTap: () {},
                      ),
                      
                      const SizedBox(height: AppTheme.paddingL),
                      const _SectionTitle(title: "Preferencias"),
                      DrawerItem(
                        icon: Icons.favorite_rounded,
                        label: 'Mis Favoritos',
                        onTap: () {},
                      ),
                      DrawerItem(
                        icon: Icons.settings_rounded,
                        label: 'Ajustes',
                        onTap: () {},
                      ),
                    ],
                  ),
                ),
              ),

              // Botón de sesión al final
              Padding(
                padding: const EdgeInsets.all(AppTheme.paddingL),
                child: _SessionButton(isGuest: isGuest),
              ),
            ],
          ),
        );
      },
    );
  }
}

/// Botón de sesión estilizado como molécula privada
class _SessionButton extends StatelessWidget {
  final bool isGuest;
  const _SessionButton({required this.isGuest});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return DrawerItem(
      icon: isGuest ? Icons.login_rounded : Icons.logout_rounded,
      label: isGuest ? 'Iniciar Sesión' : 'Cerrar Sesión',
      // Usamos el color de error del tema para el logout (rojo) 
      // y el primario para el login
      color: isGuest ? colorScheme.primary : colorScheme.error,
      onTap: () {
        if (!isGuest) {
          context.read<AuthBloc>().add(const LogoutRequested());
        }
        context.go('/welcome');
      },
    );
  }
}

/// Título de sección que consume tokens del tema
class _SectionTitle extends StatelessWidget {
  final String title;
  const _SectionTitle({required this.title});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.only(
        left: AppTheme.paddingS, 
        bottom: AppTheme.paddingS, 
        top: AppTheme.paddingM
      ),
      child: Text(
        title.toUpperCase(),
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.bold,
          // Color semántico para textos secundarios
          color: colorScheme.onSurfaceVariant.withValues(alpha: 0.8),
          letterSpacing: 1.2,
        ),
      ),
    );
  }
}