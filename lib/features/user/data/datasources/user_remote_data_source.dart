import 'dart:io';
import 'package:exup_energy_mobile/core/core.dart';
import 'package:dio/dio.dart';
import 'package:exup_energy_mobile/features/auth/data/models/user_model.dart';

abstract class UserRemoteDataSource {
  Future<UserModel> getMe();
  Future<void> addFavorite(int stationId);
  Future<void> removeFavorite(int stationId);
  Future<void> updateProfile(String name, int? fuelTypeId);
  Future<String> uploadProfilePicture(File imageFile);
}

class UserRemoteDataSourceImpl implements UserRemoteDataSource {
  final Dio dio;
  UserRemoteDataSourceImpl({required this.dio});

  @override
  Future<UserModel> getMe() async {
    final response = await dio.get('/user/me');
    return UserModel.fromJson(response.data);
  }

  @override
  Future<void> addFavorite(int stationId) async {
    await dio.post('/user/favorites/$stationId');
  }

  @override
  Future<void> removeFavorite(int stationId) async {
    await dio.delete('/user/favorites/$stationId');
  }

  @override
  Future<void> updateProfile(String name, int? fuelTypeId) async {
    await dio.put(
      '/user/me',
      data: {'name': name, 'preferredFuelTypeId': fuelTypeId},
    );
  }

  @override
  Future<String> uploadProfilePicture(File imageFile) async {
    try {
      String fileName = imageFile.path.split('/').last;

      FormData formData = FormData.fromMap({
        "file": await MultipartFile.fromFile(
          imageFile.path,
          filename: fileName,
        ),
      });

      final response = await dio.post('/User/upload-image', data: formData);

      if (response.data['isSuccess']) {
        return response.data['value'];
      } else {
        throw ServerException(
          message: response.data['error'] ?? 'Error al subir imagen',
        );
      }
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }
}
