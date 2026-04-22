import 'package:dartz/dartz.dart';
import 'package:exup_energy_mobile/core/core.dart';
import 'package:exup_energy_mobile/features/gas_stations/domain/repositories/station_repository.dart';

class GetFuelTypesUseCase {
  final StationRepository repository;
  GetFuelTypesUseCase(this.repository);

  Future<Either<Failure, List<FuelTypeModel>>> execute() async {
    return await repository.getFuelTypes();
  }
}