import 'package:latlong2/latlong.dart';

import '../../../../core/network/repository_base.dart';

/// Trip lifecycle. Server statuses are UNCONFIRMED — the contract assumes:
///   requested → accepted → in_progress → completed | cancelled
/// [tripStatusFromString] accepts common variants and flags unknown ones.
enum TripStatus {
  requested,
  accepted,
  inProgress,
  completed,
  cancelled,
  unknown,
}

TripStatus tripStatusFromString(String? value) {
  switch (value?.toLowerCase().trim().replaceAll('-', '_')) {
    case 'requested':
    case 'pending':
    case 'searching':
    case 'created':
      return TripStatus.requested;
    case 'accepted':
    case 'matched':
    case 'assigned':
    case 'driver_assigned':
      return TripStatus.accepted;
    case 'in_progress':
    case 'inprogress':
    case 'started':
    case 'ongoing':
    case 'on_trip':
      return TripStatus.inProgress;
    case 'completed':
    case 'complete':
    case 'finished':
    case 'done':
      return TripStatus.completed;
    case 'cancelled':
    case 'canceled':
    case 'declined':
    case 'rejected':
      return TripStatus.cancelled;
    default:
      return TripStatus.unknown;
  }
}

/// A geo point with an optional human address (matches the backend
/// origin/destination {lat,lng,address} shape).
class GeoPoint {
  final double lat;
  final double lng;
  final String? address;

  const GeoPoint({required this.lat, required this.lng, this.address});

  LatLng get latLng => LatLng(lat, lng);

  Map<String, dynamic> toJson() => {
    'lat': lat,
    'lng': lng,
    if (address != null) 'address': address,
  };

  static GeoPoint? fromJson(dynamic json) {
    if (json is! Map) return null;
    final map = Map<String, dynamic>.from(json);
    final lat = map.dbl(['lat', 'latitude', 'y']);
    final lng = map.dbl(['lng', 'lon', 'lng', 'longitude', 'x']);
    if (lat == null || lng == null) {
      // Some backends nest under coordinates:[lng,lat] (GeoJSON order).
      final coords = map.pick(['coordinates', 'location.coordinates']);
      if (coords is List && coords.length >= 2) {
        return GeoPoint(
          lat: (coords[1] as num).toDouble(),
          lng: (coords[0] as num).toDouble(),
          address: map.str(['address', 'name', 'label']),
        );
      }
      return null;
    }
    return GeoPoint(
      lat: lat,
      lng: lng,
      address: map.str(['address', 'name', 'label']),
    );
  }
}

/// Result of POST /api/map/geocode and /reverse-geocode.
class GeocodeResult {
  final double lat;
  final double lng;
  final String? address;

  const GeocodeResult({required this.lat, required this.lng, this.address});

  LatLng get latLng => LatLng(lat, lng);

  factory GeocodeResult.fromJson(Map<String, dynamic> json) {
    // Response may be wrapped (data/result) or be a list of candidates.
    final map = json.mapField(['data', 'result', 'location']) ?? json;
    final point = GeoPoint.fromJson(map);
    return GeocodeResult(
      lat: point?.lat ?? map.dbl(['lat', 'latitude']) ?? 0,
      lng: point?.lng ?? map.dbl(['lng', 'lon', 'longitude']) ?? 0,
      address: map.str(['address', 'formattedAddress', 'displayName', 'name']),
    );
  }
}

/// Result of POST /api/map/route — geometry + fare estimate + distance.
class RouteEstimate {
  final List<LatLng> points;
  final double? distanceMeters;
  final double? durationSeconds;
  final double? fare;

  const RouteEstimate({
    required this.points,
    this.distanceMeters,
    this.durationSeconds,
    this.fare,
  });

