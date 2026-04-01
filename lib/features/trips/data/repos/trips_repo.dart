import '../models/trip_model.dart';
import '../../../../core/network/dio_client.dart';

class TripsRepo {
  final DioClient _dioClient;

  TripsRepo(this._dioClient);

  Future<List<TripModel>> getTripHistory() async {
    await Future.delayed(const Duration(seconds: 1)); // Mock delay
    return const [
      TripModel(
        id: '1',
        date: 'Oct 24, 2024',
        time: '14:30',
        pickup: '123 Main St, Springfield',
        dropoff: '456 Corporate Blvd',
        price: 18.50,
        status: 'Completed',
      ),
      TripModel(
        id: '2',
        date: 'Oct 22, 2024',
        time: '09:15',
        pickup: 'Home',
        dropoff: 'City Center Mall',
        price: 12.00,
        status: 'Completed',
      ),
      TripModel(
        id: '3',
        date: 'Oct 15, 2024',
        time: '18:45',
        pickup: 'Central Station',
        dropoff: 'Home',
        price: 15.75,
        status: 'Cancelled',
      ),
    ];
  }
}
