import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get_it/get_it.dart';

// Importaciones de Features y Core
import 'package:exup_energy_mobile/core/core.dart';
import 'package:exup_energy_mobile/features/auth/auth.dart';
import 'package:exup_energy_mobile/features/gas_stations/gas_stations.dart';
import 'package:exup_energy_mobile/features/user/user.dart';

final sl = GetIt.instance; // sl = Service Locator

Future<void> init() async {
  // ---------------------------------------------------------------------------
  // //! 1. EXTERNAL & CORE (Los cimientos)
  // ---------------------------------------------------------------------------
  
  // Preferencias persistentes simples (Modo oscuro, etc.)
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);

  // Almacenamiento seguro (Tokens JWT)
  sl.registerLazySingleton(() => const FlutterSecureStorage());

  // Servicios de Hardware y Sistema
  sl.registerLazySingleton(() => ImagePickerService());
  sl.registerLazySingleton(() => LocationService());

  // Red (Dio) - Depende de AuthLocalDataSource para interceptar el token
  sl.registerLazySingleton<Dio>(() => getDio(sl<AuthLocalDataSource>()));

  // ---------------------------------------------------------------------------
  // //! 2. FEATURE - USER (Gestión de perfil y Tema)
  // ---------------------------------------------------------------------------

  // Presentation (Blocs/Cubits)
  sl.registerFactory(() => UserBloc(
        userRepository: sl(),
        uploadProfilePictureUseCase: sl(),
      ));
  sl.registerFactory(() => ThemeCubit(sl()));

  // Use Cases
  sl.registerLazySingleton(() => GetUserProfileUseCase(sl()));
  sl.registerLazySingleton(() => UploadProfilePictureUseCase(sl()));

  // Repository & DataSources
  sl.registerLazySingleton<UserRepository>(
    () => UserRepositoryImpl(remoteDataSource: sl()),
  );
  sl.registerLazySingleton<UserRemoteDataSource>(
    () => UserRemoteDataSourceImpl(dio: sl()),
  );

  // ---------------------------------------------------------------------------
  // //! 3. FEATURE - AUTH (Seguridad y Sesión)
  // ---------------------------------------------------------------------------

  // Presentation
  sl.registerFactory(() => AuthBloc(
        loginUseCase: sl(),
        registerUseCase: sl(),
        logoutUseCase: sl(),
        getUserProfileUseCase: sl(),
        getFuelTypesUseCase: sl(),
      ));

  // Use Cases
  sl.registerLazySingleton(() => LoginUseCase(sl()));
  sl.registerLazySingleton(() => RegisterUseCase(sl()));
  sl.registerLazySingleton(() => LogoutUseCase(sl()));

  // Repository & DataSources
  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(remoteDataSource: sl(), localDataSource: sl()),
  );
  sl.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(dio: sl()),
  );
  sl.registerLazySingleton<AuthLocalDataSource>(
    () => AuthLocalDataSourceImpl(storage: sl()),
  );

  // ---------------------------------------------------------------------------
  // //! 4. FEATURE - GAS STATIONS (Negocio principal)
  // ---------------------------------------------------------------------------

  // Presentation
  sl.registerFactory(() => StationsBloc(
        getNearbyStationsUseCase: sl(),
        locationService: sl(),
      ));

  // Use Cases
  sl.registerLazySingleton(() => GetFuelTypesUseCase(sl()));
  sl.registerLazySingleton(() => GetNearbyStationsUseCase(sl()));

  // Repository & DataSources
  sl.registerLazySingleton<StationRepository>(
    () => StationRepositoryImpl(remoteDataSource: sl()),
  );
  sl.registerLazySingleton<StationRemoteDataSource>(
    () => StationRemoteDataSourceImpl(dio: sl()),
  );
}