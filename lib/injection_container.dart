import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'core/network/dio_client.dart';
import 'package:exup_energy_mobile/features/auth/auth.dart';
import 'package:exup_energy_mobile/features/gas_stations/gas_stations.dart';
import 'core/services/location_service.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

final sl = GetIt.instance; // sl = Service Locator

Future<void> init() async {
  //! Features - Auth
  
  // Blocs (Es mejor registrarlos arriba o abajo, pero mantén el orden)
  sl.registerFactory(() => AuthBloc(
    loginUseCase: sl(), 
    registerUseCase: sl(),
    logoutUseCase: sl(),
  ));

  // Use cases 
  sl.registerLazySingleton(() => LoginUseCase(sl()));
  sl.registerLazySingleton(() => RegisterUseCase(sl()));
  sl.registerLazySingleton(() => LogoutUseCase(sl()));

  // Repository
  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(remoteDataSource: sl(), localDataSource: sl()),
  );

  // Data sources
  sl.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(dio: sl()),
  );

  sl.registerLazySingleton<AuthLocalDataSource>(
    () => AuthLocalDataSourceImpl(storage: sl()),
  );

  //! Core
  //Registro de Secure Storage
  sl.registerLazySingleton(() => const FlutterSecureStorage());

  // MODIFICADO: Ahora getDio recibe el localDataSource para el interceptor
  sl.registerLazySingleton<Dio>(() => getDio(sl<AuthLocalDataSource>()));

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