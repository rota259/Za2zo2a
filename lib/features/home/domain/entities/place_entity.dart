import 'package:equatable/equatable.dart';
import 'package:latlong2/latlong.dart';

class PlaceEntity extends Equatable {
  final String placeName;
  final String shortAddress;
  final double lat;
  final double lng;
  final String displayName;

  const PlaceEntity({
    required this.placeName,
    required this.shortAddress,
    required this.lat,
    required this.lng,
    required this.displayName,
  });

  LatLng get latLng => LatLng(lat, lng);

  @override
  List<Object?> get props => [placeName, shortAddress, lat, lng, displayName];
}
