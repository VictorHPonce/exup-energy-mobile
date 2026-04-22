import 'package:exup_energy_mobile/core/constants/fuel_constants.dart';
import 'package:exup_energy_mobile/core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:exup_energy_mobile/features/auth/auth.dart';
import 'package:exup_energy_mobile/features/user/user.dart';
import 'package:exup_energy_mobile/core/widgets/widgets.dart';
import '../widgets/molecules/profile_option_tile.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<UserBloc, UserState>(
      listener: _userListener,
      child: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          // 1. CREAMOS UNA REFERENCIA SEGURA AL USUARIO
          // Si el estado es AuthSuccess, "user" tendrá los datos. Si no, será null.
          final user = (state is AuthSuccess) ? state.user : null;

          // 2. CONFIGURAMOS LAS VARIABLES BASÁNDONOS EN "user"
          final String name = user?.name ?? "Invitado";
          final String email = user?.email ?? "Inicia sesión para ver más";
          final bool isGuest = user == null;

          return Scaffold(
            body: SingleChildScrollView(
              child: Column(
                children: [
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
                        _sectionHeader(context, "Mi Configuración"),
                        const SizedBox(height: AppTheme.paddingM),

                        ProfileOptionTile(
                          icon: Icons.person_outline_rounded,
                          title: "Información Personal",
                          subtitle: name,
                          onTap: isGuest
                              ? () {}
                              : () => _showEditName(context, name),
                        ),

                        ProfileOptionTile(
                          icon: Icons.local_gas_station_outlined,
                          title: "Combustible Preferido",
                          // 3. USAMOS LA VARIABLE SEGURA AQUÍ TAMBIÉN
                          subtitle: (user?.preferredFuelTypeId == null)
                              ? "Selecciona tu combustible"
                              : _getFuelNameById(user!.preferredFuelTypeId!),
                          onTap: isGuest
                              ? () {}
                              : () => _showFuelPicker(context, name),
                        ),

                        ProfileOptionTile(
                          icon: Icons.favorite_border_rounded,
                          title: "Mis Gasolineras Favoritas",
                          subtitle: "Acceso rápido a tus ahorros",
                          onTap: () {},
                        ),

                        const SizedBox(height: AppTheme.paddingL),
                        _sectionHeader(context, "Seguridad y App"),
                        const SizedBox(height: AppTheme.paddingM),

                        ProfileOptionTile(
                          icon: Icons.notifications_none_rounded,
                          title: "Notificaciones",
                          onTap: () {},
                        ),
                        ProfileOptionTile(
                          icon: Icons.dark_mode_outlined,
                          title: "Modo Oscuro",
                          trailing: Switch(
                            value:
                                Theme.of(context).brightness == Brightness.dark,
                            onChanged: (v) {
                              // Lógica de tema
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

  // --- COMPONENTES PRIVADOS ---
  Widget _sectionHeader(BuildContext context, String title) {
    return BrandText.caption(
      title.toUpperCase(),
      fontWeight: FontWeight.bold,
      color: Theme.of(context).colorScheme.primary,
    );
  }

  // --- MODALES (Usando UiUtils) ---
  void _showEditName(BuildContext context, String currentName) {
    final controller = TextEditingController(text: currentName);
    UiUtils.showCustomModal(
      context: context,
      title: "Información Personal",
      child: Column(
        children: [
          CustomTextField(
            controller: controller,
            label: "Nombre",
            hint: "Tu nombre",
          ),
          const SizedBox(height: AppTheme.paddingL),
          PrimaryButton(
            text: "Guardar",
            onPressed: () {
              context.read<UserBloc>().add(
                UpdateProfileSubmitted(name: controller.text.trim()),
              );
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }

  void _showFuelPicker(BuildContext context, String currentName) {
    UiUtils.showCustomModal(
      context: context,
      title: "Combustible",
      subtitle: "Empieza a escribir para encontrar tu combustible.",
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Autocomplete<Map<String, dynamic>>(
            displayStringForOption: (option) => option['name'],
            optionsBuilder: (TextEditingValue textEditingValue) {
              if (textEditingValue.text.isEmpty) {
                return const Iterable<Map<String, dynamic>>.empty();
              }
              return FuelConstants.allFuels.where(
                (fuel) => fuel['name'].toString().toLowerCase().contains(
                  textEditingValue.text.toLowerCase(),
                ),
              );
            },
            onSelected: (selection) {
              context.read<UserBloc>().add(
                UpdateProfileSubmitted(
                  name: currentName,
                  preferredFuelTypeId: selection['id'],
                ),
              );
              Navigator.pop(context);
            },
            fieldViewBuilder:
                (context, controller, focusNode, onFieldSubmitted) {
                  return CustomTextField(
                    controller: controller,
                    focusNode:
                        focusNode, // Importante para la gestión del teclado
                    label: "Tipo de combustible",
                    hint: "Ej: Diesel, Gasolina, GLP...",
                    prefixIcon: Icons.search_rounded,
                  );
                },
            optionsViewBuilder: (context, onSelected, options) {
              // Esto controla cómo se ve la lista desplegable
              return Align(
                alignment: Alignment.topLeft,
                child: Material(
                  elevation: 8,
                  borderRadius: BorderRadius.circular(AppTheme.radiusM),
                  color: Theme.of(context).colorScheme.surface,
                  child: Container(
                    width:
                        MediaQuery.of(context).size.width -
                        (AppTheme.paddingL * 2),
                    constraints: const BoxConstraints(maxHeight: 250),
                    child: ListView.builder(
                      padding: EdgeInsets.zero,
                      shrinkWrap: true,
                      itemCount: options.length,
                      itemBuilder: (context, index) {
                        final option = options.elementAt(index);
                        return ListTile(
                          title: BrandText.body(
                            option['name'],
                            fontWeight: FontWeight.w500,
                          ),
                          trailing: const Icon(
                            Icons.add_circle_outline_rounded,
                            size: 18,
                          ),
                          onTap: () => onSelected(option),
                        );
                      },
                    ),
                  ),
                ),
              );
            },
          ),
          const SizedBox(height: AppTheme.paddingL),
        ],
      ),
    );
  }

  String _getFuelNameById(int id) {
    // Buscamos en la lista completa para asegurar que cubrimos cualquier ID
    final fuel = FuelConstants.allFuels.firstWhere(
      (f) => f['id'] == id,
      orElse: () => {'name': 'Combustible'},
    );
    return fuel['name'];
  }
}
