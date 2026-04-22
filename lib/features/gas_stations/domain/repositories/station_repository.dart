import 'package:dartz/dartz.dart';
import 'package:exup_energy_mobile/core/models/fuel_type_model.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/models/pagination_model.dart';
import '../entities/station_entity.dart';

abstract class StationRepository {
  Future<Either<Failure, PaginationModel<StationEntity>>> getNearbyStations({
    required double latitude,
    required double longitude,
    double radius = 5.0,
    required int page,
  });

  Future<Either<Failure, List<FuelTypeModel>>> getFuelTypes();
}