import 'package:equatable/equatable.dart';

class FuelPriceEntity extends Equatable {
  final String fuelName;
  final double price;
  final DateTime lastUpdate;

  const FuelPriceEntity({
    required this.fuelName,
    required this.price,
    required this.lastUpdate,
  });

  @override
  List<Object?> get props => [fuelName, price, lastUpdate];
}

class StationEntity extends Equatable {
  final int id;
  final String externalId;
  final String name;
  final String address;
  final double distance;
  final String brandName;
  final double latitude;
  final double longitude;
  final List<FuelPriceEntity> prices;

  const StationEntity({
    required this.id,
    required this.externalId,
    required this.name,
    required this.address,
    required this.distance,
    required this.brandName,
    required this.latitude,
    required this.longitude,
    required this.prices,
  });

  @override
  List<Object?> get props => [id, externalId, name, distance, prices];
}