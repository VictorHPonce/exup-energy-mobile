import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../atoms/brand_text.dart';
import '../molecules/drawer_item.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Drawer(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(20),
          bottomRight: Radius.circular(20),
        ),
      ),
      child: Column(
        children: [
          // Cabecera estilizada
          UserAccountsDrawerHeader(
            decoration: BoxDecoration(color: theme.primaryColor),
            accountName: const BrandText.body("Usuario ExUp", color: Colors.white),
            accountEmail: const BrandText.caption("usuario@energy.com", color: Colors.white70),
            currentAccountPicture: const CircleAvatar(
              backgroundColor: Colors.white,
              child: Icon(Icons.person, color: Colors.blueAccent),
            ),
          ),
          
          // Cuerpo del Drawer con scroll si es necesario
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                DrawerItem(
                  icon: Icons.home_rounded,
                  label: 'Inicio',
                  onTap: () => Navigator.pop(context),
                ),
                DrawerItem(
                  icon: Icons.map_rounded,
                  label: 'Mapa de Estaciones',
                  onTap: () {
                    // Lógica futura: Navigator.pop(context) y luego navegar
                  },
                ),
              ],
            ),
          ),
          
          const Divider(),
          
          // Item de cierre de sesión al final
          DrawerItem(
            icon: Icons.logout_rounded,
            label: 'Cerrar Sesión',
            color: Colors.redAccent,
            onTap: () => context.go('/welcome'),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}