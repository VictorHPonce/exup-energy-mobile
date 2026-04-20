import 'package:equatable/equatable.dart';
import '../../domain/entities/station_entity.dart';

abstract class StationsState extends Equatable {
  const StationsState();
  @override
  List<Object> get props => [];
}

class StationsInitial extends StationsState {}
class StationsLoading extends StationsState {}

class StationsLoaded extends StationsState {
  final List<StationEntity> stations;
  const StationsLoaded(this.stations);
  @override
  List<Object> get props => [stations];
}

class StationsError extends StationsState {
  final String message;
  const StationsError(this.message);
  @override
  List<Object> get props => [message];
}