import '../../../../core/network/repository_base.dart';

enum UserRole { rider, driver, unknown }

UserRole roleFromString(String? value) {
  switch (value?.toLowerCase().trim()) {
    case 'rider':
    case 'passenger':
    case 'customer':
      return UserRole.rider;
    case 'driver':
    case 'captain':
      return UserRole.driver;
    default:
      return UserRole.unknown;
  }
}

/// Vehicle details for a driver. All fields optional/tolerant.
class VehicleInfo {
  final String? make;
  final String? model;
  final String? plate;
  final String? color;
  final String? year;

  const VehicleInfo({this.make, this.model, this.plate, this.color, this.year});

  factory VehicleInfo.fromJson(Map<String, dynamic> json) {
    return VehicleInfo(
      make: json.str(['make', 'brand']),
      model: json.str(['model']),
      // CONFIRM: plate key — guessing plate|plateNumber|licensePlate|number
      plate: json.str(['plate', 'plateNumber', 'licensePlate', 'number']),
      color: json.str(['color', 'colour']),
      year: json.str(['year']),
    );
  }

  Map<String, dynamic> toJson() => {
    if (make != null) 'make': make,
    if (model != null) 'model': model,
    if (plate != null) 'plate': plate,
    if (color != null) 'color': color,
    if (year != null) 'year': year,
  };

  String get displayName =>
      [color, make, model].where((e) => e != null && e.isNotEmpty).join(' ');
}

/// The authenticated user. Tolerant to id/_id, role/type, nested vehicleInfo.
class UserModel {
  final String id;
  final String name;
  final String email;
  final String phone;
  final UserRole role;

  // Driver-only (null for riders).
  final String? licenseNumber;
  final VehicleInfo? vehicleInfo;
  final double? rating;
  final int? totalRatings;
  final int? totalTrips;
  final bool? isAvailable;
  final String? photoUrl;

  const UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.role,
    this.licenseNumber,
    this.vehicleInfo,
    this.rating,
    this.totalRatings,
    this.totalTrips,
    this.isAvailable,
    this.photoUrl,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    final vehicle = json.mapField(['vehicleInfo', 'vehicle', 'car']);
    return UserModel(
      id: json.str(['id', '_id', 'userId', 'uid']) ?? '',
      name: json.str(['name', 'fullName', 'username']) ?? '',
      email: json.str(['email']) ?? '',
      phone: json.str(['phone', 'phoneNumber', 'mobile']) ?? '',
      role: roleFromString(json.str(['role', 'type', 'userType'])),
      licenseNumber: json.str(['licenseNumber', 'license', 'licenseNo']),
      vehicleInfo: vehicle != null ? VehicleInfo.fromJson(vehicle) : null,
      rating: json.dbl(['rating', 'averageRating', 'ratingAvg']),
      totalRatings: json.integer(['totalRatings', 'total_ratings']),
      totalTrips: json.integer(['totalTrips', 'total_trips', 'trips']),
      isAvailable: json.boolean(['isAvailable', 'available', 'online']),
      photoUrl: json.str(['photoUrl', 'photo', 'avatar', 'profileImage']),
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'email': email,
    'phone': phone,
    'role': role.name,
    if (licenseNumber != null) 'licenseNumber': licenseNumber,
    if (vehicleInfo != null) 'vehicleInfo': vehicleInfo!.toJson(),
    if (rating != null) 'rating': rating,
    if (totalRatings != null) 'totalRatings': totalRatings,
    if (totalTrips != null) 'totalTrips': totalTrips,
    if (isAvailable != null) 'isAvailable': isAvailable,
    if (photoUrl != null) 'photoUrl': photoUrl,
  };

  bool get isDriver => role == UserRole.driver;
}

/// Result of login/register: a token + the user. Both responses are tolerant
/// because the wrapping shape is unconfirmed (top-level vs `data`-wrapped).
class AuthSession {
  final String token;
  final UserModel user;

  const AuthSession({required this.token, required this.user});

  factory AuthSession.fromJson(Map<String, dynamic> json) {
    // token: token | accessToken | jwt | data.token | data.accessToken
    final token = json.str([
      'token',
      'accessToken',
      'jwt',
      'access_token',
      'data.token',
      'data.accessToken',
    ]);

    // user object can be nested under user|data.user|data, or be the root.
    final userMap = json.mapField(['user', 'data.user', 'data']) ?? json;

    return AuthSession(
      token: token ?? '',
      user: UserModel.fromJson(userMap),
    );
  }
}
