import 'dart:io';
import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:exup_energy_mobile/features/auth/data/datasources/auth_local_data_source.dart';
import 'auth_interceptor.dart';

Dio getDio(AuthLocalDataSource authLocalDataSource) {

  const String baseUrl = String.fromEnvironment(
    'API_URL', 
    defaultValue: 'https://placeholder-api.com/api', 
  );
  
  Dio dio = Dio(BaseOptions(
    baseUrl: baseUrl,
    connectTimeout: const Duration(seconds: 10),
    receiveTimeout: const Duration(seconds: 10),
    contentType: 'application/json',
  ));

  dio.interceptors.add(
    AuthInterceptor(authLocalDataSource: authLocalDataSource, dio: dio),
  );
  
  (dio.httpClientAdapter as IOHttpClientAdapter).createHttpClient = () {
    HttpClient client = HttpClient();
    client.badCertificateCallback = (X509Certificate cert, String host, int port) => true;
    return client;
  };
  
  return dio;
}