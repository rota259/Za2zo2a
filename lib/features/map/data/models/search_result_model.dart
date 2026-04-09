import 'package:equatable/equatable.dart';
import 'package:latlong2/latlong.dart';

class SearchResultModel extends Equatable {
  final String displayName;
  final double lat;
  final double lon;
  final String placeId;

  const SearchResultModel({
    required this.displayName,
    required this.lat,
    required this.lon,
    required this.placeId,
  });

  factory SearchResultModel.fromJson(Map<String, dynamic> json) {
    return SearchResultModel(
      displayName: (json['display_name'] ?? '') as String,
      lat: double.tryParse('${json['lat'] ?? ''}') ?? 0,
      lon: double.tryParse('${json['lon'] ?? ''}') ?? 0,
      placeId: '${json['place_id'] ?? ''}',
    );
  }

  LatLng get coordinates => LatLng(lat, lon);

  String get title {
    final separatorIndex = displayName.indexOf(',');
    if (separatorIndex == -1) {
      return displayName.trim();
    }

    return displayName.substring(0, separatorIndex).trim();
  }

  String get address {
    final separatorIndex = displayName.indexOf(',');
    if (separatorIndex == -1) {
      return displayName.trim();
    }

    return displayName.substring(separatorIndex + 1).trim();
  }

  @override
  List<Object?> get props => [displayName, lat, lon, placeId];
}
