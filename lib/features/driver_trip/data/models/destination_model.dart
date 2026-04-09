import '../../domain/entities/destination_entity.dart';

class DestinationModel extends DestinationEntity {
  const DestinationModel({
    required super.address,
    required super.lat,
    required super.lng,
    required super.price,
    required super.distanceKm,
    required super.tripTime,
  });

  const DestinationModel.mock() : super.mock();
}
