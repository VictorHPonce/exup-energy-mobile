import 'package:equatable/equatable.dart';
import '../../domain/entities/station_entity.dart';
import '../../../../core/models/pagination_model.dart';

abstract class StationsState extends Equatable {
  const StationsState();
  @override
  List<Object?> get props => [];
}

class StationsInitial extends StationsState {}
class StationsLoading extends StationsState {}

class StationsLoaded extends StationsState {
  final PaginationModel<StationEntity> pagination;
  final bool isRefreshing;

  const StationsLoaded({
    required this.pagination,
    this.isRefreshing = false,
  });

  StationsLoaded copyWith({
    PaginationModel<StationEntity>? pagination,
    bool? isRefreshing,
  }) {
    return StationsLoaded(
      pagination: pagination ?? this.pagination,
      isRefreshing: isRefreshing ?? this.isRefreshing,
    );
  }

  @override
  List<Object?> get props => [pagination, isRefreshing];
}

class StationsError extends StationsState {
  final String message;
  const StationsError(this.message);
  @override
  List<Object?> get props => [message];
}