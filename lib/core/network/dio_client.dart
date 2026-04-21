import 'dart:io';
import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:exup_energy_mobile/features/auth/data/datasources/auth_local_data_source.dart';
import 'auth_interceptor.dart';

Dio getDio(AuthLocalDataSource authLocalDataSource) {
  Dio dio = Dio(BaseOptions(
    baseUrl: 'https://192.168.1.130:7161/api', 
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