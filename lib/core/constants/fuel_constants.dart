import 'package:exup_energy_mobile/core/core.dart';

class FuelConstants {
  // Solo guardamos los NOMBRES que queremos filtrar como "comunes"
  static const List<String> commonFuelNames = [
    'Gasolina 95 E5',
    'Gasóleo A',
    'GLP',
    'GNC',
  ];

  // Esta función filtrará la lista que viene de la API por esos nombres
  static List<FuelTypeModel> getCommonFuels(List<FuelTypeModel> allFuelsFromApi) {
    return allFuelsFromApi
        .where((fuel) => commonFuelNames.contains(fuel.name))
        .toList();
  }
}