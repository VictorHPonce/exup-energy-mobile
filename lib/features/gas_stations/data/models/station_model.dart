import '../../domain/entities/station_entity.dart';

class StationModel extends StationEntity {
  const StationModel({
    required super.id,
    required super.externalId,
    required super.name,
    required super.address,
    required super.distance,
    required super.brandName,
    required super.latitude,
    required super.longitude,
    required super.prices,
  });

  factory StationModel.fromJson(Map<String, dynamic> json) {
    return StationModel(
      id: json['id'] ?? 0,
      externalId: json['externalId'] ?? '',
      name: json['name'] ?? 'Sin nombre',
      address: json['address'] ?? '',
      distance: ((json['distance'] as num?)?.toDouble() ?? 0.0),
      brandName: json['brandName'] ?? 'Genérica',
      latitude: (json['latitude'] as num?)?.toDouble() ?? 0.0,
      longitude: (json['longitude'] as num?)?.toDouble() ?? 0.0,
      prices: (json['prices'] as List?)
              ?.map((p) => FuelPriceModel.fromJson(p))
              .toList() ?? [],
    );
  }
}

class FuelPriceModel extends FuelPriceEntity {
  const FuelPriceModel({
    required super.fuelName,
    required super.price,
    required super.lastUpdate,
  });

  factory FuelPriceModel.fromJson(Map<String, dynamic> json) {
    return FuelPriceModel(
      fuelName: json['fuelName'] ?? '',
      price: (json['price'] as num?)?.toDouble() ?? 0.0,
      lastUpdate: json['lastUpdate'] != null 
          ? DateTime.parse(json['lastUpdate']) 
          : DateTime.now(),
    );
  }
}