import 'dart:async';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:firebase_core/firebase_core.dart';

import 'core/constants/app_colors.dart';
import 'core/constants/app_strings.dart';
import 'core/network/api_endpoints.dart';
import 'core/network/dio_client.dart';
import 'core/router/app_router.dart';
import 'core/theme/theme_cubit.dart';
import 'injection_container.dart' as di;
import 'injection_container.dart';

import 'features/auth/cubit/auth_cubit.dart';
import 'features/auth/cubit/auth_state.dart';
import 'features/auth/data/repos/auth_repo.dart';
import 'core/services/session_manager.dart';

import 'features/home/cubit/home_cubit.dart';
import 'features/trips/data/repos/trips_repo.dart';
import 'features/trips/cubit/trips_cubit.dart';
import 'features/profile/cubit/profile_cubit.dart';
import 'features/payment/cubit/payment_cubit.dart';

import 'features/driver/driver_earnings/data/repos/driver_earnings_repo.dart';
import 'features/driver/driver_earnings/cubit/driver_earnings_cubit.dart';
import 'features/driver/driver_profile/data/repos/profile_repository.dart';
import 'features/driver/driver_profile/cubit/driver_profile_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  FlutterError.onError = (details) {
    debugPrint('Flutter error: ${details.exceptionAsString()}');
  };
  PlatformDispatcher.instance.onError = (error, stack) {
    debugPrint('Platform error: $error');
    return true;
  };

  try {
    await Firebase.initializeApp();
  } catch (e) {
    debugPrint('Firebase init skipped/failed: $e');
  }

  await di.init();

  debugPrint('[startup] Resolved BASE_URL: ${ApiEndpoints.baseUrl}');

  // Startup connectivity check against GET /health (best-effort, non-blocking).
  unawaited(_healthCheck());

  // On any 401, the interceptor already cleared the session; bounce to login.
  DioClient.onUnauthorized = () {
    AppRouter.router.go('/login');
  };

  runApp(const MyApp());
}

Future<void> _healthCheck() async {
  try {
    await sl<DioClient>().dio.get(ApiEndpoints.health);
    debugPrint('Health check: backend reachable');
  } catch (e) {
    debugPrint('Health check failed (backend may be down): $e');
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthCubit>(
          create: (_) =>
              AuthCubit(sl<AuthRepo>(), sl<SessionManager>())
                ..tryRestoreSession(),
        ),
        BlocProvider<HomeCubit>(create: (_) => HomeCubit()),
        BlocProvider<TripsCubit>(create: (_) => TripsCubit(sl<TripsRepo>())),
        BlocProvider<ProfileCubit>(
          create: (ctx) {
            final cubit = ProfileCubit();
            final authCubit = ctx.read<AuthCubit>();
            if (authCubit.state is Authenticated) {
              cubit.loadFromAuth(authCubit);
            }
            authCubit.stream.listen((state) {
              if (state is Authenticated) cubit.loadFromAuth(authCubit);
            });
            return cubit;
          },
        ),
        BlocProvider<PaymentCubit>(create: (_) => PaymentCubit()),
        BlocProvider<ThemeCubit>(create: (_) => ThemeCubit()),
        BlocProvider<DriverEarningsCubit>(
          create: (_) => DriverEarningsCubit(sl<DriverEarningsRepo>()),
        ),
        BlocProvider<DriverProfileCubit>(
          create: (_) => DriverProfileCubit(sl<ProfileRepository>()),
        ),
      ],
      child: BlocBuilder<ThemeCubit, ThemeMode>(
        builder: (context, themeMode) {
          return MaterialApp.router(
            debugShowCheckedModeBanner: false,
            title: AppStrings.appName,
            themeMode: themeMode,
            // Arabic-first market (Egypt) with English fallback; RTL is handled
            // automatically by MaterialApp based on the active locale.
            locale: const Locale('ar'),
            supportedLocales: const [Locale('ar'), Locale('en')],
            localizationsDelegates: const [
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            theme: ThemeData(
              primaryColor: AppColors.primary,
              scaffoldBackgroundColor: Colors.white,
              appBarTheme: const AppBarTheme(
                elevation: 0,
                backgroundColor: Colors.white,
                iconTheme: IconThemeData(color: Colors.black),
              ),
            ),
            darkTheme: ThemeData.dark().copyWith(
              primaryColor: AppColors.primary,
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
