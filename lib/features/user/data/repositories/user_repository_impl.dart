import 'package:dartz/dartz.dart';
import 'package:exup_energy_mobile/core/error/failures.dart';
import 'package:exup_energy_mobile/features/auth/domain/entities/user_entity.dart';
import 'package:exup_energy_mobile/features/user/user.dart';

class UserRepositoryImpl implements UserRepository {
  final UserRemoteDataSource remoteDataSource;

  UserRepositoryImpl({required this.remoteDataSource});

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