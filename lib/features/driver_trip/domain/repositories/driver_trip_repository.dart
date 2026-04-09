import 'package:latlong2/latlong.dart';

import '../../../active_ride/domain/entities/route_entity.dart';

abstract class DriverTripRepository {
  Future<RouteEntity> getRoute({
    required LatLng origin,
    required LatLng destination,
  });

  Future<void> endTrip(String rideId);
}
