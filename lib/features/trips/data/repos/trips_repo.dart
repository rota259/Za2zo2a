import '../../../../core/network/api_endpoints.dart';
import '../../../../core/network/dio_client.dart';
import '../../../../core/network/repository_base.dart';
import '../models/trip_model.dart';

/// Trip history (rider & driver) — GET /api/trips/history?page=&limit=
class TripsRepo with RepositoryBase {
  final DioClient _dioClient;

  TripsRepo(this._dioClient);

  Future<List<TripModel>> getTripHistory({int page = 1, int limit = 10}) {
    return guard(() async {
      final res = await _dioClient.dio.get(
        ApiEndpoints.tripHistory,
        queryParameters: {'page': page, 'limit': limit},
      );
      return _asList(res.data).map(TripModel.fromJson).toList();
    });
  }

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
