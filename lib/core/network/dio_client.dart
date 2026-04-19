import 'dart:io';
import 'package:dio/dio.dart';
import 'package:dio/io.dart';

Dio getDio() {
  Dio dio = Dio();
  
  // Este bloque permite conectar a HTTPS aunque el certificado sea auto-firmado
  (dio.httpClientAdapter as IOHttpClientAdapter).createHttpClient = () {
    HttpClient client = HttpClient();
    client.badCertificateCallback = (X509Certificate cert, String host, int port) => true;
    return client;
  };
  
  return dio;
}