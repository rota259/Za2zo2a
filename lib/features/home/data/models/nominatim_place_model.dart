import '../../domain/entities/place_entity.dart';

class NominatimPlaceModel extends PlaceEntity {
  const NominatimPlaceModel({
    required super.placeName,
    required super.shortAddress,
    required super.lat,
    required super.lng,
    required super.displayName,
  });

  factory NominatimPlaceModel.fromJson(Map<String, dynamic> json) {
    final displayName = '${json['display_name'] ?? ''}'.trim();
    final address = (json['address'] as Map?)?.cast<String, dynamic>() ?? {};
    final rawName = '${json['name'] ?? ''}'.trim();
    final placeName = rawName.isEmpty
        ? displayName.split(',').first.trim()
        : rawName;
    final segments = [
      '${address['road'] ?? address['pedestrian'] ?? ''}'.trim(),
      '${address['suburb'] ?? address['neighbourhood'] ?? ''}'.trim(),
      '${address['city'] ?? address['town'] ?? address['state'] ?? ''}'.trim(),
    ].where((value) => value.isNotEmpty).toList();

    return NominatimPlaceModel(
      placeName: placeName,
      shortAddress: segments.isEmpty
          ? displayName
          : segments.take(3).join(', '),
      lat: double.tryParse('${json['lat']}') ?? 0,
      lng: double.tryParse('${json['lon']}') ?? 0,
      displayName: displayName,
    );
  }
}
