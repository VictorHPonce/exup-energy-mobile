import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:exup_energy_mobile/core/error/failures.dart';
import 'package:exup_energy_mobile/features/auth/domain/entities/user_entity.dart';

abstract class UserRepository {
  Future<Either<Failure, UserEntity>> getMe();
  Future<Either<Failure, void>> updateProfile(String name, int? fuelTypeId);
  Future<Either<Failure, void>> addFavorite(int stationId);
  Future<Either<Failure, void>> removeFavorite(int stationId);
  Future<Either<Failure, String>> uploadProfilePicture(File imageFile);
}