  factory RouteEstimate.fromJson(Map<String, dynamic> json) {
    final root = json.mapField(['data', 'result', 'route']) ?? json;

    // Geometry: GeoJSON LineString coordinates [lng,lat], or polyline list,
    // or nested under geometry.coordinates / routes[0].geometry.
    final coords = root.pick([
      'geometry.coordinates',
      'coordinates',
      'points',
      'polyline',
      'routes.0.geometry.coordinates',
    ]);
    final points = <LatLng>[];
    if (coords is List) {
      for (final c in coords) {
        if (c is List && c.length >= 2) {
          points.add(LatLng((c[1] as num).toDouble(), (c[0] as num).toDouble()));
        } else if (c is Map) {
          final m = Map<String, dynamic>.from(c);
          final lat = m.dbl(['lat', 'latitude']);
          final lng = m.dbl(['lng', 'lon', 'longitude']);
          if (lat != null && lng != null) points.add(LatLng(lat, lng));
        }
      }
    }

    return RouteEstimate(
      points: points,
      distanceMeters: root.dbl([
        'distance',
        'distanceMeters',
        'distance_m',
        'routes.0.distance',
      ]),
      durationSeconds: root.dbl([
        'duration',
        'durationSeconds',
        'duration_s',
        'eta',
        'routes.0.duration',
      ]),
      fare: root.dbl(['fare', 'fareEstimate', 'estimatedFare', 'price', 'cost']),
    );
  }
}

/// A trip as returned by /api/trips/* . Tolerant to id/_id, status variants,
/// driver id under driverId/driver._id, fare/price, pin, rating.
class TripModel {
  final String id;
  final TripStatus status;
  final String rawStatus;
  final GeoPoint? origin;
  final GeoPoint? destination;
  final String? driverId;
  final String? riderId;
  final String? riderName;
  final String? pin;
  final double? fare;
  final double? distanceMeters;
  final String? cancelReason;
  final double? riderRating;
  final double? driverRating;
  final List<LatLng> routePoints;

  const TripModel({
    required this.id,
    required this.status,
    required this.rawStatus,
    this.origin,
    this.destination,
    this.driverId,
    this.riderId,
    this.riderName,
    this.pin,
    this.fare,
    this.distanceMeters,
    this.cancelReason,
    this.riderRating,
    this.driverRating,
    this.routePoints = const [],
  });

  factory TripModel.fromJson(Map<String, dynamic> json) {
    // unwrap { data: {...} } / { trip: {...} }
    final map = json.mapField(['data', 'trip', 'result']) ?? json;

    final rawStatus = map.str(['status', 'state', 'tripStatus']) ?? '';

    // driver id can be a plain id or a nested populated object.
    String? driverId = map.str(['driverId', 'driver_id', 'driver']);
    final driverObj = map.mapField(['driver']);
    if (driverObj != null) {
      driverId = driverObj.str(['id', '_id', 'userId']) ?? driverId;
    }

    String? riderId = map.str(['riderId', 'rider_id', 'rider', 'userId']);
    final riderObj = map.mapField(['rider', 'user']);
    String? riderName = map.str(['riderName']);
    if (riderObj != null) {
      riderId = riderObj.str(['id', '_id']) ?? riderId;
      riderName ??= riderObj.str(['name', 'fullName']);
    }

    final geo = RouteEstimate.fromJson(map);

    return TripModel(
      id: map.str(['id', '_id', 'tripId']) ?? '',
      status: tripStatusFromString(rawStatus),
      rawStatus: rawStatus,
      origin: GeoPoint.fromJson(map.pick(['origin', 'pickup', 'from'])),
      destination:
          GeoPoint.fromJson(map.pick(['destination', 'dropoff', 'to'])),
      driverId: driverId,
      riderId: riderId,
      riderName: riderName,
      // PIN: 4-digit code the driver needs to start the trip.
      pin: map.str(['pin', 'startPin', 'otp', 'code']),
      fare: map.dbl(['fare', 'price', 'cost', 'fareEstimate', 'estimatedFare']),
      distanceMeters: map.dbl(['distance', 'distanceMeters']),
      cancelReason: map.str(['cancelReason', 'reason', 'cancellationReason']),
      riderRating: map.dbl(['riderRating', 'ratingByDriver']),
      driverRating: map.dbl(['driverRating', 'ratingByRider']),
      routePoints: geo.points,
    );
  }
}
