import 'package:dartz/dartz.dart';
import 'package:exup_energy_mobile/features/auth/data/datasources/auth_local_data_source.dart';
import '../../../../core/error/failures.dart';
import '../../domain/entities/user_entity.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_remote_data_source.dart';


class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;
  final AuthLocalDataSource localDataSource;
  
  AuthRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
  });

  @override
Future<Either<Failure, UserEntity>> login(String email, String password) async {
  try {
    final userModel = await remoteDataSource.login(email, password);
    
    // Ahora userModel.token y userModel.refreshToken ya existen
    if (userModel.token != null && userModel.refreshToken != null) {
      await localDataSource.saveToken(userModel.token!);
      await localDataSource.saveRefreshToken(userModel.refreshToken!);
    }
    
    return Right(userModel);
  } catch (e) {
    // Si usas un logger, este es el lugar para ponerlo
    return Left(ServerFailure(e.toString())); 
  }
}

  @override
  Future<Either<Failure, UserEntity>> register(String name, String email, String password) async {
    try {
      final userModel = await remoteDataSource.register(name, email, password);
      
      // También guardamos tokens tras el registro si tu API los devuelve
      if (userModel.token != null) {
        await localDataSource.saveToken(userModel.token!);
      }
      
      return Right(userModel);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> logout() async {
    try {
      // Limpiamos todo el almacenamiento seguro (JWT, Refresh, UserData)
      await localDataSource.deleteToken();
      return const Right(null);
    } catch (e) {
      return Left(CacheFailure("Error al cerrar sesión localmente"));
    }
  }
}