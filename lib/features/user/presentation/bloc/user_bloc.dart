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

  Future<void> _onUpdateProfile(UpdateProfileSubmitted event, Emitter<UserState> emit) async {
    emit(UserLoading());
    // Aquí llamarías a tu repositorio:
    // final result = await userRepository.updateProfile(event.name, event.preferredFuelTypeId);
    // result.fold(...)
  }

  Future<void> _onToggleFavorite(ToggleFavoriteRequested event, Emitter<UserState> emit) async {
    // Lógica para llamar a addFavorite o removeFavorite en tu .NET
  }
}