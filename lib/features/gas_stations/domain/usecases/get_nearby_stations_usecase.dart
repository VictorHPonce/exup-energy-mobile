import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/station_entity.dart';
import '../repositories/station_repository.dart';
import '../../../../core/models/pagination_model.dart';

class GetNearbyStationsUseCase {
  final StationRepository repository;
  GetNearbyStationsUseCase(this.repository);

  Future<Either<Failure, PaginationModel<StationEntity>>> execute({
    required double lat,
    required double lon,
    double radius = 5.0,
    int page = 1,
  }) async {
    return await repository.getNearbyStations(
      latitude: lat,
      longitude: lon,
      radius: radius,
      page: page,
    );
  }
}