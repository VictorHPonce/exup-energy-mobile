class FuelConstants {
  // Los 4 más usados para acceso rápido
  static const List<Map<String, dynamic>> commonFuels = [
    {'id': 35, 'name': 'Gasolina 95'},
    {'id': 29, 'name': 'Gasolina 98'},
    {'id': 43, 'name': 'Gasóleo A (Diésel)'},
    {'id': 39, 'name': 'GLP'}, // Aquí simplificamos el nombre largo de tu DB
  ];

  // Lista completa para el buscador (Extraída de tu SQL)
  static const List<Map<String, dynamic>> allFuels = [
    {'id': 24, 'name': 'Gas Natural Licuado'},
    {'id': 25, 'name': 'Biodiesel'},
    {'id': 39, 'name': 'GLP'},
    {'id': 43, 'name': 'Gasoleo A'},
    {'id': 46, 'name': 'Diésel Renovable'},
    // ... añade los demás aquí
  ];
}