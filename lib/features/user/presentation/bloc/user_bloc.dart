import 'package:exup_energy_mobile/features/user/user.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final UserRepository userRepository;
  final UploadProfilePictureUseCase uploadProfilePictureUseCase;

  UserBloc({
    required this.userRepository,
    required this.uploadProfilePictureUseCase,
  }) : super(UserInitial()) {
    on<UpdateProfileSubmitted>(_onUpdateProfile);
    on<ToggleFavoriteRequested>(_onToggleFavorite);
    on<UpdateProfilePictureRequested>(_onUploadPicture);
  }

  Future<void> _onUploadPicture(
    UpdateProfilePictureRequested event,
    Emitter<UserState> emit,
  ) async {
    emit(UserLoading());

    final result = await uploadProfilePictureUseCase(event.file);

    result.fold(
      (failure) => emit(UserError(failure.message)),
      (newUrl) => emit(
        UserSuccess("¡Foto actualizada correctamente!", imageUrl: newUrl),
      ),
    );
  }

  Future<void> _onUpdateProfile(
    UpdateProfileSubmitted event,
    Emitter<UserState> emit,
  ) async {
    emit(UserLoading());

    final result = await userRepository.updateProfile(
      event.name,
      event.preferredFuelTypeId,
    );

    result.fold(
      (failure) => emit(UserError(failure.message)),
      (_) => emit(const UserSuccess("¡Perfil actualizado correctamente!")),
    );
  }

  Future<void> _onToggleFavorite(
    ToggleFavoriteRequested event,
    Emitter<UserState> emit,
  ) async {

    final result = event.isFavorite
        ? await userRepository.addFavorite(event.stationId)
        : await userRepository.removeFavorite(event.stationId);

    result.fold(
      (failure) => emit(UserError(failure.message)),
      (_) => emit(
        UserSuccess(
          event.isFavorite ? "Añadido a favoritos" : "Eliminado de favoritos",
        ),
      ),
    );
  }
}
