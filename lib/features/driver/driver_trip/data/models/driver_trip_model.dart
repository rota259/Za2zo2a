class DriverTripModel {
  final String id;
  final String riderName;
  final String riderPhoto;
  final double riderRating;
  final String pickupAddress;
  final String destinationAddress;
  final double distanceKm;
  final int durationMinutes;
  final double fare;
  final String paymentMethod;
  final String rideType;
  final String status; // 'heading_to_pickup' | 'trip_started' | 'completed'
  final DateTime createdAt;

  DriverTripModel({
    required this.id,
    required this.riderName,
    required this.riderPhoto,
    required this.riderRating,
    required this.pickupAddress,
    required this.destinationAddress,
    required this.distanceKm,
    required this.durationMinutes,
    required this.fare,
    required this.paymentMethod,
    required this.rideType,
    required this.status,
    required this.createdAt,
  });

  factory DriverTripModel.fromJson(Map<String, dynamic> json) {
    return DriverTripModel(
      id: json['id'] ?? '',
      riderName: json['rider_name'] ?? '',
      riderPhoto: json['rider_photo'] ?? '',
      riderRating: (json['rider_rating'] ?? 0.0).toDouble(),
      pickupAddress: json['pickup_address'] ?? '',
      destinationAddress: json['destination_address'] ?? '',
      distanceKm: (json['distance_km'] ?? 0.0).toDouble(),
      durationMinutes: json['duration_minutes'] ?? 0,
      fare: (json['fare'] ?? 0.0).toDouble(),
      paymentMethod: json['payment_method'] ?? 'cash',
      rideType: json['ride_type'] ?? 'Volt Mini',
      status: json['status'] ?? 'completed',
      createdAt: DateTime.tryParse(json['created_at'] ?? '') ?? DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'rider_name': riderName,
      'rider_photo': riderPhoto,
      'rider_rating': riderRating,
      'pickup_address': pickupAddress,
      'destination_address': destinationAddress,
      'distance_km': distanceKm,
      'duration_minutes': durationMinutes,
      'fare': fare,
      'payment_method': paymentMethod,
      'ride_type': rideType,
      'status': status,
      'created_at': createdAt.toIso8601String(),
    };
  }
}
