import 'package:flutter/material.dart';
import '../../domain/entities/station_entity.dart';
import 'fuel_price_tag.dart';
import '../../../../core/widgets/atoms/brand_text.dart';

class StationCard extends StatelessWidget {
  final StationEntity station;
  final VoidCallback? onTap;

  const StationCard({super.key, required this.station, this.onTap});

  String _formatDistance(double distanceInKm) {
    if (distanceInKm < 1) {
      return '${(distanceInKm * 1000).toStringAsFixed(0)} m';
    }
    return '${distanceInKm.toStringAsFixed(1)} km';
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 2,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(child: BrandText.header(station.name, fontSize: 18)),
                  Text(
                    _formatDistance(station.distance),
                    style: TextStyle(
                      color: Colors.grey.shade600,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 4),
              BrandText.body(station.address, color: Colors.grey),
              const SizedBox(height: 12),
              // Lista horizontal de precios
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: station.prices
                      .map(
                        (p) => Padding(
                          padding: const EdgeInsets.only(right: 8),
                          child: FuelPriceTag(
                            fuelName: p.fuelName,
                            price: p.price,
                          ),
                        ),
                      )
                      .toList(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
