import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'core/network/dio_client.dart';
import 'features/auth/data/datasources/auth_remote_data_source.dart';
import 'features/auth/data/repositories/auth_repository_impl.dart';
import 'features/auth/domain/repositories/auth_repository.dart';
import 'features/auth/domain/usecases/login_usecase.dart';
import 'features/auth/domain/usecases/register_usecase.dart';
import 'features/auth/presentation/bloc/auth_bloc.dart';
import 'features/gas_stations/data/datasources/station_remote_data_source.dart';
import 'features/gas_stations/data/repositories/station_repository_impl.dart';
import 'features/gas_stations/domain/repositories/station_repository.dart';
import 'features/gas_stations/domain/usecases/get_nearby_stations_usecase.dart';
import 'features/gas_stations/presentation/bloc/stations_bloc.dart';
import 'core/services/location_service.dart';
import '../features/gas_stations/presentation/bloc/stations_bloc.dart';

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

  //! Features - Gas Stations

  // 1. Blocs (IMPORTANTE: Registrar como Factory)
sl.registerFactory(() => StationsBloc(getNearbyStationsUseCase: sl(), locationService: sl()));

  // Data sources - Le pasamos el sl<Dio>()
  sl.registerLazySingleton<StationRemoteDataSource>(
    () => StationRemoteDataSourceImpl(dio: sl()),
  );

  // Repositories
  sl.registerLazySingleton<StationRepository>(
    () => StationRepositoryImpl(remoteDataSource: sl()),
  );

  // Use cases
  sl.registerLazySingleton(() => GetNearbyStationsUseCase(sl()));

  sl.registerLazySingleton(() => LocationService());
}