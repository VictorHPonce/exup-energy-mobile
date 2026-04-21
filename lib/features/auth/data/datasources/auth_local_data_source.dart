import 'package:flutter_secure_storage/flutter_secure_storage.dart';

abstract class AuthLocalDataSource {
  Future<void> saveToken(String token);
  Future<String?> getToken();
  Future<void> deleteToken();
  Future<void> saveRefreshToken(String token);
  Future<String?> getRefreshToken();
}

class AuthLocalDataSourceImpl implements AuthLocalDataSource {
  final FlutterSecureStorage storage;
  
  AuthLocalDataSourceImpl({required this.storage});

  @override
  Future<void> saveToken(String token) async => 
      await storage.write(key: 'jwt_token', value: token);

  @override
  Future<String?> getToken() async => 
      await storage.read(key: 'jwt_token');

  @override
  Future<void> deleteToken() async => 
      await storage.deleteAll();

  @override
  Future<void> saveRefreshToken(String token) async => 
      await storage.write(key: 'refresh_token', value: token);

  @override
  Future<String?> getRefreshToken() async => 
      await storage.read(key: 'refresh_token');
}