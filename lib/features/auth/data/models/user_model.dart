import '../../domain/entities/user_entity.dart';

class UserModel extends UserEntity {
  final String? token;
  final String? refreshToken;

  const UserModel({
    required super.id,
    required super.email,
    required super.name,
    super.preferredFuelTypeId,
    super.profilePictureUrl,
    this.token,
    this.refreshToken,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id']?.toString() ?? '',
      email: json['email'] ?? '',
      name: json['name'] ?? '',
      preferredFuelTypeId: json['preferredFuelTypeId'] as int?,
      profilePictureUrl: json['profilePictureUrl'],
      token: json['token'],
      refreshToken: json['refreshToken'],
    );
  }

  // Por si necesitas enviar el objeto de vuelta a la API
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'name': name,
      'preferredFuelTypeId': preferredFuelTypeId,
      'profilePictureUrl': profilePictureUrl,
    };
  }
}
