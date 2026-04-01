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

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(); // Keeping Firebase as it was in original

  // Setup Dependency Injection manually
  final dioClient = DioClient();
  final authRepo = AuthRepo(dioClient);
  final rideRepo = RideRepo(dioClient);
  final tripsRepo = TripsRepo(dioClient);

  runApp(MyApp(
    authRepo: authRepo,
    rideRepo: rideRepo,
    tripsRepo: tripsRepo,
  ));
}

class MyApp extends StatelessWidget {
  final AuthRepo authRepo;
  final RideRepo rideRepo;
  final TripsRepo tripsRepo;

  const MyApp({
    super.key,
    required this.authRepo,
    required this.rideRepo,
    required this.tripsRepo,
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
