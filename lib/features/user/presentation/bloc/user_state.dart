import 'package:equatable/equatable.dart';

abstract class UserState extends Equatable {
  const UserState();
  @override
  List<Object?> get props => [];
}

class UserInitial extends UserState {}
class UserLoading extends UserState {}
class UserSuccess extends UserState {
  final String message; // Ej: "Perfil actualizado con éxito"
  const UserSuccess(this.message);
}
class UserError extends UserState {
  final String message;
  const UserError(this.message);
}