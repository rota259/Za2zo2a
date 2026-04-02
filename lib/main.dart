import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_core/firebase_core.dart';

import 'core/router/app_router.dart';
import 'core/network/dio_client.dart';

import 'features/auth/data/repos/auth_repo.dart';
import 'features/auth/cubit/auth_cubit.dart';

import 'features/home/cubit/home_cubit.dart';

import 'features/ride/data/repos/ride_repo.dart';
import 'features/ride/cubit/ride_cubit.dart';

import 'features/trips/data/repos/trips_repo.dart';
import 'features/trips/cubit/trips_cubit.dart';

import 'features/profile/cubit/profile_cubit.dart';
import 'features/payment/cubit/payment_cubit.dart';
import 'features/earnings/cubit/earnings_cubit.dart';
import 'core/theme/theme_cubit.dart';

import 'features/driver/driver_home/data/repos/driver_home_repo.dart';
import 'features/driver/driver_home/cubit/driver_home_cubit.dart';
import 'features/driver/driver_trip/data/repos/driver_trip_repo.dart';
import 'features/driver/driver_trip/cubit/driver_trip_cubit.dart';
import 'features/driver/driver_earnings/data/repos/driver_earnings_repo.dart';
import 'features/driver/driver_earnings/cubit/driver_earnings_cubit.dart';
import 'features/driver/driver_profile/data/repos/driver_profile_repo.dart';
import 'features/driver/driver_profile/cubit/driver_profile_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(); // Keeping Firebase as it was in original

  // Setup Dependency Injection manually
  final dioClient = DioClient();
  final authRepo = AuthRepo(dioClient);
  final rideRepo = RideRepo(dioClient);
  final tripsRepo = TripsRepo(dioClient);
  final driverHomeRepo = DriverHomeRepo(dioClient);
  final driverTripRepo = DriverTripRepo(dioClient);
  final driverEarningsRepo = DriverEarningsRepo(dioClient);
  final driverProfileRepo = DriverProfileRepo(dioClient);

  runApp(MyApp(
    authRepo: authRepo,
    rideRepo: rideRepo,
    tripsRepo: tripsRepo,
    driverHomeRepo: driverHomeRepo,
    driverTripRepo: driverTripRepo,
    driverEarningsRepo: driverEarningsRepo,
    driverProfileRepo: driverProfileRepo,
  ));
}

class MyApp extends StatelessWidget {
  final AuthRepo authRepo;
  final RideRepo rideRepo;
  final TripsRepo tripsRepo;
  final DriverHomeRepo driverHomeRepo;
  final DriverTripRepo driverTripRepo;
  final DriverEarningsRepo driverEarningsRepo;
  final DriverProfileRepo driverProfileRepo;

  const MyApp({
    super.key,
    required this.authRepo,
    required this.rideRepo,
    required this.tripsRepo,
    required this.driverHomeRepo,
    required this.driverTripRepo,
    required this.driverEarningsRepo,
    required this.driverProfileRepo,
  });

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthCubit>(create: (context) => AuthCubit(authRepo)),
        BlocProvider<HomeCubit>(create: (context) => HomeCubit()),
        BlocProvider<RideCubit>(create: (context) => RideCubit(rideRepo)),
        BlocProvider<TripsCubit>(create: (context) => TripsCubit(tripsRepo)),
        BlocProvider<ProfileCubit>(create: (context) => ProfileCubit()),
        BlocProvider<PaymentCubit>(create: (context) => PaymentCubit()),
        BlocProvider<EarningsCubit>(create: (context) => EarningsCubit()),
        BlocProvider<ThemeCubit>(create: (context) => ThemeCubit()),
        BlocProvider<DriverHomeCubit>(create: (context) => DriverHomeCubit(driverHomeRepo)),
        BlocProvider<DriverTripCubit>(create: (context) => DriverTripCubit(driverTripRepo)),
        BlocProvider<DriverEarningsCubit>(create: (context) => DriverEarningsCubit(driverEarningsRepo)),
        BlocProvider<DriverProfileCubit>(create: (context) => DriverProfileCubit(driverProfileRepo)),
      ],
      child: BlocBuilder<ThemeCubit, ThemeMode>(
        builder: (context, themeMode) {
          return MaterialApp.router(
            debugShowCheckedModeBanner: false,
            title: 'Za2zo2a',
            themeMode: themeMode,
            theme: ThemeData(
              primaryColor: const Color(0xFFE23030),
              scaffoldBackgroundColor: Colors.white,
              appBarTheme: const AppBarTheme(
                elevation: 0,
                backgroundColor: Colors.white,
                iconTheme: IconThemeData(color: Colors.black),
              ),
            ),
            darkTheme: ThemeData.dark().copyWith(
              primaryColor: const Color(0xFFE23030),
              scaffoldBackgroundColor: const Color(0xFF121212),
              appBarTheme: const AppBarTheme(
                elevation: 0,
                backgroundColor: Color(0xFF121212),
                iconTheme: IconThemeData(color: Colors.white),
              ),
            ),
            routerConfig: AppRouter.router,
          );
        },
      ),
    );
  }
}
