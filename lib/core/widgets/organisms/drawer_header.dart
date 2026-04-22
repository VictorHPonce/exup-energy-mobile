import 'package:flutter/material.dart';
import 'package:exup_energy_mobile/core/theme/app_theme.dart';
import '../atoms/brand_text.dart';

class CustomDrawerHeader extends StatelessWidget {
  final String name;
  final String email;
  final bool isGuest;

  const CustomDrawerHeader({
    super.key,
    required this.name,
    required this.email,
    required this.isGuest,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(
        AppTheme.paddingL, 
        AppTheme.headerPaddingTop, 
        AppTheme.paddingL, 
        AppTheme.paddingL
      ),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            colorScheme.primary,
            colorScheme.primaryContainer,
          ],
        ),
        borderRadius: const BorderRadius.only(
          bottomRight: Radius.circular(AppTheme.headerRadius)
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: AppTheme.avatarOuterRadius,
            backgroundColor: colorScheme.onPrimary.withValues(alpha: 0.2),
            child: CircleAvatar(
              radius: AppTheme.avatarInnerRadius,
              backgroundColor: colorScheme.surface,
              child: Icon(
                isGuest ? Icons.person_outline : Icons.person,
                size: AppTheme.avatarOuterRadius,
                color: colorScheme.primary,
              ),
            ),
          ),
          const SizedBox(height: AppTheme.paddingM),
          BrandText.header(name, color: colorScheme.onPrimary),
          BrandText.caption(
            email, 
            color: colorScheme.onPrimary.withValues(alpha: 0.8),
          ),
        ],
      ),
    );
  }
}