import 'package:latlong2/latlong.dart';

import '../../../active_ride/domain/entities/route_entity.dart';
import '../../domain/repositories/driver_trip_repository.dart';
import '../datasources/driver_osrm_datasource.dart';

class DriverTripRepositoryImpl implements DriverTripRepository {
  final DriverOsrmDatasource _remoteDatasource;

  DriverTripRepositoryImpl(this._remoteDatasource);

  @override
  Future<RouteEntity> getRoute({
    required LatLng origin,
    required LatLng destination,
  }) {
    return _remoteDatasource.getRoute(origin: origin, destination: destination);
  }

  @override
  Future<void> endTrip(String rideId) async {
    await Future<void>.delayed(const Duration(milliseconds: 250));
  }
}
