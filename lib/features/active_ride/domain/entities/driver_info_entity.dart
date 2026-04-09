import 'package:equatable/equatable.dart';

import '../../../../core/constants/app_strings.dart';

class DriverInfoEntity extends Equatable {
  final String name;
  final String carModel;
  final String plateNumber;
  final double rating;
  final String? photoUrl;

  const DriverInfoEntity({
    required this.name,
    required this.carModel,
    required this.plateNumber,
    required this.rating,
    required this.photoUrl,
  });

  const DriverInfoEntity.mock()
    : name = AppStrings.michaelScott,
      carModel = AppStrings.whiteTeslaModel3,
      plateNumber = AppStrings.voltPlateNumber,
      rating = 4.9,
      photoUrl = null;

  @override
  List<Object?> get props => [name, carModel, plateNumber, rating, photoUrl];
}
