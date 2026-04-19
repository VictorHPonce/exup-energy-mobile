import 'package:flutter/material.dart';
import '../../../../core/widgets/organisms/custom_drawer.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ExUp Energy'),
        centerTitle: true,
      ),
      drawer: const CustomDrawer(), // Aquí inyectamos el organismo del menú
      body: const Center(
        child: Text('Bienvenido a la pantalla principal'),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.bolt), label: 'Cargar'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Perfil'),
        ],
      ),
    );
  }
}