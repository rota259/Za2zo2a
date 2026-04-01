import '../models/ride_model.dart';
import '../../../../core/network/dio_client.dart';

class RideRepo {
  final DioClient _dioClient;

  RideRepo(this._dioClient);

  Future<List<RideModel>> getAvailableRides() async {
    await Future.delayed(const Duration(seconds: 1)); // Mock loading
    return [
      RideModel(
        id: '1',
        title: 'Volt Mini',
        description: 'Budget-friendly, everyday rides',
        price: 12.50,
        durationMinutes: 4,
        driverName: 'Marcus Thompson',
        driverPhoto: '',
        licensePlate: 'ABC-123',
        driverRating: 4.9,
        status: 'available',
      ),
      RideModel(
        id: '2',
        title: 'Volt Mini Pro',
        description: 'Premium everyday rides',
        price: 18.00,
        durationMinutes: 2,
        driverName: 'Sarah Connor',
        driverPhoto: '',
        licensePlate: 'XYZ-987',
        driverRating: 5.0,
        status: 'available',
      ),
      RideModel(
        id: '3',
        title: 'Volt Mini Lite',
        description: 'Most affordable rides',
        price: 9.50,
        durationMinutes: 7,
        driverName: 'John Doe',
        driverPhoto: '',
        licensePlate: 'DEF-456',
        driverRating: 4.5,
        status: 'available',
      ),
    ];
  }
}
