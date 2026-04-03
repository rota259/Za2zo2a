import '../../../../../core/network/dio_client.dart';
import '../models/driver_earnings_model.dart';

class DriverEarningsRepo {
  final DioClient _dioClient;

  DriverEarningsRepo(this._dioClient);

  Future<DriverEarningsModel> getEarnings() async {
    await Future.delayed(const Duration(seconds: 1));

    // TODO: Replace with real API
    // final response = await _dioClient.dio.get('/driver/earnings');
    // return DriverEarningsModel.fromJson(response.data);

    return DriverEarningsModel(
      todayEarnings: 330.00,
      weekEarnings: 1850.50,
      monthEarnings: 7200.00,
      todayTrips: 7,
      weekTrips: 38,
      monthTrips: 152,
      totalOnlineHours: 6.5,
      acceptanceRate: 92.0,
      rating: 4.9,
      weeklyBreakdown: [
        DailyEarning(day: 'Mon', amount: 210.0, trips: 5),
        DailyEarning(day: 'Tue', amount: 320.0, trips: 7),
        DailyEarning(day: 'Wed', amount: 185.0, trips: 4),
        DailyEarning(day: 'Thu', amount: 410.0, trips: 9),
        DailyEarning(day: 'Fri', amount: 290.0, trips: 6),
        DailyEarning(day: 'Sat', amount: 305.5, trips: 7),
        DailyEarning(day: 'Sun', amount: 130.0, trips: 3), // today (partial)
      ],
    );
  }
}
