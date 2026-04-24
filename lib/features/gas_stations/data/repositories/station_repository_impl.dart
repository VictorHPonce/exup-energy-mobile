import 'package:dartz/dartz.dart';
import 'package:exup_energy_mobile/core/models/fuel_type_model.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/models/pagination_model.dart';
import '../../domain/repositories/station_repository.dart';
import '../../domain/entities/station_entity.dart';
import '../datasources/station_remote_data_source.dart';

class StationRepositoryImpl implements StationRepository {
  final StationRemoteDataSource remoteDataSource;

  StationRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, List<FuelTypeModel>>> getFuelTypes() async {
    try {
      final fuels = await remoteDataSource.getFuelTypes();
      return Right(fuels);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, PaginationModel<StationEntity>>> getNearbyStations({
    required double latitude,
    required double longitude,
    double radius = 5.0,
    required int page,
  }) async {
    try {
      final remotePagination = await remoteDataSource.getNearbyStations(
        lat: latitude,
        lon: longitude,
        radius: radius,
        page: page,
      );

      return Right(remotePagination);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
