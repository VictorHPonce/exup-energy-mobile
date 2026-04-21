import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/stations_bloc.dart';
import '../bloc/stations_event.dart';
import '../bloc/stations_state.dart';
import '../widgets/station_card_organism.dart';

class GasStationsPage extends StatefulWidget {
  const GasStationsPage({super.key});

  @override
  State<GasStationsPage> createState() => _GasStationsPageState();
}

class _GasStationsPageState extends State<GasStationsPage> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);

    // Disparo inicial: Solo si el estado es el inicial.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final bloc = context.read<StationsBloc>();
      if (bloc.state is StationsInitial) {
        bloc.add(const FetchNearbyStations(lat: 0.0, lon: 0.0));
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_isBottom) {
      final state = context.read<StationsBloc>().state;

      // CRÍTICO: Solo disparar si NO está cargando ya (isRefreshing)
      // y si hay una página siguiente disponible.
      if (state is StationsLoaded &&
          state.pagination.hasNextPage &&
          !state.isRefreshing) {
        // <--- AÑADIR ESTA VALIDACIÓN

        // Usamos las coordenadas que ya tenemos en el estado actual
        // para no volver a pedirle al GPS.
        final lastLat = state.pagination.data.first.latitude;
        final lastLon = state.pagination.data.first.longitude;

        context.read<StationsBloc>().add(
          LoadNextPage(lat: lastLat, lon: lastLon, radius: 5.0),
        );
      }
    }
  }

  // Helper para detectar el final del scroll (umbral del 90%)
  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= (maxScroll * 0.9);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<StationsBloc, StationsState>(
        builder: (context, state) {
          // 1. Estado de Carga Inicial (Pantalla completa)
          if (state is StationsLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          // 2. Estado de Error
          if (state is StationsError) {
            return _ErrorView(message: state.message);
          }

          // 3. Estado de Éxito (Paginado)
          if (state is StationsLoaded) {
            final stations = state.pagination.data; // ACCESO CORRECTO A LA DATA

            if (stations.isEmpty) {
              return const Center(child: Text('No hay gasolineras cerca.'));
            }

            return RefreshIndicator(
              onRefresh: () async {
                context.read<StationsBloc>().add(
                  const FetchNearbyStations(lat: 0.0, lon: 0.0),
                );
              },
              child: ListView.separated(
                controller: _scrollController,
                padding: const EdgeInsets.all(16),
                // EVOLUCIÓN PRO: Si está cargando más, sumamos 1 al conteo para el spinner
                itemCount: state.isRefreshing
                    ? stations.length + 1
                    : stations.length,
                separatorBuilder: (context, index) =>
                    const SizedBox(height: 12),
                itemBuilder: (context, index) {
                  // Si el índice es igual al largo de la lista, mostramos el spinner inferior
                  if (index >= stations.length) {
                    return const Padding(
                      padding: EdgeInsets.symmetric(vertical: 16),
                      child: Center(
                        child: CircularProgressIndicator(strokeWidth: 2),
                      ),
                    );
                  }
                  return StationCard(station: stations[index]);
                },
              ),
            );
          }

          return const Center(child: Text('Iniciando búsqueda...'));
        },
      ),
    );
  }
}

// Widget privado para mejorar la legibilidad y mantenimiento (Clean Code)
class _ErrorView extends StatelessWidget {
  final String message;
  const _ErrorView({required this.message});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.error_outline, color: Colors.red, size: 48),
          const SizedBox(height: 16),
          Text('Error: $message', textAlign: TextAlign.center),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () => context.read<StationsBloc>().add(
              const FetchNearbyStations(lat: 0.0, lon: 0.0),
            ),
            child: const Text('Reintentar'),
          ),
        ],
      ),
    );
  }
}
