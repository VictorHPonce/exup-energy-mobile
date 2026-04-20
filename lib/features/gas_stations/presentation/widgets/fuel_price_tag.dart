import 'package:flutter/material.dart';
import '../../../../core/widgets/atoms/brand_text.dart';

class FuelPriceTag extends StatelessWidget {
  final String fuelName;
  final double price;

  const FuelPriceTag({super.key, required this.fuelName, required this.price});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Column(
        children: [
          BrandText.body(fuelName, fontSize: 10), // Usamos tu átomo
          const SizedBox(height: 4),
          Text(
            '${price.toStringAsFixed(3)}€',
            style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.green),
          ),
        ],
      ),
    );
  }
}