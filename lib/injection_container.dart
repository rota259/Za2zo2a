import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

import 'features/active_ride/data/datasources/osrm_remote_datasource.dart';
import 'features/active_ride/data/repositories/ride_repository_impl.dart';
import 'features/active_ride/domain/repositories/ride_repository.dart';
import 'features/active_ride/domain/usecases/get_driver_info_usecase.dart';
import 'features/active_ride/domain/usecases/get_route_usecase.dart';
import 'features/active_ride/presentation/cubit/active_ride_cubit.dart';
import 'features/driver_trip/data/datasources/driver_osrm_datasource.dart';
import 'features/driver_trip/data/repositories/driver_trip_repository_impl.dart';
import 'features/driver_trip/domain/repositories/driver_trip_repository.dart';
import 'features/driver_trip/domain/usecases/end_trip_usecase.dart';
import 'features/driver_trip/domain/usecases/get_driver_route_usecase.dart';
import 'features/driver_trip/domain/usecases/navigate_to_destination_usecase.dart';
import 'features/driver_trip/presentation/cubit/driver_trip_cubit.dart';
import 'features/home/data/datasources/nominatim_remote_datasource.dart';
import 'features/home/data/repositories/nominatim_repository_impl.dart';
import 'features/home/domain/repositories/places_repository.dart';
import 'features/home/domain/usecases/get_user_location_usecase.dart';
import 'features/home/domain/usecases/search_places_usecase.dart';
import 'features/home/presentation/cubit/home_cubit.dart';

final sl = GetIt.instance;

Future<void> init() async {
  if (sl.isRegistered<Dio>()) {
    return;
  }

  sl.registerLazySingleton(
    () => Dio(
      BaseOptions(
        connectTimeout: const Duration(seconds: 15),
        receiveTimeout: const Duration(seconds: 15),
        headers: const {'Accept': 'application/json'},
      ),
    ),
  );

  sl.registerLazySingleton<NominatimRemoteDatasource>(
    () => NominatimRemoteDatasourceImpl(sl()),
  );
  sl.registerLazySingleton<OsrmRemoteDatasource>(
    () => OsrmRemoteDatasourceImpl(sl()),
  );
  sl.registerLazySingleton<DriverOsrmDatasource>(
    () => DriverOsrmDatasourceImpl(sl()),
  );

  sl.registerLazySingleton<PlacesRepository>(
    () => NominatimRepositoryImpl(sl()),
  );
  sl.registerLazySingleton<RideRepository>(() => RideRepositoryImpl(sl()));
  sl.registerLazySingleton<DriverTripRepository>(
    () => DriverTripRepositoryImpl(sl()),
  );

  sl.registerLazySingleton(() => SearchPlacesUsecase(sl()));
  sl.registerLazySingleton(() => const GetUserLocationUsecase());
  sl.registerLazySingleton(() => GetRouteUsecase(sl()));
  sl.registerLazySingleton(() => const GetDriverInfoUsecase());
  sl.registerLazySingleton(() => GetDriverRouteUsecase(sl()));
  sl.registerLazySingleton(() => EndTripUsecase(sl()));
  sl.registerLazySingleton(() => const NavigateToDestinationUsecase());

  sl.registerFactory(() => HomeCubit(sl(), sl()));
  sl.registerFactory(() => ActiveRideCubit(sl(), sl()));
  sl.registerFactory(() => DriverTripCubit(sl(), sl(), sl()));
}
