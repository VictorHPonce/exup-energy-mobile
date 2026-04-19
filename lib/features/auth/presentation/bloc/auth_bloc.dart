import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/login_usecase.dart';
import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final LoginUseCase loginUseCase;

  AuthBloc({required this.loginUseCase}) : super(AuthInitial()) {
    // Cuando recibimos el evento de Login...
    on<LoginSubmittedEvent>((event, emit) async {
      emit(AuthLoading()); // 1. Decimos a la UI que estamos cargando

      // 2. Llamamos al caso de uso (nuestro Result de .NET)
      final result = await loginUseCase(event.email, event.password);

      // 3. Manejamos el resultado (Either Left/Failure o Right/Success)
      result.fold(
        (failure) => emit(AuthError(failure.message)),
        (user) => emit(AuthSuccess(user)),
      );
    });
  }
}