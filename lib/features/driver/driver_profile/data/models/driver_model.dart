import '../../../../../core/network/repository_base.dart';
import 'verification_model.dart';

/// Driver profile payload — parsed from GET /api/driver/profile/me.
class DriverModel {
  final String id;
  final String name;
  final String email;
  final String phone;
  final String photoUrl;
  final String licenseNumber;
  final String carMake;
  final String licensePlate;
  final String carModel;
  final String carColor;
  final String carYear;
  final double rating;
  final int totalReviews;
  final int completedTrips;
  final int targetTrips;
  final String onlineFor;
  final String joinDate;
  final double? acceptanceRate;
  final double? cancellationRate;
  final bool isOnline;
  final String status;
  final VerificationModel verification;

  const DriverModel({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.photoUrl,
    required this.licenseNumber,
    required this.carMake,
    required this.licensePlate,
    required this.carModel,
    required this.carColor,
    required this.carYear,
    required this.rating,
    required this.totalReviews,
    required this.completedTrips,
    required this.targetTrips,
    required this.onlineFor,
    required this.joinDate,
    this.acceptanceRate,
    this.cancellationRate,
    required this.isOnline,
    required this.status,
    required this.verification,
  });

  factory DriverModel.fromJson(Map<String, dynamic> json) {
    final map = json.mapField(['data', 'driver', 'profile', 'user']) ?? json;
    final vehicle = map.mapField(['vehicleInfo', 'vehicle', 'car']) ?? const {};
    final goal = map.mapField(['goal', 'weeklyGoal', 'tripGoal']) ?? const {};

    return DriverModel(
      id: map.str(['id', '_id', 'userId']) ?? '',
      name: map.str(['name', 'fullName']) ?? '',
      email: map.str(['email']) ?? '',
      phone: map.str(['phone', 'phoneNumber']) ?? '',
      photoUrl: map.str(['photoUrl', 'photo_url', 'photo', 'avatar']) ?? '',
      licenseNumber: map.str(['licenseNumber', 'license', 'licenseNo']) ?? '',
      carMake: vehicle.str(['make', 'brand']) ?? '',
      licensePlate: vehicle.str(['plate', 'plateNumber', 'licensePlate']) ??
          map.str(['license_plate', 'licensePlate']) ??
          '',
      carModel: vehicle.str(['model', 'car_model']) ?? '',
      carColor: vehicle.str(['color', 'car_color']) ?? '',
      carYear: vehicle.str(['year', 'car_year']) ?? '',
      rating: map.dbl(['rating', 'averageRating']) ?? 0,
      totalReviews: map.integer(['totalReviews', 'total_reviews', 'reviewCount']) ??
          0,
      completedTrips: goal.integer(['completedTrips', 'completed_trips']) ??
          map.integer(['completedTrips', 'completed_trips', 'total_trips', 'totalTrips']) ??
          0,
      targetTrips: goal.integer(['targetTrips', 'target_trips']) ??
          map.integer(['targetTrips', 'target_trips']) ??
          0,
      onlineFor: map.str(['onlineFor', 'online_for', 'onlineDuration']) ?? '',
      joinDate: map.str(['joinDate', 'join_date', 'memberSince', 'createdAt']) ??
          '',
      acceptanceRate: map.dbl(['acceptanceRate', 'acceptance_rate']),
      cancellationRate: map.dbl(['cancellationRate', 'cancellation_rate']),
      isOnline: map.boolean(['isAvailable', 'is_online', 'online']) ?? false,
      status: map.str(['status', 'approvalStatus']) ?? '',
      verification: VerificationModel.fromJson(
        map.mapField(['verification', 'documents', 'compliance']),
      ),
    );
  }

  String get vehicleDisplay =>
      [carColor, carMake, carModel].where((s) => s.isNotEmpty).join(' ');

  /// Goal progress ratio in [0, 1].
  double get goalProgress =>
      targetTrips > 0 ? (completedTrips / targetTrips).clamp(0.0, 1.0) : 0;

  int get goalProgressPercent => (goalProgress * 100).round();

  String get verificationStatusLabel => verification.overallStatusLabel;

  String get formattedJoinDate {
    if (joinDate.isEmpty) return '';
    final parsed = DateTime.tryParse(joinDate);
    if (parsed == null) return joinDate;
    const months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ];
    return '${months[parsed.month - 1]} ${parsed.year}';
  }

  String? get profilePhotoUrl {
    final item = verification.itemFor(VerificationDocumentType.profilePhoto);
    if (item.fileUrl != null && item.fileUrl!.isNotEmpty) {
      return item.fileUrl;
    }
    return photoUrl.isNotEmpty ? photoUrl : null;
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'email': email,
        'phone': phone,
        'photo_url': photoUrl,
        'licenseNumber': licenseNumber,
        'license_plate': licensePlate,
        'car_make': carMake,
        'car_model': carModel,
        'car_color': carColor,
        'car_year': carYear,
        'rating': rating,
        'total_reviews': totalReviews,
        'completed_trips': completedTrips,
        'target_trips': targetTrips,
        'online_for': onlineFor,
        'join_date': joinDate,
        if (acceptanceRate != null) 'acceptance_rate': acceptanceRate,
        if (cancellationRate != null) 'cancellation_rate': cancellationRate,
        'is_online': isOnline,
        'status': status,
        'verification': verification.toJson(),
      };

  DriverModel copyWith({
    bool? isOnline,
    VerificationModel? verification,
  }) {
    return DriverModel(
      id: id,
      name: name,
      email: email,
      phone: phone,
      photoUrl: photoUrl,
      licenseNumber: licenseNumber,
      carMake: carMake,
      licensePlate: licensePlate,
      carModel: carModel,
      carColor: carColor,
      carYear: carYear,
      rating: rating,
      totalReviews: totalReviews,
      completedTrips: completedTrips,
      targetTrips: targetTrips,
      onlineFor: onlineFor,
      joinDate: joinDate,
      acceptanceRate: acceptanceRate,
      cancellationRate: cancellationRate,
      isOnline: isOnline ?? this.isOnline,
      status: status,
      verification: verification ?? this.verification,
    );
  }
}
