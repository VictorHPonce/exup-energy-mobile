import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'core/network/dio_client.dart';
import 'features/auth/data/datasources/auth_remote_data_source.dart';
import 'features/auth/data/repositories/auth_repository_impl.dart';
import 'features/auth/domain/repositories/auth_repository.dart';
import 'features/auth/domain/usecases/login_usecase.dart';
import 'features/auth/domain/usecases/register_usecase.dart';
import 'features/auth/presentation/bloc/auth_bloc.dart';

final sl = GetIt.instance; // sl = Service Locator

Future<void> init() async {
  //! Features - Auth
  
  // Blocs (Es mejor registrarlos arriba o abajo, pero mantén el orden)
  sl.registerFactory(() => AuthBloc(
    loginUseCase: sl(), 
    registerUseCase: sl(), // Asegúrate de haber inyectado RegisterUseCase abajo
  ));

  // Use cases 
  sl.registerLazySingleton(() => LoginUseCase(sl()));
  sl.registerLazySingleton(() => RegisterUseCase(sl()));

  // Repository
  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(remoteDataSource: sl()),
  );

  // Data sources
  sl.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(dio: sl()),
  );

  //! Core
  // sl() buscará lo que devuelva getDio(). Si getDio devuelve Dio, funcionará.
  sl.registerLazySingleton<Dio>(() => getDio()); 
}