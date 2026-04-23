import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  final String id;
  final String email;
  final String name;
  final int? preferredFuelTypeId;
  final String? profilePictureUrl;

  const UserEntity({
    required this.id,
    required this.email,
    required this.name,
    this.preferredFuelTypeId,
    this.profilePictureUrl,
  });

  @override
  List<Object?> get props => [id, email, name, preferredFuelTypeId, profilePictureUrl];
}