import '../../../../core/network/api_endpoints.dart';
import '../../../../core/network/dio_client.dart';
import '../../../../core/network/repository_base.dart';
import '../../../../core/services/session_manager.dart';
import '../models/auth_model.dart';

/// Real auth repository — every method makes an HTTP call via dio and persists
/// the JWT + user through [SessionManager]. No mocks.
class AuthRepo with RepositoryBase {
  final DioClient _client;
  final SessionManager _session;

  AuthRepo(this._client, this._session);

  Future<AuthSession> login({
    required String phone,
    required String password,
  }) {
    return guard(() async {
      final res = await _client.dio.post(
        ApiEndpoints.login,
        data: {'phone': phone, 'password': password},
      );
      final session = AuthSession.fromJson(_asMap(res.data));
      await _persist(session);
      return session;
    });
  }

  Future<AuthSession> registerRider({
    required String name,
    required String phone,
    required String email,
    required String password,
  }) {
    return guard(() async {
      final res = await _client.dio.post(
        ApiEndpoints.register,
        data: {
          'name': name,
          'phone': phone,
          'email': email,
          'password': password,
          'role': 'rider',
        },
      );
      return _afterRegister(res.data, phone: phone, password: password);
    });
  }

  Future<AuthSession> registerDriver({
    required String name,
    required String phone,
    required String email,
    required String password,
    required String licenseNumber,
    required VehicleInfo vehicleInfo,
  }) {
    return guard(() async {
      final res = await _client.dio.post(
        ApiEndpoints.register,
        data: {
          'name': name,
          'phone': phone,
          'email': email,
          'password': password,
          'role': 'driver',
          'licenseNumber': licenseNumber,
          'vehicleInfo': vehicleInfo.toJson(),
        },
      );
      return _afterRegister(res.data, phone: phone, password: password);
    });
  }

  /// GET /api/auth/me — used on boot to restore the session.
  Future<UserModel> me() {
    return guard(() async {
      final res = await _client.dio.get(ApiEndpoints.me);
      final map = _asMap(res.data);
      // user may be at root, under `user`, or under `data`.
      final userMap = map.mapField(['user', 'data.user', 'data']) ?? map;
      final user = UserModel.fromJson(userMap);
      await _session.saveUser(user.toJson());
      return user;
    });
  }

  Future<void> deleteAccount({required String password}) {
    return guard(() async {
      await _client.dio.delete(
        ApiEndpoints.deleteAccount,
        data: {'password': password},
      );
      await _session.clear();
    });
  }

  Future<void> logout() => _session.clear();

  // ── helpers ───────────────────────────────────────────────────────────────

  /// Some backends return a token on register; others require a follow-up
  /// login. Handle both: if no token came back, log in to obtain one.
  Future<AuthSession> _afterRegister(
    dynamic data, {
    required String phone,
    required String password,
  }) async {
    final session = AuthSession.fromJson(_asMap(data));
    if (session.token.isNotEmpty) {
      await _persist(session);
      return session;
    }
    return login(phone: phone, password: password);
  }

  Future<void> _persist(AuthSession session) async {
    if (session.token.isNotEmpty) {
      await _session.saveToken(session.token);
    }
    await _session.saveUser(session.user.toJson());
  }

  Map<String, dynamic> _asMap(dynamic data) {
    if (data is Map<String, dynamic>) return data;
    if (data is Map) return Map<String, dynamic>.from(data);
    return <String, dynamic>{};
  }
}
