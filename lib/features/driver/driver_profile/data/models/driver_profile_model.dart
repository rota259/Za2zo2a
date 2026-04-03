class DriverProfileModel {
  final String id;
  final String name;
  final String email;
  final String phone;
  final String photoUrl;
  final String licensePlate;
  final String carModel;
  final String carColor;
  final String carYear;
  final double rating;
  final int totalTrips;
  final bool isOnline;
  final String status; // 'approved' | 'pending' | 'suspended'

  DriverProfileModel({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.photoUrl,
    required this.licensePlate,
    required this.carModel,
    required this.carColor,
    required this.carYear,
    required this.rating,
    required this.totalTrips,
    required this.isOnline,
    required this.status,
  });

  factory DriverProfileModel.fromJson(Map<String, dynamic> json) {
    return DriverProfileModel(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      phone: json['phone'] ?? '',
      photoUrl: json['photo_url'] ?? '',
      licensePlate: json['license_plate'] ?? '',
      carModel: json['car_model'] ?? '',
      carColor: json['car_color'] ?? '',
      carYear: json['car_year'] ?? '',
      rating: (json['rating'] ?? 0.0).toDouble(),
      totalTrips: json['total_trips'] ?? 0,
      isOnline: json['is_online'] ?? false,
      status: json['status'] ?? 'approved',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'phone': phone,
      'photo_url': photoUrl,
      'license_plate': licensePlate,
      'car_model': carModel,
      'car_color': carColor,
      'car_year': carYear,
      'rating': rating,
      'total_trips': totalTrips,
      'is_online': isOnline,
      'status': status,
    };
  }

  DriverProfileModel copyWith({bool? isOnline}) {
    return DriverProfileModel(
      id: id,
      name: name,
      email: email,
      phone: phone,
      photoUrl: photoUrl,
      licensePlate: licensePlate,
      carModel: carModel,
      carColor: carColor,
      carYear: carYear,
      rating: rating,
      totalTrips: totalTrips,
      isOnline: isOnline ?? this.isOnline,
      status: status,
    );
  }
}
