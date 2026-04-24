import 'package:exup_energy_mobile/core/widgets/atoms/brand_text.dart';
import 'package:flutter/material.dart';
import 'package:exup_energy_mobile/core/core.dart';

class FeaturePlaceholder extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;

  const FeaturePlaceholder({
    super.key,
    required this.title,
    required this.subtitle,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppTheme.paddingL),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(AppTheme.paddingL),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primaryContainer.withValues(alpha: 0.2),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, size: 64, color: Theme.of(context).colorScheme.primary),
          ),
          const SizedBox(height: AppTheme.paddingL),
          BrandText.header(title, textAlign: TextAlign.center),
          const SizedBox(height: AppTheme.paddingS),
          BrandText.body(
            subtitle,
            textAlign: TextAlign.center,
            color: Colors.grey,
          ),
          const SizedBox(height: AppTheme.paddingL * 2), 
          
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.secondaryContainer,
              borderRadius: BorderRadius.circular(100), 
            ),
            child: BrandText.caption(
              'PRÓXIMAMENTE',
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.onSecondaryContainer,
            ),
          ),
        ],
      ),
    );
  }
}