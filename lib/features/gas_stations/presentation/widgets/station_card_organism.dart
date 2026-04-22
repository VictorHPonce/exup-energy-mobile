import 'package:flutter/material.dart';
import 'package:exup_energy_mobile/core/core.dart';
import 'package:exup_energy_mobile/core/widgets/widgets.dart';
import '../../domain/entities/station_entity.dart';
import 'fuel_price_tag.dart';

class StationCard extends StatelessWidget {
  final StationEntity station;
  final VoidCallback? onTap;

  const StationCard({super.key, required this.station, this.onTap});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Card(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppTheme.radiusM),
        child: Padding(
          padding: const EdgeInsets.all(AppTheme.paddingM),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(child: BrandText.header(station.name, fontSize: 18)),
                  BrandText.caption(
                    _formatDistance(station.distance),
                    fontWeight: FontWeight.bold,
                    color: colorScheme.primary,
                  ),
                ],
              ),
              const SizedBox(height: 4),
              BrandText.body(station.address, fontSize: 13),
              const SizedBox(height: AppTheme.paddingM),
              
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: station.prices.map((p) => Padding(
                    padding: const EdgeInsets.only(right: AppTheme.paddingS),
                    child: FuelPriceTag(fuelName: p.fuelName, price: p.price),
                  )).toList(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _formatDistance(double distanceInKm) {
    if (distanceInKm < 1) return '${(distanceInKm * 1000).toStringAsFixed(0)} m';
    return '${distanceInKm.toStringAsFixed(1)} km';
  }
}