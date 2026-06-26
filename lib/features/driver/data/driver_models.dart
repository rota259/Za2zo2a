import '../../../core/network/repository_base.dart';

class DriverStatsModel {
  final int totalTrips;
  final double totalDistanceKm;
  final double onlineHours;
  final double acceptanceRate;
  final double cancellationRate;
  final double weeklyGoalMiles;
  final double weeklyGoalProgress;
  final String tier;
  final String memberSince;

  DriverStatsModel({
    required this.totalTrips,
    required this.totalDistanceKm,
    required this.onlineHours,
    required this.acceptanceRate,
    required this.cancellationRate,
    required this.weeklyGoalMiles,
    required this.weeklyGoalProgress,
    required this.tier,
    required this.memberSince,
  });

  factory DriverStatsModel.fromJson(Map<String, dynamic> rawJson) {
    final map = rawJson.containsKey('data') 
        ? Map<String, dynamic>.from(rawJson['data'] as Map? ?? {}) 
        : rawJson;
    return DriverStatsModel(
      totalTrips: map.integer(['totalTrips']) ?? 0,
      totalDistanceKm: map.dbl(['totalDistanceKm']) ?? 0,
      onlineHours: map.dbl(['onlineHours']) ?? 0,
      acceptanceRate: map.dbl(['acceptanceRate']) ?? 0,
      cancellationRate: map.dbl(['cancellationRate']) ?? 0,
      weeklyGoalMiles: map.dbl(['weeklyGoalMiles']) ?? 0,
      weeklyGoalProgress: map.dbl(['weeklyGoalProgress']) ?? 0,
      tier: map.str(['tier']) ?? 'Standard',
      memberSince: map.str(['memberSince']) ?? '',
    );
  }
}

class DriverBalanceModel {
  final double pendingBalance;
  final double totalLifetime;
  final String currency;

  DriverBalanceModel({
    required this.pendingBalance,
    required this.totalLifetime,
    required this.currency,
  });

  factory DriverBalanceModel.fromJson(Map<String, dynamic> rawJson) {
    final map = rawJson.containsKey('data') 
        ? Map<String, dynamic>.from(rawJson['data'] as Map? ?? {}) 
        : rawJson;
    return DriverBalanceModel(
      pendingBalance: map.dbl(['pendingBalance', 'balance']) ?? 0,
      totalLifetime: map.dbl(['totalLifetime']) ?? 0,
      currency: map.str(['currency']) ?? 'EGP',
    );
  }
}

class DriverBonusModel {
  final int target;
  final int completed;
  final double reward;
  final String currency;
  final String tier;
  final bool achieved;

  DriverBonusModel({
    required this.target,
    required this.completed,
    required this.reward,
    required this.currency,
    required this.tier,
    required this.achieved,
  });

  factory DriverBonusModel.fromJson(Map<String, dynamic> rawJson) {
    final map = rawJson.containsKey('data') 
        ? Map<String, dynamic>.from(rawJson['data'] as Map? ?? {}) 
        : rawJson;
    return DriverBonusModel(
      target: map.integer(['target']) ?? 1,
      completed: map.integer(['completed']) ?? 0,
      reward: map.dbl(['reward']) ?? 0,
      currency: map.str(['currency']) ?? 'EGP',
      tier: map.str(['tier']) ?? 'Standard',
      achieved: map['achieved'] == true,
    );
  }
}
