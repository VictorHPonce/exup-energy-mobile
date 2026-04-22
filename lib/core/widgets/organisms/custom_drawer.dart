import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:exup_energy_mobile/features/auth/auth.dart';
import 'package:exup_energy_mobile/core/widgets/widgets.dart';
import 'package:go_router/go_router.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        String name = "Invitado";
        String email = "Explorando ExUp Energy";
        bool isGuest = true;

        if (state is AuthSuccess) {
          name = state.user.name;
          email = state.user.email;
          isGuest = false;
        }

        return Drawer(
          backgroundColor: colorScheme.surface,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.horizontal(right: Radius.circular(32)),
          ),
          child: Column(
            children: [
              CustomDrawerHeader(
                name: name,
                email: email,
                isGuest: isGuest,
              ),

              const SizedBox(height: 12),

              // LISTADO DE OPCIONES
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: ListView(
                    padding: EdgeInsets.zero,
                    children: [
                      _SectionTitle(title: "Navegación"),
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
                      const SizedBox(height: 20),
                      _SectionTitle(title: "Preferencias"),
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

              // PIE DE PÁGINA (Boton de acción de sesión)
              Padding(
                padding: const EdgeInsets.all(24),
                child: _buildSessionButton(context, isGuest),
              ),
            ],
          ),
        );
      },
    );
  }


  Widget _buildSessionButton(BuildContext context, bool isGuest) {
    return DrawerItem(
      icon: isGuest ? Icons.login_rounded : Icons.logout_rounded,
      label: isGuest ? 'Iniciar Sesión' : 'Cerrar Sesión',
      color: isGuest ? Colors.blueAccent : Colors.redAccent,
      onTap: () {
        if (!isGuest) {
          context.read<AuthBloc>().add(const LogoutRequested());
        }
        context.go('/welcome');
      },
    );
  }
}

// Widget auxiliar para títulos de sección
class _SectionTitle extends StatelessWidget {
  final String title;
  const _SectionTitle({required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 12, bottom: 8, top: 16),
      child: Text(
        title.toUpperCase(),
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.bold,
          color: Colors.grey.withValues(alpha: 0.8),
          letterSpacing: 1.2,
        ),
      ),
    );
  }
}