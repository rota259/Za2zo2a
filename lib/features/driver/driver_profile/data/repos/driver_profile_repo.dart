import '../../../../../core/network/dio_client.dart';
import '../models/driver_profile_model.dart';

class DriverProfileRepo {
  final DioClient _dioClient;

  DriverProfileRepo(this._dioClient);

  Future<DriverProfileModel> getProfile() async {
    await Future.delayed(const Duration(seconds: 1));

    // TODO: Replace with real API
    // final response = await _dioClient.dio.get('/driver/profile');
    // return DriverProfileModel.fromJson(response.data);

    return DriverProfileModel(
      id: 'drv_001',
      name: 'Ahmed Mostafa',
      email: 'ahmed.mostafa@example.com',
      phone: '+20 112 345 6789',
      photoUrl: '',
      licensePlate: 'ABC - 1234',
      carModel: 'Toyota Corolla',
      carColor: 'White',
      carYear: '2022',
      rating: 4.9,
      totalTrips: 1245,
      isOnline: false,
      status: 'approved',
    );
  }

  Future<void> updateProfile(Map<String, dynamic> data) async {
    await Future.delayed(const Duration(seconds: 1));
    // TODO: await _dioClient.dio.patch('/driver/profile', data: data);
  }

  Future<void> toggleOnlineStatus(bool isOnline) async {
    await Future.delayed(const Duration(milliseconds: 400));
    // TODO: await _dioClient.dio.patch('/driver/status', data: {'is_online': isOnline});
  }
}
