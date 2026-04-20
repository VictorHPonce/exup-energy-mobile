import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final String message;
  const Failure({required this.message});

  @override
  List<Object> get props => [message];
}

class ServerFailure extends Failure {
  // Al ponerlo así, puedes llamarlo como ServerFailure("error") 
  // y se lo pasa correctamente al padre.
  const ServerFailure(String message) : super(message: message);
}

class ConnectionFailure extends Failure {
  const ConnectionFailure() : super(message: "No hay conexión a internet");
}