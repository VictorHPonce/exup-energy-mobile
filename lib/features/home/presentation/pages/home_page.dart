import 'package:flutter/material.dart';
import '../../../../core/widgets/organisms/custom_drawer.dart';
import '../../../gas_stations/presentation/pages/gas_stations_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  // Lista de páginas para el BottomNav
  final List<Widget> _pages = [
    const GasStationsPage(), // La pestaña de gasolineras ahora es dinámica
    const Center(child: Text('Pantalla de Carga (Próximamente)')),
    const Center(child: Text('Perfil de Usuario')),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ExUp Energy'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              // Ejemplo de cómo refrescar desde el shell
              // context.read<StationsBloc>().add(...)
            },
          )
        ],
      ),
      drawer: const CustomDrawer(),
      // El body ahora cambia según el índice
      body: IndexedStack(
        index: _selectedIndex,
        children: _pages,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) => setState(() => _selectedIndex = index),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.local_gas_station), label: 'Estaciones'),
          BottomNavigationBarItem(icon: Icon(Icons.bolt), label: 'Cargar'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Perfil'),
        ],
      ),
    );
  }
}