import 'package:dio/dio.dart';
import '../models/user_model.dart';

abstract class AuthRemoteDataSource {
  Future<UserModel> login(String email, String password);
  Future<UserModel> register(String name, String email, String password);
  Future<UserModel> refreshToken(String expiredToken, String refreshToken);
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final Dio dio;
  // static const String baseUrl = "https://192.168.1.130:7161/api";

  AuthRemoteDataSourceImpl({required this.dio});

  @override
  Future<UserModel> register(String name, String email, String password) async {
    try {
      final response = await dio.post(
        '/auth/register',
        data: {
          'name': name,
          'email': email,
          'password': password,
        },
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return UserModel.fromJson(response.data);
      } else {
        throw Exception("Error en el registro");
      }
    } on DioException catch (e) {
      throw Exception(e.response?.data['message'] ?? "Error de servidor en registro");
    }
  }

  @override
  Future<UserModel> login(String email, String password) async {
    try {
      final response = await dio.post(
        '/auth/login',
        data: {'email': email, 'password': password},
      );

      if (response.statusCode == 200) {
        return UserModel.fromJson(response.data);
      } else {
        throw Exception("Error en el login");
      }
    } on DioException catch (e) {
      throw Exception(e.response?.data['message'] ?? "Error de servidor");
    }
  }

  @override
  Future<UserModel> refreshToken(String expiredToken, String refreshToken) async {
    try {
      final response = await dio.post('/auth/refresh-token', data: {
        'expiredToken': expiredToken,
        'refreshToken': refreshToken,
      });

      return UserModel.fromJson(response.data);
    } catch (e) {
      throw Exception("No se pudo refrescar el token");
    }
  }
}