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
      margin: const EdgeInsets.only(bottom: AppTheme.paddingS),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppTheme.radiusM),
        child: Padding(
          padding: const EdgeInsets.all(AppTheme.paddingM),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // --- CABECERA ---
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: BrandText.header(
                      station.name, 
                      fontSize: 18,
                      overflow: TextOverflow.ellipsis, 
                    )
                  ),
                  const SizedBox(width: AppTheme.paddingS),
                  BrandText.caption(
                    _formatDistance(station.distance),
                    fontWeight: FontWeight.bold,
                    color: colorScheme.primary,
                  ),
                ],
              ),
              const SizedBox(height: 4),
              
              // --- DIRECCIÓN ---
              BrandText.body(
                station.address, 
                fontSize: 13, 
                color: Colors.grey[600],
              ),
              const SizedBox(height: AppTheme.paddingM),
              
              // --- PRECIOS Y NAVEGACIÓN ---
              Row(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      physics: const BouncingScrollPhysics(),
                      child: Row(
                        children: station.prices.map((p) => Padding(
                          padding: const EdgeInsets.only(right: AppTheme.paddingS),
                          child: FuelPriceTag(fuelName: p.fuelName, price: p.price),
                        )).toList(),
                      ),
                    ),
                  ),
                  const SizedBox(width: AppTheme.paddingS),
                  
                  // BOTÓN DE NAVEGACIÓN USANDO UIUTILS
                  _NavigationAction(
                    lat: station.latitude,
                    lon: station.longitude,
                  ),
                ],
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

class _NavigationAction extends StatelessWidget {
  final double lat;
  final double lon;

  const _NavigationAction({required this.lat, required this.lon});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primaryContainer.withValues(alpha: 0.4),
        borderRadius: BorderRadius.circular(AppTheme.radiusS),
      ),
      child: IconButton(
        visualDensity: VisualDensity.compact,
        icon: Icon(
          Icons.directions_outlined, 
          color: Theme.of(context).colorScheme.primary,
          size: 20,
        ),
        onPressed: () => UiUtils.openNavigationMap(lat, lon),
        tooltip: 'Cómo llegar',
      ),
    );
  }
}