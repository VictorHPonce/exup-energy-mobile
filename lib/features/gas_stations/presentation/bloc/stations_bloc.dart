import 'package:exup_energy_mobile/core/models/pagination_model.dart';
import 'package:exup_energy_mobile/features/gas_stations/domain/entities/station_entity.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/services/location_service.dart';
import '../../domain/usecases/get_nearby_stations_usecase.dart';
import 'stations_event.dart';
import 'stations_state.dart';

class StationsBloc extends Bloc<StationsEvent, StationsState> {
  final GetNearbyStationsUseCase getNearbyStationsUseCase;
  final LocationService locationService;

  // ESTADO PERSISTENTE (Contexto de la consulta)
  // Almacenamos los parámetros iniciales para que el scroll incremental sea 
  // idéntico a la consulta original, respetando la lógica de PostGIS.
  double? _currentLat;
  double? _currentLon;
  double? _currentRadius;

  StationsBloc({
    required this.getNearbyStationsUseCase,
    required this.locationService,
  }) : super(StationsInitial()) {
    
    /// MANEJADOR: Carga Inicial (Página 1)
    on<FetchNearbyStations>((event, emit) async {
      emit(StationsLoading());

      double finalLat = event.lat;
      double finalLon = event.lon;

      // PASO 1: Validación de ubicación.
      // Si el evento viene vacío (0.0), delegamos al servicio de GPS.
      if (finalLat == 0 && finalLon == 0) {
        final position = await locationService.getCurrentPosition();
        if (position != null) {
          finalLat = position.latitude;
          finalLon = position.longitude;
        } else {
          emit(const StationsError("Error: No se pudo obtener la ubicación"));
          return;
        }
      }

      // PASO 2: "Snapshot" de parámetros.
      // Guardamos el radio y ubicación para que LoadNextPage sea consistente.
      _currentLat = finalLat;
      _currentLon = finalLon;
      _currentRadius = event.radius;

      // PASO 3: Llamada al UseCase (Capa de Dominio).
      final result = await getNearbyStationsUseCase.execute(
        lat: _currentLat!,
        lon: _currentLon!,
        radius: _currentRadius!,
        page: 1, // Siempre forzamos página 1 en este evento.
      );

      // PASO 4: Mapeo de resultado Dartz (Either).
      result.fold(
        (failure) => emit(StationsError(failure.message)),
        (pagination) => emit(StationsLoaded(pagination: pagination)),
      );
    });

    /// MANEJADOR: Carga Incremental (Paginación)
    on<LoadNextPage>((event, emit) async {
      final currentState = state;

      // PASO 1: Bloqueo de seguridad (Throttle manual).
      // Solo procedemos si el estado actual tiene datos, hay más páginas en el backend
      // y no hay otra petición de refresco en curso.
      if (currentState is StationsLoaded && 
          currentState.pagination.hasNextPage && 
          !currentState.isRefreshing) {
        
        // Emitimos el mismo estado pero con el flag de carga inferior activado.
        emit(currentState.copyWith(isRefreshing: true));

        // PASO 2: Cálculo de puntero.
        final nextPage = currentState.pagination.pageIndex + 1;

        // PASO 3: Consumo de API usando el contexto persistido.
        final result = await getNearbyStationsUseCase.execute(
          lat: _currentLat!,
          lon: _currentLon!,
          radius: _currentRadius!,
          page: nextPage,
        );

        result.fold(
          (failure) => emit(StationsError(failure.message)),
          (newPagination) {
            // PASO 4: Unión de datos (Data Accumulation).
            // Combinamos los datos que ya teníamos en el estado con los nuevos del backend.
            final totalStations = [
              ...currentState.pagination.data,
              ...newPagination.data,
            ];

            // PASO 5: Reconstrucción del objeto de paginación.
            // Creamos una nueva instancia de PaginationModel tipada explícitamente 
            // como Entity para evitar errores de casting con el StationModel del Data Source.
            final updatedPagination = PaginationModel<StationEntity>(
              pageIndex: newPagination.pageIndex,
              pageSize: newPagination.pageSize,
              totalCount: newPagination.totalCount,
              totalPages: newPagination.totalPages,
              hasNextPage: newPagination.hasNextPage,
              data: totalStations,
            );

            // PASO 6: Emisión del nuevo estado consolidado.
            emit(StationsLoaded(
              pagination: updatedPagination,
              isRefreshing: false, // Quitamos el spinner de la lista.
            ));
          },
        );
      }
    });
  }
}