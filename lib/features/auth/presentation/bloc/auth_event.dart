import 'package:equatable/equatable.dart';

abstract class AuthEvent extends Equatable {
  @override
  List<Object> get props => [];
}

// El evento que dispararemos cuando el usuario pulse el botón
class LoginSubmittedEvent extends AuthEvent {
  final String email;
  final String password;

  LoginSubmittedEvent(this.email, this.password);

  @override
  List<Object> get props => [email, password];
}