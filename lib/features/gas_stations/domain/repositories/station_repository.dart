import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/station_entity.dart';

abstract class StationRepository {
  // Siguiendo el endpoint api/GasStation/nearby
  Future<Either<Failure, List<StationEntity>>> getNearbyStations({
    required double latitude,
    required double longitude,
    double radius = 5.0,
  });
}