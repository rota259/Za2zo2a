import 'package:latlong2/latlong.dart';

import '../../../core/network/api_endpoints.dart';
import '../../../core/network/dio_client.dart';
import '../../../core/network/repository_base.dart';
import '../../auth/data/models/auth_model.dart';
import '../../trip/data/models/trip_models.dart';
import 'driver_models.dart';
import 'earnings_model.dart';

/// Driver-side endpoints (/api/driver/* and the driver trip actions).
/// All real HTTP. No mocks.
class DriverRepo with RepositoryBase {
  final DioClient _client;

  DriverRepo(this._client);

  // ── Status / location ──────────────────────────────────────────────────
  Future<void> setAvailability(bool isAvailable) {
    return guard(() async {
      await _client.dio.patch(
        ApiEndpoints.driverStatus,
        data: {'isOnline': isAvailable},
      );
    });
  }

  Future<void> updateLocation(LatLng point) {
    return guard(() async {
      await _client.dio.patch(
        ApiEndpoints.driverLocation,
        data: {'lat': point.latitude, 'lng': point.longitude},
      );
    });
  }

  // ── Matching / trips ───────────────────────────────────────────────────
  /// GET /api/trips/available — open "requested" trips for this driver.
  Future<List<TripModel>> availableTrips() {
    return guard(() async {
      final res = await _client.dio.get(ApiEndpoints.availableTrips);
      return _asList(res.data).map(TripModel.fromJson).toList();
    });
  }

  /// POST /api/trips/:id/accept — first to accept wins; a 4xx means taken.
  Future<TripModel> acceptTrip(String id) {
    return guard(() async {
      final res = await _client.dio.post(ApiEndpoints.acceptTrip(id));
      return TripModel.fromJson(_asMap(res.data));
    });
  }

  /// POST /api/trips/:id/start { pin }
  Future<TripModel> startTrip(String id, {required String pin}) {
    return guard(() async {
      final res = await _client.dio.post(
        ApiEndpoints.startTrip(id),
        data: {'pin': pin},
      );
      return TripModel.fromJson(_asMap(res.data));
    });
  }

  /// POST /api/trips/:id/complete
  Future<TripModel> completeTrip(String id) {
    return guard(() async {
      final res = await _client.dio.post(ApiEndpoints.completeTrip(id));
      return TripModel.fromJson(_asMap(res.data));
    });
  }

  // ── Profile / earnings ─────────────────────────────────────────────────
  Future<EarningsModel> earnings({String period = 'week'}) {
    return guard(() async {
      final res = await _client.dio.get(
        ApiEndpoints.driverEarnings,
        queryParameters: {'period': period},
      );
      return EarningsModel.fromJson(_asMap(res.data), period: period);
    });
  }

  // ── Stats / Balance / Bonus ─────────────────────────────────────────
  Future<DriverStatsModel> getStats() {
    return guard(() async {
      final res = await _client.dio.get(ApiEndpoints.driverStats);
      return DriverStatsModel.fromJson(_asMap(res.data));
    });
  }

  Future<DriverBalanceModel> getBalance() {
    return guard(() async {
      final res = await _client.dio.get(ApiEndpoints.driverBalance);
      return DriverBalanceModel.fromJson(_asMap(res.data));
    });
  }

  Future<DriverBonusModel> getBonus() {
    return guard(() async {
      final res = await _client.dio.get(ApiEndpoints.driverBonus);
      return DriverBonusModel.fromJson(_asMap(res.data));
    });
  }

  // ── Wallet / Bank ─────────────────────────────────────────────────────
  Future<void> saveWallet(Map<String, dynamic> data) {
    return guard(() async {
      await _client.dio.patch(ApiEndpoints.driverWallet, data: data);
    });
  }

  Future<void> saveBank(Map<String, dynamic> data) {
    return guard(() async {
      await _client.dio.patch(ApiEndpoints.driverBank, data: data);
    });
  }

  /// GET /api/driver/profile — the logged-in driver.
  Future<UserModel> myProfile() {
    return guard(() async {
      final res = await _client.dio.get(ApiEndpoints.driverProfile);
      final map = _asMap(res.data);
      return UserModel.fromJson(
        map.mapField(['data', 'driver', 'profile', 'user']) ?? map,
      );
    });
  }

  /// GET /api/driver/profile/:id — public; a rider viewing their driver.
  Future<UserModel> driverById(String id) {
    return guard(() async {
      final res = await _client.dio.get(ApiEndpoints.driverProfileById(id));
      final map = _asMap(res.data);
      return UserModel.fromJson(
        map.mapField(['data', 'driver', 'profile', 'user']) ?? map,
      );
    });
  }

  Map<String, dynamic> _asMap(dynamic data) =>
      data is Map ? Map<String, dynamic>.from(data) : <String, dynamic>{};

  List<Map<String, dynamic>> _asList(dynamic data) {
    dynamic list = data;
    if (data is Map) {
      list = data['data'] ??
          data['trips'] ??
          data['results'] ??
          data['items'] ??
          const [];
    }
    if (list is! List) return const [];
    return list
        .whereType<Map>()
        .map((e) => Map<String, dynamic>.from(e))
        .toList();
  }
}
