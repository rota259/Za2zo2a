import '../../../../../core/network/repository_base.dart';
import '../models/driver_model.dart';
import '../models/verification_model.dart';
import '../services/profile_api_service.dart';

/// Driver profile repository — delegates to [ProfileApiService].
class ProfileRepository with RepositoryBase {
  final ProfileApiService _api;

  ProfileRepository(this._api);

  Future<DriverModel> getProfile() {
    return guard(() async {
      final json = await _api.fetchProfile();
      return DriverModel.fromJson(json);
    });
  }

  Future<void> toggleOnlineStatus(bool isOnline) {
    return guard(() => _api.updateAvailability(isOnline));
  }

  Future<void> updateProfile(Map<String, dynamic> data) {
    return guard(() => _api.updateProfile(data));
  }

  Future<VerificationItemModel> uploadDocument({
    required VerificationDocumentType type,
    required String filePath,
  }) {
    return guard(() async {
      final json = await _api.uploadDocument(type: type, filePath: filePath);
      final itemJson = json.mapField(['data', 'document']) ?? json;
      return VerificationItemModel.fromJson(type, itemJson);
    });
  }
}
