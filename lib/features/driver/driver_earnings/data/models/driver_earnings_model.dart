class DriverEarningsModel {
  final double todayEarnings;
  final double weekEarnings;
  final double monthEarnings;
  final int todayTrips;
  final int weekTrips;
  final int monthTrips;
  final double totalOnlineHours;
  final double acceptanceRate;
  final double rating;
  final List<DailyEarning> weeklyBreakdown;

  DriverEarningsModel({
    required this.todayEarnings,
    required this.weekEarnings,
    required this.monthEarnings,
    required this.todayTrips,
    required this.weekTrips,
    required this.monthTrips,
    required this.totalOnlineHours,
    required this.acceptanceRate,
    required this.rating,
    required this.weeklyBreakdown,
  });

  factory DriverEarningsModel.fromJson(Map<String, dynamic> json) {
    return DriverEarningsModel(
      todayEarnings: (json['today_earnings'] ?? 0.0).toDouble(),
      weekEarnings: (json['week_earnings'] ?? 0.0).toDouble(),
      monthEarnings: (json['month_earnings'] ?? 0.0).toDouble(),
      todayTrips: json['today_trips'] ?? 0,
      weekTrips: json['week_trips'] ?? 0,
      monthTrips: json['month_trips'] ?? 0,
      totalOnlineHours: (json['total_online_hours'] ?? 0.0).toDouble(),
      acceptanceRate: (json['acceptance_rate'] ?? 0.0).toDouble(),
      rating: (json['rating'] ?? 0.0).toDouble(),
      weeklyBreakdown: (json['weekly_breakdown'] as List<dynamic>? ?? [])
          .map((e) => DailyEarning.fromJson(e))
          .toList(),
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
      day: json['day'] ?? '',
      amount: (json['amount'] ?? 0.0).toDouble(),
      trips: json['trips'] ?? 0,
    );
  }
}
