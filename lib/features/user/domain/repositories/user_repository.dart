import 'package:dartz/dartz.dart';
import 'package:exup_energy_mobile/core/error/failures.dart';
import 'package:exup_energy_mobile/features/auth/domain/entities/user_entity.dart';

abstract class UserRepository {
  Future<Either<Failure, UserEntity>> getMe();
}

