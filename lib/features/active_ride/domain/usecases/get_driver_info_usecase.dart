import '../../data/models/driver_info_model.dart';
import '../entities/driver_info_entity.dart';

class GetDriverInfoUsecase {
  const GetDriverInfoUsecase();

  DriverInfoEntity call() => const DriverInfoModel.mock();
}
