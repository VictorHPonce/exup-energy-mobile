import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final String message;
  const Failure(this.message);

  @override
  List<Object> get props => [message];
}

// Fallo específico para errores de servidor (500, 404, etc)
class ServerFailure extends Failure {
  const ServerFailure(String message) : super(message);
}

// Fallo para cuando no hay internet
class ConnectionFailure extends Failure {
  const ConnectionFailure() : super("No hay conexión a internet");
}