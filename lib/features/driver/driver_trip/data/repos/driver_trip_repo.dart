import '../../../../../core/network/dio_client.dart';
import '../models/driver_trip_model.dart';

class DriverTripRepo {
  final DioClient _dioClient;

  DriverTripRepo(this._dioClient);

  Future<List<DriverTripModel>> getTripHistory() async {
    await Future.delayed(const Duration(seconds: 1));

    // TODO: Replace with real API
    // final response = await _dioClient.dio.get('/driver/trips');
    // return (response.data as List).map((e) => DriverTripModel.fromJson(e)).toList();

    return [
      DriverTripModel(
        id: 'trip_001',
        riderName: 'Sarah Johnson',
        riderPhoto: '',
        riderRating: 5.0,
        pickupAddress: '25 Oak Street, Downtown',
        destinationAddress: 'Cairo International Airport',
        distanceKm: 12.4,
        durationMinutes: 22,
        fare: 85.00,
        paymentMethod: 'cash',
        rideType: 'Volt Mini',
        status: 'completed',
        createdAt: DateTime.now().subtract(const Duration(hours: 2)),
      ),
      DriverTripModel(
        id: 'trip_002',
        riderName: 'Mohamed Ali',
        riderPhoto: '',
        riderRating: 4.0,
        pickupAddress: 'Tahrir Square',
        destinationAddress: 'Maadi, Ring Road',
        distanceKm: 8.7,
        durationMinutes: 15,
        fare: 60.00,
        paymentMethod: 'card',
        rideType: 'Volt Mini',
        status: 'completed',
        createdAt: DateTime.now().subtract(const Duration(hours: 5)),
      ),
      DriverTripModel(
        id: 'trip_003',
        riderName: 'Layla Hassan',
        riderPhoto: '',
        riderRating: 5.0,
        pickupAddress: 'Heliopolis, Nozha Street',
        destinationAddress: 'City Stars Mall, Nasr City',
        distanceKm: 5.2,
        durationMinutes: 10,
        fare: 40.00,
        paymentMethod: 'cash',
        rideType: 'Volt Mini',
        status: 'completed',
        createdAt: DateTime.now().subtract(const Duration(days: 1)),
      ),
      DriverTripModel(
        id: 'trip_004',
        riderName: 'Omar Khaled',
        riderPhoto: '',
        riderRating: 4.5,
        pickupAddress: 'New Cairo, 5th Settlement',
        destinationAddress: 'Smart Village, 6th of October',
        distanceKm: 22.0,
        durationMinutes: 35,
        fare: 145.00,
        paymentMethod: 'card',
        rideType: 'Volt Mini Pro',
        status: 'completed',
        createdAt: DateTime.now().subtract(const Duration(days: 1, hours: 3)),
      ),
    ];
  }

  Future<void> completeTrip(String tripId, double fare) async {
    await Future.delayed(const Duration(milliseconds: 500));
    // TODO: await _dioClient.dio.post('/driver/trips/$tripId/complete', data: {'fare': fare});
  }

  Future<void> submitRiderRating(String tripId, double rating, String? comment) async {
    await Future.delayed(const Duration(milliseconds: 300));
    // TODO: await _dioClient.dio.post('/driver/trips/$tripId/rating', data: {...});
  }
}
