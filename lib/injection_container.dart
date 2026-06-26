import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

import 'core/network/dio_client.dart';
import 'core/services/session_manager.dart';
import 'features/auth/data/repos/auth_repo.dart';
import 'features/driver/data/driver_repo.dart';
import 'features/driver/driver_earnings/data/repos/driver_earnings_repo.dart';
import 'features/driver/driver_profile/data/repos/profile_repository.dart';
import 'features/driver/driver_profile/data/services/profile_api_service.dart';
import 'features/home/data/datasources/nominatim_remote_datasource.dart';
import 'features/home/data/repositories/nominatim_repository_impl.dart';
import 'features/home/domain/repositories/places_repository.dart';
import 'features/home/domain/usecases/get_user_location_usecase.dart';
import 'features/home/domain/usecases/search_places_usecase.dart';
import 'features/home/cubit/home_cubit.dart';
import 'features/trip/data/repos/maps_repo.dart';
import 'features/trip/data/repos/trip_repo.dart';
import 'features/trips/data/repos/trips_repo.dart';

final sl = GetIt.instance;

Future<void> init() async {
  if (sl.isRegistered<DioClient>()) return;

  // ── Core: session + single configured backend dio ─────────────────────────
  sl.registerLazySingleton<SessionManager>(() => SessionManager());
  sl.registerLazySingleton<DioClient>(() => DioClient(sl<SessionManager>()));
  // External datasource (Nominatim place search) shares the same dio; the auth
  // interceptor only attaches the token to our backend host.
  sl.registerLazySingleton<Dio>(() => sl<DioClient>().dio);

  // ── Auth ──────────────────────────────────────────────────────────────────
  sl.registerLazySingleton<AuthRepo>(
    () => AuthRepo(sl<DioClient>(), sl<SessionManager>()),
  );

  // ── Backend trip / map / driver repos (real HTTP) ─────────────────────────
  sl.registerLazySingleton<MapsRepo>(() => MapsRepo(sl<DioClient>()));
  sl.registerLazySingleton<TripRepo>(() => TripRepo(sl<DioClient>()));
  sl.registerLazySingleton<DriverRepo>(() => DriverRepo(sl<DioClient>()));
  sl.registerLazySingleton<TripsRepo>(() => TripsRepo(sl<DioClient>()));
  sl.registerLazySingleton<DriverEarningsRepo>(
    () => DriverEarningsRepo(sl<DioClient>()),
  );
  sl.registerLazySingleton<ProfileApiService>(
    () => ProfileApiService(sl<DioClient>()),
  );
  sl.registerLazySingleton<ProfileRepository>(
    () => ProfileRepository(sl<ProfileApiService>()),
  );

  // ── Place search (Nominatim) for the rider "where to?" autocomplete ───────
  sl.registerLazySingleton<NominatimRemoteDatasource>(
    () => NominatimRemoteDatasourceImpl(sl()),
  );
  sl.registerLazySingleton<PlacesRepository>(
    () => NominatimRepositoryImpl(sl()),
  );
  sl.registerLazySingleton(() => SearchPlacesUsecase(sl()));
  sl.registerLazySingleton(() => const GetUserLocationUsecase());

  // ── Cubits ────────────────────────────────────────────────────────────────
  sl.registerFactory(() => HomeCubit());

  // Warm the in-memory token cache so the interceptor can attach it.
  await sl<SessionManager>().bootstrap();
}
