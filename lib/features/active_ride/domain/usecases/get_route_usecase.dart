import 'package:latlong2/latlong.dart';

import '../entities/route_entity.dart';
import '../repositories/ride_repository.dart';

class GetRouteUsecase {
  final RideRepository _rideRepository;

  GetRouteUsecase(this._rideRepository);

  Future<RouteEntity> call({
    required LatLng origin,
    required LatLng destination,
  }) {
    return _rideRepository.getRoute(origin: origin, destination: destination);
  }
}
