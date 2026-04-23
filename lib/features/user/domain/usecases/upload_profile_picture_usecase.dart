import 'dart:io';
import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../repositories/user_repository.dart';

class UploadProfilePictureUseCase {
  final UserRepository repository;

  UploadProfilePictureUseCase(this.repository);

  Future<Either<Failure, String>> call(File imageFile) async {
    return await repository.uploadProfilePicture(imageFile);
  }
}