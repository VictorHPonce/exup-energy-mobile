import 'package:equatable/equatable.dart';

abstract class StationsEvent extends Equatable {
  const StationsEvent();
  @override
  List<Object> get props => [];
}

class FetchNearbyStations extends StationsEvent {
  final double lat;
  final double lon;
  final double radius;

  const FetchNearbyStations({required this.lat, required this.lon, this.radius = 5.0});

  @override
  List<Object> get props => [lat, lon, radius];
}