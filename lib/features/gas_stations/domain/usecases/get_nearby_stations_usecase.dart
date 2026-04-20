import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/station_entity.dart';
import '../repositories/station_repository.dart';

class GetNearbyStationsUseCase {
  final StationRepository repository;

  GetNearbyStationsUseCase(this.repository);

  Future<Either<Failure, List<StationEntity>>> execute({
    required double lat,
    required double lon,
    double radius = 5.0,
  }) async {
    return await repository.getNearbyStations(
      latitude: lat,
      longitude: lon,
      radius: radius,
    );
  }
}