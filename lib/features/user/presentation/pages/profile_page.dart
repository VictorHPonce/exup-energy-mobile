import 'package:exup_energy_mobile/core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:exup_energy_mobile/features/auth/auth.dart';
import 'package:exup_energy_mobile/features/user/user.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<UserBloc, UserState>(
      listener: _userListener,
      child: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          final user = (state is AuthSuccess) ? state.user : null;

          final String name = user?.name ?? "Invitado";
          final String email = user?.email ?? "Inicia sesión para ver más";
          final bool isGuest = user == null;

          final bool isDark = Theme.of(context).brightness == Brightness.dark;

          return Scaffold(
            body: SingleChildScrollView(
              child: Column(
                children: [
                  ProfileAvatarHeader(
                    key: ValueKey(user?.profilePictureUrl ?? 'no-image'),
                    name: name,
                    email: email,
                    isGuest: isGuest,
                    profilePictureUrl: user?.profilePictureUrl,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(AppTheme.paddingL),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        UiUtils.sectionHeader(context, "Mi Configuración"),
                        const SizedBox(height: AppTheme.paddingM),

                        ProfileOptionTile(
                          icon: Icons.person_outline_rounded,
                          title: "Información Personal",
                          subtitle: name,
                          onTap: isGuest
                              ? () {}
                              : () => ProfileModals.showEditName(context, name),
                        ),

                        ProfileOptionTile(
                          icon: Icons.local_gas_station_outlined,
                          title: "Combustible Preferido",
                          subtitle: (user?.preferredFuelTypeId == null)
                              ? "Selecciona tu combustible"
                              : _getFuelNameById(
                                  context,
                                  user!.preferredFuelTypeId!,
                                ),
                          onTap: isGuest
                              ? () {}
                              : () =>
                                    ProfileModals.showFuelPicker(context, name),
                        ),

                        ProfileOptionTile(
                          icon: Icons.favorite_border_rounded,
                          title: "Mis Gasolineras Favoritas",
                          subtitle: "Acceso rápido a tus ahorros",
                          onTap: () => UiUtils.showFeatureNotAvailable(context),
                        ),

                        const SizedBox(height: AppTheme.paddingL),
                        UiUtils.sectionHeader(context, "Seguridad y App"),
                        const SizedBox(height: AppTheme.paddingM),

                        ProfileOptionTile(
                          icon: Icons.notifications_none_rounded,
                          title: "Notificaciones",
                          onTap: () => UiUtils.showFeatureNotAvailable(context),
                        ),

                        ProfileOptionTile(
                          icon: Icons
                              .palette_outlined, // Icono genérico de apariencia
                          title: "Apariencia",
                          subtitle: isDark
                              ? "Oscuro activado"
                              : "Claro activado",
                          trailing: Switch(
                            value: isDark,
                            onChanged: (bool value) {
                              context.read<ThemeCubit>().toggleTheme(value);
                            },
                          ),
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
      ),
    );
  }

  // --- LÓGICA DE ESCUCHA ---
  void _userListener(BuildContext context, UserState state) {
    if (state is UserSuccess) {
      UiUtils.showSnackBar(context, state.message);
      context.read<AuthBloc>().add(AppStarted());
    }
    if (state is UserError) {
      UiUtils.showSnackBar(context, state.message, isError: true);
    }
  }

  String _getFuelNameById(BuildContext context, int id) {
    final fuels = context.read<AuthBloc>().allFuels;

    if (fuels.isEmpty) {
      return "Cargando...";
    }

    final fuel = fuels.firstWhere(
      (f) => f.id == id,
      orElse: () => FuelTypeModel(id: 0, name: 'Personalizado'),
    );

    return fuel.name;
  }
}
