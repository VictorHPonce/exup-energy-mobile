import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/services/location_service.dart';
import '../../domain/usecases/get_nearby_stations_usecase.dart';
import 'stations_event.dart';
import 'stations_state.dart';

class StationsBloc extends Bloc<StationsEvent, StationsState> {
  final GetNearbyStationsUseCase getNearbyStationsUseCase;
  final LocationService locationService;

  StationsBloc({
    required this.getNearbyStationsUseCase,
    required this.locationService,
  }) : super(StationsInitial()) {
    
    on<FetchNearbyStations>((event, emit) async {
      emit(StationsLoading());

      double finalLat = event.lat;
      double finalLon = event.lon;

      // 1. Si no hay coordenadas, pedimos al GPS
      if (finalLat == 0 && finalLon == 0) {
        final position = await locationService.getCurrentPosition();
        if (position != null) {
          finalLat = position.latitude;
          finalLon = position.longitude;
        } else {
          emit(const StationsError("No se pudo obtener la ubicación o permisos"));
          return;
        }
      }

      // 2. Llamamos al caso de uso con las coordenadas finales (GPS o Evento)
      final result = await getNearbyStationsUseCase.execute(
        lat: finalLat, // USAR LAS VARIABLES CALCULADAS
        lon: finalLon,
        radius: event.radius,
      );

      result.fold(
        (failure) => emit(StationsError(failure.message)),
        (stations) => emit(StationsLoaded(stations)),
      );
    });
  }
}