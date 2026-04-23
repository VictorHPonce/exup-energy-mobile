import 'package:equatable/equatable.dart';

abstract class UserState extends Equatable {
  const UserState();
  
  @override
  List<Object?> get props => [];
}

class UserInitial extends UserState {}
class UserLoading extends UserState {}

class UserSuccess extends UserState {
  final String message;
  final String? imageUrl;
  const UserSuccess(this.message, {this.imageUrl});

  @override
  List<Object?> get props => [message, imageUrl];
}

class UserError extends UserState {
  final String message;
  const UserError(this.message);

  @override
  List<Object?> get props => [message];
}