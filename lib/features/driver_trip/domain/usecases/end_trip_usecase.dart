import '../repositories/driver_trip_repository.dart';

class EndTripUsecase {
  final DriverTripRepository _driverTripRepository;

  EndTripUsecase(this._driverTripRepository);

  Future<void> call(String rideId) {
    return _driverTripRepository.endTrip(rideId);
  }
}
