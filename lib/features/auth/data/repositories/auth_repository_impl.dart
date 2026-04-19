import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../domain/entities/user_entity.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_remote_data_source.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;

  AuthRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, UserEntity>> login(String email, String password) async {
    try {
      // Llamamos al data source (que nos devuelve un UserModel)
      final userModel = await remoteDataSource.login(email, password);
      
      // Devolvemos el modelo (que al heredar de UserEntity es válido) envuelto en Right
      return Right(userModel);
    } catch (e) {
      // Si el data source lanza una excepción, la capturamos y devolvemos un Failure
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, UserEntity>> register(String email, String password, String name) async {
    // Aquí implementarías la lógica de registro similar al login más adelante
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, void>> logout() async {
    // Lógica para borrar tokens, etc.
    throw UnimplementedError();
  }
}