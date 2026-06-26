import 'package:dio/dio.dart';

import '../../../../../core/network/api_endpoints.dart';
import '../../../../../core/network/dio_client.dart';
import '../models/verification_model.dart';

/// HTTP layer for driver profile endpoints.
///
/// All methods issue real requests. Upload endpoints are placeholders until the
/// backend contract is finalized.
class ProfileApiService {
  final DioClient _client;

  ProfileApiService(this._client);

  /// GET /api/driver/profile/me
  Future<Map<String, dynamic>> fetchProfile() async {
    final res = await _client.dio.get(ApiEndpoints.driverProfile);
    return res.data is Map
        ? Map<String, dynamic>.from(res.data as Map)
        : <String, dynamic>{};
  }

  /// PATCH /api/driver/status
  Future<void> updateAvailability(bool isAvailable) async {
    await _client.dio.patch(
      ApiEndpoints.driverStatus,
      data: {'isOnline': isAvailable},
    );
  }

  /// PATCH /api/driver/profile/me — profile fields update.
  Future<void> updateProfile(Map<String, dynamic> data) async {
    await _client.dio.patch(ApiEndpoints.driverEditProfile, data: data);
  }

  /// POST /api/driver/profile/documents/:type — upload a verification document.
  ///
  /// BACKEND TODO: confirm multipart field name (`file` vs `document`).
  Future<Map<String, dynamic>> uploadDocument({
    required VerificationDocumentType type,
    required String filePath,
  }) async {
    final formData = FormData.fromMap({
      'type': type.apiKey,
      'file': await MultipartFile.fromFile(filePath),
    });
    final res = await _client.dio.post(
      ApiEndpoints.driverDocumentUpload(type.apiKey),
      data: formData,
    );
    return res.data is Map
        ? Map<String, dynamic>.from(res.data as Map)
        : <String, dynamic>{};
  }
}
