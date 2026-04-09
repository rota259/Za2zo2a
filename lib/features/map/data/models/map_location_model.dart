import 'package:equatable/equatable.dart';
import 'package:latlong2/latlong.dart';

class MapLocationModel extends Equatable {
  final String id;
  final double latitude;
  final double longitude;
  final String title;
  final String? description;

  const MapLocationModel({
    required this.id,
    required this.latitude,
    required this.longitude,
    required this.title,
    this.description,
  });

  LatLng get coordinates => LatLng(latitude, longitude);

  @override
  List<Object?> get props => [id, latitude, longitude, title, description];
}
