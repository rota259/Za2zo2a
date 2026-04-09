import 'package:equatable/equatable.dart';

import '../../../../core/constants/app_strings.dart';

class DestinationEntity extends Equatable {
  final String address;
  final double lat;
  final double lng;
  final double price;
  final String distanceKm;
  final String tripTime;

  const DestinationEntity({
    required this.address,
    required this.lat,
    required this.lng,
    required this.price,
    required this.distanceKm,
    required this.tripTime,
  });

  const DestinationEntity.mock()
    : address = AppStrings.destinationAddress,
      lat = 37.8087,
      lng = -122.4098,
      price = 24.50,
      distanceKm = AppStrings.mockTripDistanceKm,
      tripTime = AppStrings.mockTripTime;

  @override
  List<Object?> get props => [address, lat, lng, price, distanceKm, tripTime];
}
