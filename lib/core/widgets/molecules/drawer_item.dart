import 'package:flutter/material.dart';
import 'package:exup_energy_mobile/core/theme/app_theme.dart';

class DrawerItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;
  final Color? color;

  const DrawerItem({
    super.key,
    required this.icon,
    required this.label,
    required this.onTap,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    final dynamicColor = color ?? colorScheme.onSurface;

    return ListTile(
      leading: Icon(
        icon, 
        color: dynamicColor, 
        size: AppTheme.iconSizeM, 
      ),
      title: Text(
        label,
        style: TextStyle(
          color: dynamicColor,
          fontWeight: FontWeight.w500,
          fontSize: 16,
        ),
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: AppTheme.paddingM),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppTheme.radiusS),
      ),
      onTap: onTap,
    );
  }
}