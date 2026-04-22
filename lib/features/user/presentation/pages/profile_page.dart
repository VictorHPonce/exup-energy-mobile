import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:exup_energy_mobile/features/auth/auth.dart';
import 'package:exup_energy_mobile/core/theme/app_theme.dart';
import 'package:exup_energy_mobile/core/widgets/widgets.dart';
import '../widgets/molecules/profile_option_tile.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {

    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        final String name = (state is AuthSuccess) ? state.user.name : "Invitado";
        final String email = (state is AuthSuccess) ? state.user.email : "Inicia sesión para ver más";
        final bool isGuest = state is! AuthSuccess;

        return Scaffold(
          body: SingleChildScrollView(
            child: Column(
              children: [
                // 1. Cabecera Premium (Reutilizamos nuestro organismo)
                CustomDrawerHeader(
                  name: name,
                  email: email,
                  isGuest: isGuest,
                ),

                Padding(
                  padding: const EdgeInsets.all(AppTheme.paddingL),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildSectionTitle(context, "Mi Configuración"),
                      const SizedBox(height: AppTheme.paddingM),
                      ProfileOptionTile(
                        icon: Icons.person_outline_rounded,
                        title: "Información Personal",
                        subtitle: "Nombre y datos de contacto",
                        onTap: () {},
                      ),
                      ProfileOptionTile(
                        icon: Icons.local_gas_station_outlined,
                        title: "Combustible Preferido",
                        subtitle: "Personaliza tus precios",
                        onTap: () {},
                      ),
                      ProfileOptionTile(
                        icon: Icons.favorite_border_rounded,
                        title: "Mis Gasolineras Favoritas",
                        subtitle: "Acceso rápido a tus ahorros",
                        onTap: () {},
                      ),
                      
                      const SizedBox(height: AppTheme.paddingL),
                      _buildSectionTitle(context, "Seguridad y App"),
                      const SizedBox(height: AppTheme.paddingM),
                      
                      ProfileOptionTile(
                        icon: Icons.notifications_none_rounded,
                        title: "Notificaciones",
                        onTap: () {},
                      ),
                      ProfileOptionTile(
                        icon: Icons.dark_mode_outlined,
                        title: "Modo Oscuro",
                        trailing: Switch(value: true, onChanged: (v) {}),
                        onTap: () {},
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildSectionTitle(BuildContext context, String title) {
    return BrandText.caption(
      title.toUpperCase(),
      fontWeight: FontWeight.bold,
      color: Theme.of(context).colorScheme.primary,
    );
  }
}