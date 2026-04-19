import 'package:dio/dio.dart';
import '../models/user_model.dart';

abstract class AuthRemoteDataSource {
  Future<UserModel> login(String email, String password);
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final Dio dio;

  // Reemplaza esto con la IP que sacaste en el paso anterior
  static const String baseUrl = "https://192.168.1.130:7161/api";

  AuthRemoteDataSourceImpl({required this.dio});

  @override
  Future<UserModel> login(String email, String password) async {
    try {
      final response = await dio.post(
        '$baseUrl/auth/login',
        data: {
          'email': email,
          'password': password,
        },
      );

      if (response.statusCode == 200) {
        return UserModel.fromJson(response.data);
      } else {
        throw Exception("Error en el login");
      }
    } on DioException catch (e) {
      // Si el backend devuelve un 401, Dio lanza una excepción
      throw Exception(e.response?.data['error'] ?? "Error de servidor");
    }
  }
}