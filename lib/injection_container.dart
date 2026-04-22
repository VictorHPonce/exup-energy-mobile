import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'core/network/dio_client.dart';
import 'package:exup_energy_mobile/features/auth/auth.dart';
import 'package:exup_energy_mobile/features/gas_stations/gas_stations.dart';
import 'core/services/location_service.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:exup_energy_mobile/features/user/user.dart';

final sl = GetIt.instance; // sl = Service Locator

Future<void> init() async {
  //! 1. CORE & EXTERNAL (Los cimientos)
  sl.registerLazySingleton(() => const FlutterSecureStorage());
  sl.registerLazySingleton<AuthLocalDataSource>(() => AuthLocalDataSourceImpl(storage: sl()));
  
  // Dio depende del localDataSource para el interceptor
  sl.registerLazySingleton<Dio>(() => getDio(sl<AuthLocalDataSource>()));
  sl.registerLazySingleton(() => LocationService());

  //! 2. FEATURE - USER (La nueva pieza del puzzle)
  sl.registerFactory(() => UserBloc(userRepository: sl()));
  
  sl.registerLazySingleton<UserRemoteDataSource>(
    () => UserRemoteDataSourceImpl(dio: sl())
  );
  sl.registerLazySingleton<UserRepository>(
    () => UserRepositoryImpl(remoteDataSource: sl())
  );
  sl.registerLazySingleton(() => GetUserProfileUseCase(sl()));

  //! 3. FEATURE - AUTH
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

  // Bloc (Ahora le pasamos el GetUserProfileUseCase para que pueda cargar el perfil al inicio)
  sl.registerFactory(() => AuthBloc(
    loginUseCase: sl(), 
    registerUseCase: sl(),
    logoutUseCase: sl(),
    getUserProfileUseCase: sl(), // <-- Agregamos esto para el perfil real
  ));

  //! 4. FEATURE - GAS STATIONS
  sl.registerLazySingleton<StationRemoteDataSource>(() => StationRemoteDataSourceImpl(dio: sl()));
  sl.registerLazySingleton<StationRepository>(() => StationRepositoryImpl(remoteDataSource: sl()));
  sl.registerLazySingleton(() => GetNearbyStationsUseCase(sl()));
  sl.registerFactory(() => StationsBloc(getNearbyStationsUseCase: sl(), locationService: sl()));
}