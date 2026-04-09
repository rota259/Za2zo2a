import 'package:latlong2/latlong.dart';

import '../../../active_ride/domain/entities/route_entity.dart';
import '../repositories/driver_trip_repository.dart';

class GetDriverRouteUsecase {
  final DriverTripRepository _driverTripRepository;

  GetDriverRouteUsecase(this._driverTripRepository);

  Future<RouteEntity> call({
    required LatLng origin,
    required LatLng destination,
  }) {
    return _driverTripRepository.getRoute(
      origin: origin,
      destination: destination,
    );
  }
}
