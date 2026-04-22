import 'package:dio/dio.dart';
import 'package:exup_energy_mobile/features/auth/data/models/user_model.dart';

abstract class UserRemoteDataSource {
  Future<UserModel> getMe();
  Future<void> addFavorite(int stationId);
  Future<void> removeFavorite(int stationId);
  Future<void> updateProfile(String name, int? fuelTypeId);
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
    await dio.put('/user/me', data: {
      'name': name,
      'preferredFuelTypeId': fuelTypeId,
    });
  }
}