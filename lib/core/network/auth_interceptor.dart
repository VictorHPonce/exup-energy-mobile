import 'package:dio/dio.dart';
import 'package:exup_energy_mobile/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:exup_energy_mobile/injection_container.dart';
import '../../features/auth/data/datasources/auth_local_data_source.dart';

class AuthInterceptor extends Interceptor {
  final AuthLocalDataSource authLocalDataSource;
  final Dio dio;

  AuthInterceptor({required this.authLocalDataSource, required this.dio});

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    // 1. Buscamos el token en el SecureStorage
    final token = await authLocalDataSource.getToken();

    // 2. Si existe, lo inyectamos en la cabecera
    if (token != null) {
      options.headers['Authorization'] = 'Bearer $token';
    }

    return handler.next(options);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    if (err.response?.statusCode == 401) {
      final localDataSource = sl<AuthLocalDataSource>();
      final remoteDataSource = sl<AuthRemoteDataSource>();

      final expiredToken = await localDataSource.getToken();
      final refreshToken = await localDataSource.getRefreshToken();

      if (expiredToken != null && refreshToken != null) {
        try {
          // Llamamos al proceso de refresco (Redis intervendrá en el backend)
          final userModel = await remoteDataSource.refreshToken(
            expiredToken,
            refreshToken,
          );

          // Guardamos los NUEVOS tokens generados por la rotación
          await localDataSource.saveToken(userModel.token!);
          await localDataSource.saveRefreshToken(userModel.refreshToken!);

          // Reintentamos la petición original
          final opts = err.requestOptions;
          opts.headers['Authorization'] = 'Bearer ${userModel.token}';

          final response = await dio.fetch(opts);
          return handler.resolve(response);
        } catch (e) {
          // Si Redis dice que el token no es válido o expiró, logout forzado
          await localDataSource.deleteToken();
          // Aquí podrías usar un EventBus o Stream para avisar a la UI que vaya a Login
        }
      }
    }
    return handler.next(err);
  }
}
