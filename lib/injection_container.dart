import 'package:get_it/get_it.dart';
import 'core/network/dio_client.dart';
import 'features/auth/data/datasources/auth_remote_data_source.dart';
import 'features/auth/data/repositories/auth_repository_impl.dart';
import 'features/auth/domain/repositories/auth_repository.dart';
import 'features/auth/domain/usecases/login_usecase.dart';
import 'features/auth/presentation/bloc/auth_bloc.dart';

final sl = GetIt.instance; // sl = Service Locator

Future<void> init() async {
  //! Features - Auth
  
  // Use cases (Se crean cada vez que se piden)
  sl.registerLazySingleton(() => LoginUseCase(sl()));

  // Repository (Interfaz -> Implementación)
  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(remoteDataSource: sl()),
  );

  // Data sources
  sl.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(dio: sl()),
  );

  //! Core
  sl.registerLazySingleton(() => getDio()); // Tu cliente Dio configurado

  // Blocs (Usamos factory porque los Blocs se cierran al salir de la pantalla)
  sl.registerFactory(() => AuthBloc(loginUseCase: sl()));
}