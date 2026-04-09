import 'package:dio/dio.dart';
import 'package:latlong2/latlong.dart';

import '../../../../core/constants/app_strings.dart';
import '../models/osrm_route_model.dart';

abstract class OsrmRemoteDatasource {
  Future<OsrmRouteModel> getRoute({
    required LatLng origin,
    required LatLng destination,
  });
}

class OsrmRemoteDatasourceImpl implements OsrmRemoteDatasource {
  final Dio _dio;

  OsrmRemoteDatasourceImpl(this._dio);

  @override
  Future<OsrmRouteModel> getRoute({
    required LatLng origin,
    required LatLng destination,
  }) async {
    final url =
        '${AppStrings.osrmBaseUrl}/route/v1/driving/'
        '${origin.longitude},${origin.latitude};'
        '${destination.longitude},${destination.latitude}'
        '?overview=full&geometries=geojson&steps=true';

    final response = await _dio.get(url);
    return OsrmRouteModel.fromJson(
      response.data as Map<String, dynamic>,
      origin: origin,
      destination: destination,
    );
  }
}
