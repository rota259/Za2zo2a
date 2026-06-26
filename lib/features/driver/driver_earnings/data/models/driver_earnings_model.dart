import '../../../../../core/network/repository_base.dart';

/// Parsed from GET /api/driver/earnings → data: { ... }
class DriverEarningsModel {
  final double totalEarnings;
  final int totalTrips;
  final double avgFare;
  final String currency;
  final String period;
  final double totalLifetime;
  final double pendingBalance;
  final List<DailyEarning> weeklyBreakdown;

  DriverEarningsModel({
    required this.totalEarnings,
    required this.totalTrips,
    required this.avgFare,
    required this.currency,
    required this.period,
    required this.totalLifetime,
    required this.pendingBalance,
    required this.weeklyBreakdown,
  });

  /// Parse from the `data` map inside { success, message, data }.
  factory DriverEarningsModel.fromJson(Map<String, dynamic> json) {
    // weeklyBreakdown
    final breakdownRaw = json['weeklyBreakdown'];
    final breakdown = breakdownRaw is List
        ? breakdownRaw
            .whereType<Map>()
            .map((e) => DailyEarning.fromJson(Map<String, dynamic>.from(e)))
            .toList()
        : <DailyEarning>[];

    // nested earnings object
    final earningsMap = json['earnings'];
    double lifetime = 0;
    double pending = 0;
    if (earningsMap is Map) {
      lifetime = (earningsMap['totalLifetime'] as num?)?.toDouble() ?? 0;
      pending = (earningsMap['pendingBalance'] as num?)?.toDouble() ?? 0;
    }

    return DriverEarningsModel(
      totalEarnings:
          json.dbl(['totalEarnings', 'total', 'amount']) ?? 0,
      totalTrips:
          json.integer(['totalTrips', 'trips', 'tripCount']) ?? 0,
      avgFare: json.dbl(['avgFare', 'averageFare']) ?? 0,
      currency: json.str(['currency']) ?? 'EGP',
      period: json.str(['period']) ?? 'week',
      totalLifetime: lifetime,
      pendingBalance: pending,
      weeklyBreakdown: breakdown,
    );
  }
}

class DailyEarning {
  final String day;
  final double amount;
  final int trips;

  DailyEarning({required this.day, required this.amount, required this.trips});

  factory DailyEarning.fromJson(Map<String, dynamic> json) {
    return DailyEarning(
      day: json.str(['day', 'label', 'date']) ?? '',
      amount: json.dbl(['amount', 'total', 'earnings']) ?? 0,
      trips: json.integer(['trips', 'count']) ?? 0,
    );
  }
}
