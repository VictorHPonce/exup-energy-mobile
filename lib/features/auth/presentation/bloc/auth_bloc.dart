import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/login_usecase.dart';
import '../../domain/usecases/register_usecase.dart';
import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final LoginUseCase loginUseCase;
  final RegisterUseCase registerUseCase;

  AuthBloc({
    required this.loginUseCase,
    required this.registerUseCase,
  }) : super(AuthInitial()) {
    on<LoginSubmittedEvent>(_onLogin);
    on<RegisterSubmittedEvent>(_onRegister);
  }

  Future<void> _onLogin(LoginSubmittedEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    final result = await loginUseCase(event.email, event.password);
    result.fold(
      (failure) => emit(AuthError(failure.message)),
      (user) => emit(AuthSuccess(user)),
    );
  }

  Future<void> _onRegister(RegisterSubmittedEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    final result = await registerUseCase(
      name: event.name,
      email: event.email,
      password: event.password,
    );
    result.fold(
      (failure) => emit(AuthError(failure.message)),
      (user) => emit(AuthSuccess(user)),
    );
  }
}