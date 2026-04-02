class RideRequestModel {
  final String id;
  final String riderName;
  final String riderPhoto;
  final double riderRating;
  final int riderTripCount;
  final String pickupAddress;
  final String destinationAddress;
  final double distanceKm;
  final int estimatedMinutes;
  final double fare;
  final String paymentMethod; // 'cash' | 'card'
  final String rideType; // 'Volt Mini' | 'Volt Mini Pro' | etc.
  final double pickupLat;
  final double pickupLng;
  final double destinationLat;
  final double destinationLng;

  RideRequestModel({
    required this.id,
    required this.riderName,
    required this.riderPhoto,
    required this.riderRating,
    required this.riderTripCount,
    required this.pickupAddress,
    required this.destinationAddress,
    required this.distanceKm,
    required this.estimatedMinutes,
    required this.fare,
    required this.paymentMethod,
    required this.rideType,
    this.pickupLat = 0.0,
    this.pickupLng = 0.0,
    this.destinationLat = 0.0,
    this.destinationLng = 0.0,
  });

  factory RideRequestModel.fromJson(Map<String, dynamic> json) {
    return RideRequestModel(
      id: json['id'] ?? '',
      riderName: json['rider_name'] ?? '',
      riderPhoto: json['rider_photo'] ?? '',
      riderRating: (json['rider_rating'] ?? 0.0).toDouble(),
      riderTripCount: json['rider_trip_count'] ?? 0,
      pickupAddress: json['pickup_address'] ?? '',
      destinationAddress: json['destination_address'] ?? '',
      distanceKm: (json['distance_km'] ?? 0.0).toDouble(),
      estimatedMinutes: json['estimated_minutes'] ?? 0,
      fare: (json['fare'] ?? 0.0).toDouble(),
      paymentMethod: json['payment_method'] ?? 'cash',
      rideType: json['ride_type'] ?? 'Volt Mini',
      pickupLat: (json['pickup_lat'] ?? 0.0).toDouble(),
      pickupLng: (json['pickup_lng'] ?? 0.0).toDouble(),
      destinationLat: (json['destination_lat'] ?? 0.0).toDouble(),
      destinationLng: (json['destination_lng'] ?? 0.0).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'rider_name': riderName,
      'rider_photo': riderPhoto,
      'rider_rating': riderRating,
      'rider_trip_count': riderTripCount,
      'pickup_address': pickupAddress,
      'destination_address': destinationAddress,
      'distance_km': distanceKm,
      'estimated_minutes': estimatedMinutes,
      'fare': fare,
      'payment_method': paymentMethod,
      'ride_type': rideType,
    };
  }
}
