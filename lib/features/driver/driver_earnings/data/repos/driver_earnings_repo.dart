import '../../../../../core/network/api_endpoints.dart';
import '../../../../../core/network/dio_client.dart';
import '../../../../../core/network/repository_base.dart';
import '../models/driver_earnings_model.dart';

/// GET /api/driver/earnings — single call, unwraps `data`.
class DriverEarningsRepo with RepositoryBase {
  final DioClient _dioClient;

  DriverEarningsRepo(this._dioClient);

  Future<DriverEarningsModel> getEarnings() {
    return guard(() async {
      final res = await _dioClient.dio.get(ApiEndpoints.driverEarnings);
      final raw = res.data;
      Map<String, dynamic> map;
      if (raw is Map) {
        final full = Map<String, dynamic>.from(raw);
        map = full.mapField(['data']) ?? full;
      } else {
        map = <String, dynamic>{};
      }
      return DriverEarningsModel.fromJson(map);
    });
  }
}
