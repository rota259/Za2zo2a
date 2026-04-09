import 'package:latlong2/latlong.dart';

import '../entities/route_entity.dart';

abstract class RideRepository {
  Future<RouteEntity> getRoute({
    required LatLng origin,
    required LatLng destination,
  });
}
