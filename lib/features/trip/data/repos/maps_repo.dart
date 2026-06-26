import 'package:latlong2/latlong.dart';

import '../../../../core/network/api_endpoints.dart';
import '../../../../core/network/dio_client.dart';
import '../../../../core/network/repository_base.dart';
import '../models/trip_models.dart';

/// Map endpoints — geocode, reverse-geocode and route+fare, all via the
/// Za2zo2a backend (/api/map/*). The backend returns the authoritative fare.
class MapsRepo with RepositoryBase {
  final DioClient _client;

  MapsRepo(this._client);

  /// address → coordinates
  Future<GeocodeResult> geocode(String address) {
    return guard(() async {
      final res = await _client.dio.post(
        ApiEndpoints.geocode,
        data: {'address': address},
      );
      return GeocodeResult.fromJson(_asMap(res.data));
    });
  }

  /// coordinates → address
  Future<GeocodeResult> reverseGeocode(LatLng point) {
    return guard(() async {
      final res = await _client.dio.post(
        ApiEndpoints.reverseGeocode,
        data: {'lat': point.latitude, 'lng': point.longitude},
      );
      return GeocodeResult.fromJson(_asMap(res.data));
    });
  }

  /// origin + destination → route geometry, distance and fare estimate.
  Future<RouteEstimate> route({
    required LatLng origin,
    required LatLng destination,
  }) {
    return guard(() async {
      final res = await _client.dio.post(
        ApiEndpoints.route,
        data: {
          'origin': {'lat': origin.latitude, 'lng': origin.longitude},
          'destination': {
            'lat': destination.latitude,
            'lng': destination.longitude,
          },
        },
      );
      return RouteEstimate.fromJson(_asMap(res.data));
    });
  }

  Map<String, dynamic> _asMap(dynamic data) =>
      data is Map ? Map<String, dynamic>.from(data) : <String, dynamic>{};
}
