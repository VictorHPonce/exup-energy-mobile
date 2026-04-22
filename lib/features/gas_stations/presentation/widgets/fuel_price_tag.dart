import 'package:flutter/material.dart';
import 'package:exup_energy_mobile/core/core.dart';
import 'package:exup_energy_mobile/core/widgets/widgets.dart';


class FuelPriceTag extends StatelessWidget {
  final String fuelName;
  final double price;

  const FuelPriceTag({super.key, required this.fuelName, required this.price});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      padding: const EdgeInsets.all(AppTheme.paddingS),
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerHighest.withValues(alpha: 0.5),
        borderRadius: BorderRadius.circular(AppTheme.radiusS),
        border: Border.all(color: colorScheme.outlineVariant),
      ),
      child: Column(
        children: [
          BrandText.body(fuelName, fontSize: 10, fontWeight: FontWeight.bold),
          const SizedBox(height: 4),
          Text(
            '${price.toStringAsFixed(3)}€',
            style: TextStyle(
              fontWeight: FontWeight.bold, 
              color: colorScheme.primary,
            ),
          ),
        ],
      ),
    );
  }
}