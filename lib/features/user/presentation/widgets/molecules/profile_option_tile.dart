import 'package:exup_energy_mobile/core/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:exup_energy_mobile/core/core.dart';

class ProfileOptionTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String? subtitle;
  final Widget? trailing;
  final VoidCallback onTap;

  const ProfileOptionTile({
    super.key,
    required this.icon,
    required this.title,
    this.subtitle,
    this.trailing,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      margin: const EdgeInsets.only(bottom: AppTheme.paddingM),
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerHighest.withValues(alpha: 0.3),
        borderRadius: BorderRadius.circular(AppTheme.radiusM),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(
          horizontal: AppTheme.paddingM, 
          vertical: AppTheme.paddingS
        ),
        leading: Container(
          padding: const EdgeInsets.all(AppTheme.paddingS),
          decoration: BoxDecoration(
            color: colorScheme.primary.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(AppTheme.radiusS),
          ),
          child: Icon(icon, color: colorScheme.primary),
        ),
        title: BrandText.body(title, fontWeight: FontWeight.bold),
        subtitle: subtitle != null ? BrandText.caption(subtitle!) : null,
        trailing: trailing ?? Icon(Icons.chevron_right_rounded, color: colorScheme.onSurfaceVariant),
        onTap: onTap,
      ),
    );
  }
}