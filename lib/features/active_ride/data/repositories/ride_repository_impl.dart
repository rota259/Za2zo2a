import 'package:latlong2/latlong.dart';

import '../../domain/entities/route_entity.dart';
import '../../domain/repositories/ride_repository.dart';
import '../datasources/osrm_remote_datasource.dart';

class RideRepositoryImpl implements RideRepository {
  final OsrmRemoteDatasource _remoteDatasource;

  RideRepositoryImpl(this._remoteDatasource);

  @override
  Future<RouteEntity> getRoute({
    required LatLng origin,
    required LatLng destination,
  }) {
    return _remoteDatasource.getRoute(origin: origin, destination: destination);
  }
}
