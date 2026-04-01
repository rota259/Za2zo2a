class RideModel {
  final String id;
  final String title;
  final String description;
  final double price;
  final int durationMinutes;
  final String driverName;
  final String driverPhoto;
  final String licensePlate;
  final double driverRating;
  final String status;

  RideModel({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.durationMinutes,
    required this.driverName,
    required this.driverPhoto,
    required this.licensePlate,
    required this.driverRating,
    required this.status,
  });
}
