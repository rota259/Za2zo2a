import 'package:dio/dio.dart';
import 'package:latlong2/latlong.dart';

class MapsService {
  static const String _apiKey = 'YOUR_GOOGLE_MAPS_API_KEY';
  static const String _routesBaseUrl =
      'https://routes.googleapis.com/directions/v2:computeRoutes';
  static const String _matrixBaseUrl =
      'https://routes.googleapis.com/distanceMatrix/v2:computeRouteMatrix';

  final Dio _dio;

  MapsService({Dio? dio}) : _dio = dio ?? Dio();

  /// Fetches the route, polyline, distance, and duration between two LatLng points using the Routes API v2
  Future<RouteData?> computeRoutes(LatLng origin, LatLng destination) async {
    try {
      final response = await _dio.post(
        _routesBaseUrl,
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'X-Goog-Api-Key': _apiKey,
            // We want routes, polylines, duration, and distance.
            'X-Goog-FieldMask':
                'routes.duration,routes.distanceMeters,routes.polyline.encodedPolyline',
          },
        ),
        data: {
          "origin": {
            "location": {
              "latLng": {
                "latitude": origin.latitude,
                "longitude": origin.longitude,
              },
            },
          },
          "destination": {
            "location": {
              "latLng": {
                "latitude": destination.latitude,
                "longitude": destination.longitude,
              },
            },
          },
          "travelMode": "DRIVE",
          "routingPreference": "TRAFFIC_AWARE",
        },
      );

      if (response.statusCode == 200) {
        final data = response.data;
        if (data != null &&
            data['routes'] != null &&
            (data['routes'] as List).isNotEmpty) {
          final route = data['routes'][0];
          return RouteData(
            encodedPolyline: route['polyline']['encodedPolyline'],
            durationSeconds: int.parse(
              route['duration'].toString().replaceAll('s', ''),
            ),
            distanceMeters: route['distanceMeters'],
          );
        }
      }
    } catch (e) {
      // print('Error computing routes: $e');
    }
    return null;
  }

  /// Helps driver app find the distance to various pickup locations
  Future<List<MatrixData>?> computeRouteMatrix(
    List<LatLng> origins,
    List<LatLng> destinations,
  ) async {
    try {
      final response = await _dio.post(
        _matrixBaseUrl,
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'X-Goog-Api-Key': _apiKey,
            'X-Goog-FieldMask':
                'originIndex,destinationIndex,duration,distanceMeters',
          },
        ),
        data: {
          "origins": origins
              .map(
                (e) => {
                  "waypoint": {
                    "location": {
                      "latLng": {
                        "latitude": e.latitude,
                        "longitude": e.longitude,
                      },
                    },
                  },
                },
              )
              .toList(),
          "destinations": destinations
              .map(
                (e) => {
                  "waypoint": {
                    "location": {
                      "latLng": {
                        "latitude": e.latitude,
                        "longitude": e.longitude,
                      },
                    },
                  },
                },
              )
              .toList(),
          "travelMode": "DRIVE",
        },
      );

      if (response.statusCode == 200) {
        // response is an array of elements
        final List dataList = response.data is List
            ? response.data
            : [response.data];
        return dataList
            .map(
              (e) => MatrixData(
                originIndex: e['originIndex'] ?? 0,
                destinationIndex: e['destinationIndex'] ?? 0,
                durationSeconds:
                    int.tryParse(
                      e['duration']?.toString().replaceAll('s', '') ?? '0',
                    ) ??
                    0,
                distanceMeters: e['distanceMeters'] ?? 0,
              ),
            )
            .toList();
      }
    } catch (e) {
      // print('Error computing route matrix: $e');
    }
    return null;
  }
}

class RouteData {
  final String encodedPolyline;
  final int durationSeconds;
  final int distanceMeters;

  RouteData({
    required this.encodedPolyline,
    required this.durationSeconds,
    required this.distanceMeters,
  });
}

class MatrixData {
  final int originIndex;
  final int destinationIndex;
  final int durationSeconds;
  final int distanceMeters;

  MatrixData({
    required this.originIndex,
    required this.destinationIndex,
    required this.durationSeconds,
    required this.distanceMeters,
  });
}
