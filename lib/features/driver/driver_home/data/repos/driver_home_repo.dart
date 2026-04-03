import '../../../../../core/network/dio_client.dart';
import '../models/ride_request_model.dart';

class DriverHomeRepo {
  final DioClient _dioClient;

  DriverHomeRepo(this._dioClient);

  /// Fetches a simulated incoming ride request (mock).
  /// In production, this would be a WebSocket or long-poll endpoint.
  Future<RideRequestModel?> fetchIncomingRequest() async {
    await Future.delayed(const Duration(seconds: 3));

    // TODO: Replace with real API call
    // final response = await _dioClient.dio.get('/driver/requests/pending');
    // return RideRequestModel.fromJson(response.data);

    return RideRequestModel(
      id: 'req_001',
      riderName: 'Sarah Johnson',
      riderPhoto: '',
      riderRating: 4.8,
      riderTripCount: 143,
      pickupAddress: '25 Oak Street, Downtown',
      destinationAddress: 'Cairo International Airport, Terminal 2',
      distanceKm: 12.4,
      estimatedMinutes: 18,
      fare: 85.00,
      paymentMethod: 'cash',
      rideType: 'Volt Mini',
      pickupLat: 30.0444,
      pickupLng: 31.2357,
      destinationLat: 30.1219,
      destinationLng: 31.4056,
    );
  }

  Future<void> acceptRequest(String requestId) async {
    await Future.delayed(const Duration(milliseconds: 500));
    // TODO: await _dioClient.dio.post('/driver/requests/$requestId/accept');
  }

  Future<void> declineRequest(String requestId) async {
    await Future.delayed(const Duration(milliseconds: 500));
    // TODO: await _dioClient.dio.post('/driver/requests/$requestId/decline');
  }

  Future<void> updateOnlineStatus(bool isOnline) async {
    await Future.delayed(const Duration(milliseconds: 300));
    // TODO: await _dioClient.dio.patch('/driver/status', data: {'is_online': isOnline});
  }
}
