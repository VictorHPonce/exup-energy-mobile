import 'package:exup_energy_mobile/features/user/domain/repositories/user_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'user_event.dart';
import 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final UserRepository userRepository;

  UserBloc({required this.userRepository}) : super(UserInitial()) {
    on<UpdateProfileSubmitted>(_onUpdateProfile);
    on<ToggleFavoriteRequested>(_onToggleFavorite);
  }

  Future<void> _onUpdateProfile(
    UpdateProfileSubmitted event, 
    Emitter<UserState> emit
  ) async {
    emit(UserLoading());
    
    final result = await userRepository.updateProfile(
      event.name, 
      event.preferredFuelTypeId
    );

    result.fold(
      (failure) => emit(UserError(failure.message)),
      (_) => emit(const UserSuccess("¡Perfil actualizado correctamente!")),
    );
  }

  Future<void> _onToggleFavorite(
    ToggleFavoriteRequested event, 
    Emitter<UserState> emit
  ) async {
    // No emitimos loading aquí para no bloquear la UI (UX pro)
    // El usuario simplemente verá el corazón cambiar de color
    
    final result = event.isFavorite 
      ? await userRepository.addFavorite(event.stationId)
      : await userRepository.removeFavorite(event.stationId);

    result.fold(
      (failure) => emit(UserError(failure.message)),
      (_) => emit(UserSuccess(
        event.isFavorite ? "Añadido a favoritos" : "Eliminado de favoritos"
      )),
    );
  }
}