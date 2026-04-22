import 'package:dartz/dartz.dart';
import 'package:exup_energy_mobile/core/error/failures.dart';
import 'package:exup_energy_mobile/features/auth/domain/entities/user_entity.dart';
import 'package:exup_energy_mobile/features/user/user.dart';

class UserRepositoryImpl implements UserRepository {
  final UserRemoteDataSource remoteDataSource;

  UserRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, void>> updateProfile(
    String name,
    int? fuelTypeId,
  ) async {
    try {
      await remoteDataSource.updateProfile(name, fuelTypeId);
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> addFavorite(int stationId) async {
    try {
      await remoteDataSource.addFavorite(stationId);
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> removeFavorite(int stationId) async {
    try {
      await remoteDataSource.removeFavorite(stationId);
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, UserEntity>> getMe() async {
    try {
      final userModel = await remoteDataSource.getMe();
      return Right(userModel);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
