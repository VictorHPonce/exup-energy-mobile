import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/stations_bloc.dart';
import '../bloc/stations_event.dart';
import '../bloc/stations_state.dart';
import '../widgets/station_card_organism.dart';

class GasStationsPage extends StatelessWidget {
  const GasStationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    if (context.read<StationsBloc>().state is StationsInitial) {
    context.read<StationsBloc>().add(
      const FetchNearbyStations(lat: 0.0, lon: 0.0),
    );
  }

    return BlocBuilder<StationsBloc, StationsState>(
      builder: (context, state) {
        if (state is StationsLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is StationsLoaded) {
          if (state.stations.isEmpty) {
            return const Center(child: Text('No hay gasolineras cerca.'));
          }
          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: state.stations.length,
            itemBuilder: (context, index) => StationCard(station: state.stations[index]),
          );
        } else if (state is StationsError) {
          return Center(child: Text('Error: ${state.message}'));
        }
        return const Center(child: Text('Iniciando búsqueda...'));
      },
    );
  }
}