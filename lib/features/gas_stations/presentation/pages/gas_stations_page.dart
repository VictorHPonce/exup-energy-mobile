import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:exup_energy_mobile/core/core.dart';
import 'package:exup_energy_mobile/core/widgets/widgets.dart';
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
      if (state is StationsLoaded && state.pagination.hasNextPage && !state.isRefreshing) {
        final lastLat = state.pagination.data.first.latitude;
        final lastLon = state.pagination.data.first.longitude;
        context.read<StationsBloc>().add(
          LoadNextPage(lat: lastLat, lon: lastLon, radius: 5.0),
        );
      }
    }
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= (maxScroll * 0.9);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // El fondo del Scaffold ahora es dinámico gracias al AppTheme
      body: BlocBuilder<StationsBloc, StationsState>(
        builder: (context, state) {
          if (state is StationsLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is StationsError) {
            return _ErrorView(message: state.message);
          }

          if (state is StationsLoaded) {
            final stations = state.pagination.data;

            if (stations.isEmpty) {
              return const Center(child: BrandText.body('No hay gasolineras cerca.'));
            }

            return RefreshIndicator(
              onRefresh: () async {
                context.read<StationsBloc>().add(
                  const FetchNearbyStations(lat: 0.0, lon: 0.0),
                );
              },
              child: ListView.separated(
                controller: _scrollController,
                padding: const EdgeInsets.all(AppTheme.paddingM), // Tokenizado
                itemCount: state.isRefreshing ? stations.length + 1 : stations.length,
                separatorBuilder: (context, index) => 
                    const SizedBox(height: AppTheme.paddingS), // Tokenizado
                itemBuilder: (context, index) {
                  if (index >= stations.length) {
                    return const Padding(
                      padding: EdgeInsets.symmetric(vertical: AppTheme.paddingM),
                      child: Center(child: CircularProgressIndicator(strokeWidth: 2)),
                    );
                  }
                  return StationCard(station: stations[index]);
                },
              ),
            );
          }
          return const Center(child: BrandText.body('Iniciando búsqueda...'));
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
    final colorScheme = Theme.of(context).colorScheme;
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppTheme.paddingL),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.error_outline, color: colorScheme.error, size: 60),
            const SizedBox(height: AppTheme.paddingM),
            BrandText.header('Ups!', fontSize: 24),
            const SizedBox(height: AppTheme.paddingS),
            BrandText.body(message, textAlign: TextAlign.center),
            const SizedBox(height: AppTheme.paddingL),
            PrimaryButton(
              text: 'Reintentar',
              onPressed: () => context.read<StationsBloc>().add(
                    const FetchNearbyStations(lat: 0.0, lon: 0.0),
                  ),
            ),
          ],
        ),
      ),
    );
  }
}