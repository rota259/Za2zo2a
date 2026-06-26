import '../../../core/network/repository_base.dart';

/// GET /api/driver/earnings?period= . Tolerant to total/amount, trips/rides.
class EarningsModel {
  final double total;
  final int trips;
  final String period;
  final String? currency;

  const EarningsModel({
    required this.total,
    required this.trips,
    required this.period,
    this.currency,
  });

  factory EarningsModel.fromJson(Map<String, dynamic> json, {String? period}) {
    final map = json.mapField(['data']) ?? json;
    return EarningsModel(
      total: map.dbl(['totalEarnings', 'total', 'amount', 'sum', 'earnings']) ??
          0,
      trips: map.integer(['totalTrips', 'trips', 'tripCount', 'count']) ??
          0,
      period: map.str(['period']) ?? period ?? 'week',
      currency: map.str(['currency']),
    );
  }
}
