import 'package:exup_energy_mobile/features/gas_stations/presentation/bloc/stations_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/widgets/organisms/custom_drawer.dart';
import '../../../gas_stations/presentation/pages/gas_stations_page.dart';
import '../../../gas_stations/presentation/bloc/stations_event.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  // Usamos una función para obtener las páginas.
  // Esto asegura que GasStationsPage mantenga su estado dentro del IndexedStack.
  final List<Widget> _pages = [
    const GasStationsPage(),
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
              // Refresco manual desde la AppBar
              context.read<StationsBloc>().add(
                const FetchNearbyStations(lat: 0.0, lon: 0.0),
              );
            },
          ),
        ],
      ),
      drawer: const CustomDrawer(),
      body: IndexedStack(index: _selectedIndex, children: _pages),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) => setState(() => _selectedIndex = index),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.local_gas_station),
            label: 'Estaciones',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.bolt), label: 'Cargar'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Perfil'),
        ],
      ),
    );
  }
}
