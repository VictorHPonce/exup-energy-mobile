import 'package:dio/dio.dart';
import 'package:exup_energy_mobile/core/models/fuel_type_model.dart';
import '../models/station_model.dart';
import '../../../../core/models/pagination_model.dart';

abstract class StationRemoteDataSource {
  // Cambiamos a parámetros nombrados {} y agregamos 'page'
  // Cambiamos el retorno a PaginationModel
  Future<PaginationModel<StationModel>> getNearbyStations({
    required double lat,
    required double lon,
    required double radius,
    required int page, 
  });

  Future<List<FuelTypeModel>> getFuelTypes();
}

class StationRemoteDataSourceImpl implements StationRemoteDataSource {
  final Dio dio;
  StationRemoteDataSourceImpl({required this.dio});

  @override
  Future<List<FuelTypeModel>> getFuelTypes() async {
    try {
      final response = await dio.get('/GasStation/fuel-types');
      return (response.data as List)
          .map((json) => FuelTypeModel.fromJson(json))
          .toList();
    } catch (e) {
      throw Exception("Error al obtener tipos de combustible: $e");
    }
  }

  @override
  Future<PaginationModel<StationModel>> getNearbyStations({
    required double lat,
    required double lon,
    required double radius,
    required int page,
  }) async {
    try {
      final response = await dio.get(
        '/GasStation/nearby',
        queryParameters: {
          'lat': lat,
          'lon': lon,
          'radius': radius,
          'pageIndex': page, // Asegúrate que coincida con el parámetro de tu API .NET
        },
      );

      // Usamos el factory genérico que ya creaste
      return PaginationModel<StationModel>.fromJson(
        response.data,
        (json) => StationModel.fromJson(json),
      );
    } catch (e) {
      throw Exception("Error al obtener gasolineras: $e");
    }
  }
}