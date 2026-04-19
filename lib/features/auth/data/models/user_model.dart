import '../../domain/entities/user_entity.dart';

class UserModel extends UserEntity {
  const UserModel({
    required String id,
    required String email,
    required String name,
    int? preferredFuelTypeId,
  }) : super(
          id: id,
          email: email,
          name: name,
          preferredFuelTypeId: preferredFuelTypeId,
        );

  // El famoso "Factory" para convertir el JSON de tu API .NET a un objeto de Dart
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      email: json['email'],
      name: json['name'],
      preferredFuelTypeId: json['preferredFuelTypeId'],
    );
  }

  // Por si necesitas enviar el objeto de vuelta a la API
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'name': name,
      'preferredFuelTypeId': preferredFuelTypeId,
    };
  }
}