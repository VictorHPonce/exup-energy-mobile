import 'dart:io';

import 'package:equatable/equatable.dart';

abstract class UserEvent extends Equatable {
  const UserEvent();
  @override
  List<Object?> get props => [];
}

// Para actualizar datos básicos
class UpdateProfileSubmitted extends UserEvent {
  final String name;
  final int? preferredFuelTypeId;
  const UpdateProfileSubmitted({required this.name, this.preferredFuelTypeId});
}

// Para gestionar favoritos
class ToggleFavoriteRequested extends UserEvent {
  final int stationId;
  final bool isFavorite;
  const ToggleFavoriteRequested({required this.stationId, required this.isFavorite});
}

class UpdateProfilePictureRequested extends UserEvent {
  final File file;
  const UpdateProfilePictureRequested(this.file);

  @override
  List<Object?> get props => [file];
}