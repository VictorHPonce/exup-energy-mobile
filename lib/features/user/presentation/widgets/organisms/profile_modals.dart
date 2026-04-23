import 'package:exup_energy_mobile/core/core.dart';
import 'package:exup_energy_mobile/core/widgets/atoms/brand_text.dart';
import 'package:exup_energy_mobile/core/widgets/atoms/primary_button.dart';
import 'package:exup_energy_mobile/features/auth/auth.dart';
import 'package:exup_energy_mobile/features/user/presentation/bloc/user_bloc.dart';
import 'package:exup_energy_mobile/features/user/presentation/bloc/user_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileModals {
  static void showEditName(BuildContext context, String currentName) {
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

  // El modal del Fuel Picker que tenías (resumido aquí por espacio)
  static void showFuelPicker(BuildContext context, String currentName) {
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
            UiUtils.sectionHeader(context, "Más usados"),
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
          UiUtils.sectionHeader(context, "Todos los tipos"),
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
  
}
