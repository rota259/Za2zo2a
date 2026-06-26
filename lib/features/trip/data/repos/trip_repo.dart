import '../../../../core/network/api_endpoints.dart';
import '../../../../core/network/dio_client.dart';
import '../../../../core/network/repository_base.dart';
import '../models/trip_models.dart';

/// Rider + shared trip endpoints (/api/trips/*). All real HTTP.
class TripRepo with RepositoryBase {
  final DioClient _client;

  TripRepo(this._client);

  /// Rider requests a trip → POST /api/trips
  Future<TripModel> requestTrip({
    required GeoPoint origin,
    required GeoPoint destination,
  }) {
    return guard(() async {
      final res = await _client.dio.post(
        ApiEndpoints.trips,
        data: {
          'origin': origin.toJson(),
          'destination': destination.toJson(),
        },
      );
      return TripModel.fromJson(_asMap(res.data));
    });
  }

  /// GET /api/trips/:id — used by the tracking poller.
  Future<TripModel> getTrip(String id) {
    return guard(() async {
      final res = await _client.dio.get(ApiEndpoints.trip(id));
      return TripModel.fromJson(_asMap(res.data));
    });
  }

  /// GET /api/trips/active — returns the user's current non-completed trip,
  /// or null if none exists.
  Future<TripModel?> getActiveTrip() {
    return guard(() async {
      final res = await _client.dio.get(ApiEndpoints.activeTrip);
      final map = _asMap(res.data);
      final data = map['data'];
      if (data == null) return null;
      if (data is Map) return TripModel.fromJson(Map<String, dynamic>.from(data));
      return null;
    });
  }

  /// POST /api/trips/:id/cancel
  Future<void> cancelTrip(String id, {required String reason}) {
    return guard(() async {
      await _client.dio.post(
        ApiEndpoints.cancelTrip(id),
        data: {'reason': reason},
      );
    });
  }

  /// POST /api/trips/:id/rate  (rider or driver)
  Future<void> rateTrip(String id, {required int rating, String? comment}) {
    return guard(() async {
      await _client.dio.post(
        ApiEndpoints.rateTrip(id),
        data: {'rating': rating, 'comment': ?comment},
      );
    });
  }

  /// GET /api/trips/history?page=&limit=
  Future<List<TripModel>> history({int page = 1, int limit = 10}) {
    return guard(() async {
      final res = await _client.dio.get(
        ApiEndpoints.tripHistory,
        queryParameters: {'page': page, 'limit': limit},
      );
      return _asList(res.data).map(TripModel.fromJson).toList();
    });
  }

  Map<String, dynamic> _asMap(dynamic data) =>
      data is Map ? Map<String, dynamic>.from(data) : <String, dynamic>{};

  /// History may be a bare list or wrapped under data/trips/results/items.
  List<Map<String, dynamic>> _asList(dynamic data) {
    dynamic list = data;
    if (data is Map) {
      list = data['data'] ??
          data['trips'] ??
          data['results'] ??
          data['items'] ??
          data['docs'] ??
          const [];
    }
    if (list is! List) return const [];
    return list
        .whereType<Map>()
        .map((e) => Map<String, dynamic>.from(e))
        .toList();
  }
}
