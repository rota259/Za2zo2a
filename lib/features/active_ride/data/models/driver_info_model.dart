import '../../domain/entities/driver_info_entity.dart';

class DriverInfoModel extends DriverInfoEntity {
  const DriverInfoModel({
    required super.name,
    required super.carModel,
    required super.plateNumber,
    required super.rating,
    required super.photoUrl,
  });

  const DriverInfoModel.mock() : super.mock();
}
