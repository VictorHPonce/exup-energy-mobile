import 'package:equatable/equatable.dart';
import '../../domain/entities/user_entity.dart';

abstract class AuthState extends Equatable {
  @override
  List<Object> get props => [];
}

class AuthInitial extends AuthState {} // Estado por defecto
class AuthLoading extends AuthState {} // Para mostrar el círculo de carga
class AuthSuccess extends AuthState {  // Login correcto
  final UserEntity user;
  AuthSuccess(this.user);
}
class AuthError extends AuthState {    // Algo falló
  final String message;
  AuthError(this.message);
}