import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../domain/repositories/station_repository.dart';
import '../../domain/entities/station_entity.dart';
import '../datasources/station_remote_data_source.dart';

class StationRepositoryImpl implements StationRepository {
  final StationRemoteDataSource remoteDataSource;

  StationRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, List<StationEntity>>> getNearbyStations({
    required double latitude,
    required double longitude,
    double radius = 5.0,
  }) async {
    try {
      final remoteStations = await remoteDataSource.getNearbyStations(
        latitude,
        longitude,
        radius,
      );
      return Right(remoteStations);
    } catch (e) {
      // Aquí podrías mapear el error a un ServerFailure
      return Left(ServerFailure(e.toString()));
    }
  }
}