import 'package:dio/dio.dart';
import 'package:latlong2/latlong.dart';

import '../../../active_ride/data/models/osrm_route_model.dart';
import '../../../../core/constants/app_strings.dart';

abstract class DriverOsrmDatasource {
  Future<OsrmRouteModel> getRoute({
    required LatLng origin,
    required LatLng destination,
  });
}

class DriverOsrmDatasourceImpl implements DriverOsrmDatasource {
  final Dio _dio;

  DriverOsrmDatasourceImpl(this._dio);

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
