import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart'; // <--- EL FIX: Importa esto
import '../atoms/brand_text.dart'; // <--- Usa tus átomos

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
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
            decoration: const BoxDecoration(color: Colors.blueAccent),
            accountName: const BrandText.body("Usuario ExUp", color: Colors.white),
            accountEmail: const BrandText.caption("usuario@energy.com", color: Colors.white70),
            currentAccountPicture: const CircleAvatar(
              backgroundColor: Colors.white,
              child: Icon(Icons.person, color: Colors.blueAccent),
            ),
          ),
          
          // Items del menú (Moléculas de navegación)
          _DrawerItem(
            icon: Icons.home_rounded,
            label: 'Inicio',
            onTap: () => Navigator.pop(context),
          ),
          _DrawerItem(
            icon: Icons.map_rounded,
            label: 'Mapa de Estaciones',
            onTap: () {
              // Lógica de navegación futura
            },
          ),
          
          const Spacer(),
          const Divider(),
          
          // Item de cierre de sesión
          _DrawerItem(
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

// Una molécula privada para no repetir estilos de ListTile
class _DrawerItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;
  final Color? color;

  const _DrawerItem({
    required this.icon,
    required this.label,
    required this.onTap,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, color: color ?? Colors.black87),
      title: Text(
        label,
        style: TextStyle(
          color: color ?? Colors.black87,
          fontWeight: FontWeight.w500,
        ),
      ),
      onTap: onTap,
    );
  }
}