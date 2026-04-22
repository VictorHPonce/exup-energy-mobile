import 'package:exup_energy_mobile/core/models/fuel_type_model.dart';
import 'package:exup_energy_mobile/features/auth/auth.dart';
import 'package:exup_energy_mobile/features/gas_stations/domain/usecases/get_fuel_types_use_case.dart';
import 'package:exup_energy_mobile/features/user/user.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final LoginUseCase loginUseCase;
  final RegisterUseCase registerUseCase;
  final LogoutUseCase logoutUseCase;
  final GetUserProfileUseCase getUserProfileUseCase;
  final GetFuelTypesUseCase getFuelTypesUseCase;

  List<FuelTypeModel> allFuels = [];

  AuthBloc({
    required this.loginUseCase,
    required this.registerUseCase,
    required this.logoutUseCase,
    required this.getUserProfileUseCase,
    required this.getFuelTypesUseCase,
  }) : super(AuthInitial()) {
    on<LoginSubmittedEvent>(_onLogin);
    on<RegisterSubmittedEvent>(_onRegister);
    on<LogoutRequested>(_onLogout);
    on<AppStarted>(_onAppStarted);
  }

  Future<void> _onAppStarted(
    AppStarted event,
    Emitter<AuthState> emit,
  ) async {
    // 1. Cargamos los combustibles (Catálogo)
    // Lo hacemos primero o en paralelo para que esté disponible en toda la app
    final fuelsResult = await getFuelTypesUseCase.execute();
    fuelsResult.fold(
      (failure) => null, // Si falla, allFuels sigue vacía
      (fuels) => allFuels = fuels,
    );

    // 2. Cargamos el perfil del usuario (Sesión)
    final profileResult = await getUserProfileUseCase();
    profileResult.fold(
      (failure) {
        emit(AuthInitial()); // No hay sesión o token inválido
      },
      (user) {
        emit(AuthSuccess(user)); // Sesión activa
      },
    );
  }

  Future<void> _onLogin(
    LoginSubmittedEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    final result = await loginUseCase(event.email, event.password);
    result.fold(
      (failure) => emit(AuthError(failure.message)),
      (user) => emit(AuthSuccess(user)),
    );
  }

  Future<void> _onRegister(
    RegisterSubmittedEvent event,
    Emitter<AuthState> emit,
  ) async {
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

  Future<void> _onLogout(
    LogoutRequested event,
    Emitter<AuthState> emit,
  ) async {
    await logoutUseCase.execute();
    emit(AuthInitial()); 
  }
}