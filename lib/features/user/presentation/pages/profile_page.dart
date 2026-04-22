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
                          subtitle: (user?.preferredFuelTypeId == null)
                              ? "Selecciona tu combustible"
                              : _getFuelNameById(
                                  context,
                                  user!.preferredFuelTypeId!,
                                ),
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
    // 1. Obtenemos la lista completa del AuthBloc (que viene de .NET)
    final fuelsFromApi = context.read<AuthBloc>().allFuels;

    // 2. Filtramos los comunes usando tu nueva constante (por nombre, no por ID)
    final commonFuels = FuelConstants.getCommonFuels(fuelsFromApi);

    final colorScheme = Theme.of(context).colorScheme;

    UiUtils.showCustomModal(
      context: context,
      title: "Combustible",
      subtitle: "Selecciona un acceso rápido o busca tu combustible.",
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // --- SECCIÓN DE ACCESOS RÁPIDOS ---
          if (commonFuels.isNotEmpty) ...[
            _sectionHeader(context, "Más usados"),
            const SizedBox(height: AppTheme.paddingS),
            Wrap(
              spacing: 8,
              runSpacing: 0,
              children: commonFuels
                  .map(
                    (fuel) => ActionChip(
                      label: Text(fuel.name),
                      labelStyle: TextStyle(
                        color: colorScheme.onPrimaryContainer,
                        fontSize: 12,
                      ),
                      backgroundColor: colorScheme.primaryContainer.withValues(
                        alpha: 0.4,
                      ),
                      side: BorderSide.none,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(AppTheme.radiusM),
                      ),
                      onPressed: () {
                        context.read<UserBloc>().add(
                          UpdateProfileSubmitted(
                            name: currentName,
                            preferredFuelTypeId: fuel.id,
                          ),
                        );
                        Navigator.pop(context);
                      },
                    ),
                  )
                  .toList(),
            ),
            const SizedBox(height: AppTheme.paddingL),
            const Divider(),
            const SizedBox(height: AppTheme.paddingM),
          ],

          // --- TU AUTOCOMPLETE ORIGINAL (CON LA LISTA DINÁMICA) ---
          _sectionHeader(context, "Todos los tipos"),
          const SizedBox(height: AppTheme.paddingS),
          Autocomplete<FuelTypeModel>(
            displayStringForOption: (option) => option.name,
            optionsBuilder: (textEditingValue) {
              if (textEditingValue.text.isEmpty) return const Iterable.empty();
              return fuelsFromApi.where(
                (fuel) => fuel.name.toLowerCase().contains(
                  textEditingValue.text.toLowerCase(),
                ),
              );
            },
            onSelected: (selection) {
              context.read<UserBloc>().add(
                UpdateProfileSubmitted(
                  name: currentName,
                  preferredFuelTypeId: selection.id,
                ),
              );
              Navigator.pop(context);
            },
            fieldViewBuilder:
                (context, controller, focusNode, onFieldSubmitted) {
                  return CustomTextField(
                    controller: controller,
                    focusNode: focusNode,
                    label: "Tipo de combustible",
                    hint: "Ej: Diesel, Gasolina, GLP...",
                    prefixIcon: Icons.search_rounded,
                  );
                },
            optionsViewBuilder: (context, onSelected, options) {
              return Align(
                alignment: Alignment.topLeft,
                child: Material(
                  elevation: 8,
                  borderRadius: BorderRadius.circular(AppTheme.radiusM),
                  color: colorScheme.surface,
                  child: Container(
                    // Ajuste de ancho para que no se salga de la pantalla
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
                            option.name,
                            fontWeight: FontWeight.w500,
                          ),
                          trailing: Icon(
                            Icons.add_circle_outline_rounded,
                            size: 18,
                            color: colorScheme.primary,
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

  String _getFuelNameById(BuildContext context, int id) {
    final fuels = context.read<AuthBloc>().allFuels;

    if (fuels.isEmpty)
      return "Cargando..."; // Feedback mientras descarga de .NET

    final fuel = fuels.firstWhere(
      (f) => f.id == id,
      orElse: () => FuelTypeModel(id: 0, name: 'Personalizado'),
    );

    return fuel.name;
  }
}
