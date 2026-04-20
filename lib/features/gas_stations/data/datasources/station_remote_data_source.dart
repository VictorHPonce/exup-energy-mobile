import 'package:dio/dio.dart'; // Importa la librería oficial
import '../models/station_model.dart';

abstract class StationRemoteDataSource {
  Future<List<StationModel>> getNearbyStations(double lat, double lon, double radius);
}

class StationRemoteDataSourceImpl implements StationRemoteDataSource {
  // Ahora usamos Dio directamente
  final Dio dio;

  StationRemoteDataSourceImpl({required this.dio});

  @override
  Future<List<StationModel>> getNearbyStations(double lat, double lon, double radius) async {
    try {
      final response = await dio.get(
        '/GasStation/nearby', // Asegúrate de que la BaseUrl esté configurada en el Dio
        queryParameters: {
          'lat': lat,
          'lon': lon,
          'radius': radius,
        },
      );

      final List<dynamic> data = response.data;
      return data.map((json) => StationModel.fromJson(json)).toList();
    } catch (e) {
      throw Exception("Error al obtener gasolineras cercanas: $e");
    }
  }
}