import 'dart:io';
import 'package:dio/dio.dart';
import 'package:dio/io.dart';

Dio getDio() {
  // CONFIGURACIÓN GLOBAL DE DIO
  Dio dio = Dio(BaseOptions(
    // USA TU IP LOCAL. Si usas emulador Android, a veces es 10.0.2.2
    // Pero lo más seguro es tu IP de red (ej. https://192.168.1.50:7161/api)
    baseUrl: 'https://192.168.1.130:7161/api', 
    connectTimeout: const Duration(seconds: 5),
    receiveTimeout: const Duration(seconds: 3),
    contentType: 'application/json',
  ));
  
  (dio.httpClientAdapter as IOHttpClientAdapter).createHttpClient = () {
    HttpClient client = HttpClient();
    // Esto es vital para que acepte el HTTPS de tu PC
    client.badCertificateCallback = (X509Certificate cert, String host, int port) => true;
    return client;
  };
  
  return dio;
}