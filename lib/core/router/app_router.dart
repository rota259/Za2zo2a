import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:latlong2/latlong.dart';

import '../../core/widgets/main_shell.dart';
import '../../features/active_ride/presentation/cubit/active_ride_cubit.dart'
    as active_ride;
import '../../features/active_ride/presentation/view/active_ride_screen.dart';
import '../../features/auth/views/login_view.dart';
import '../../features/auth/views/otp_view.dart';
import '../../features/auth/views/signup_view.dart';
import '../../features/driver/driver_earnings/views/driver_earnings_view.dart';
import '../../features/driver/driver_home/views/driver_home_view.dart';
import '../../features/driver/driver_payment/views/driver_payment_view.dart';
import '../../features/driver/driver_profile/views/driver_profile_view.dart';
import '../../features/driver/driver_trip/views/driver_active_trip_view.dart';
import '../../features/driver/driver_trip/views/driver_trip_history_view.dart';
import '../../features/driver/driver_trip/views/driver_trip_summary_view.dart';
import '../../features/driver_trip/presentation/cubit/driver_trip_cubit.dart'
    as driver_trip;
import '../../features/driver_trip/presentation/view/driver_trip_screen.dart';
import '../../features/home/presentation/cubit/home_cubit.dart' as volt_home;
import '../../features/home/presentation/view/home_screen.dart';
import '../../features/home/views/search_location_view.dart';
import '../../features/map/domain/usecases/get_user_location_use_case.dart';
import '../../features/map/presentation/view/map_view.dart';
import '../../features/map/presentation/viewmodel/map_cubit.dart';
import '../../features/notifications/views/notifications_view.dart';
import '../../features/payment/views/payment_view.dart';
import '../../features/profile/views/profile_view.dart';
import '../../features/profile/views/settings_view.dart';
import '../../features/ride/views/active_trip_view.dart';
import '../../features/ride/views/driver_rating_view.dart';
import '../../features/ride/views/finding_driver_view.dart';
import '../../features/ride/views/ride_selection_view.dart';
import '../../features/ride/views/trip_summary_view.dart';
import '../../features/role_selection/views/role_selection_view.dart';
import '../../features/safety/views/safety_view.dart';
import '../../features/splash/views/splash_view.dart';
import '../../features/trips/views/trip_history_view.dart';
import '../../injection_container.dart';

class AppRouter {
  static final router = GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(path: '/', builder: (context, state) => const SplashView()),
      GoRoute(path: '/splash', builder: (context, state) => const SplashView()),
      GoRoute(
        path: '/role-selection',
        builder: (context, state) => const RoleSelectionView(),
      ),
      GoRoute(path: '/login', builder: (context, state) => const LoginView()),
      GoRoute(path: '/signup', builder: (context, state) => const SignupView()),
      GoRoute(path: '/otp', builder: (context, state) => const OtpView()),
      GoRoute(
        path: '/active-ride/:rideId',
        builder: (context, state) {
          final extras = _RideRouteExtras.fromExtra(state.extra);
          return BlocProvider<active_ride.ActiveRideCubit>(
            create: (context) => sl<active_ride.ActiveRideCubit>(),
            child: ActiveRideScreen(
              rideId: state.pathParameters['rideId']!,
              origin: extras.origin,
              destination: extras.destination,
            ),
          );
        },
      ),
      GoRoute(
        path: '/driver-trip/:rideId',
        builder: (context, state) => BlocProvider<driver_trip.DriverTripCubit>(
          create: (context) =>
              sl<driver_trip.DriverTripCubit>()
                ..loadTrip(state.pathParameters['rideId']!),
          child: DriverTripScreen(rideId: state.pathParameters['rideId']!),
        ),
      ),
      GoRoute(
        path: '/home/search/:type',
        builder: (context, state) => SearchLocationView(
          locationType: state.pathParameters['type'] ?? 'destination',
        ),
      ),
      GoRoute(
        path: '/home/ride-selection',
        builder: (context, state) => const RideSelectionView(),
      ),
      GoRoute(
        path: '/home/finding-driver',
        builder: (context, state) => const FindingDriverView(),
      ),
      GoRoute(
        path: '/home/active-trip',
        builder: (context, state) => const ActiveTripView(),
      ),
      GoRoute(
        path: '/home/trip-summary',
        builder: (context, state) => const TripSummaryView(),
      ),
      GoRoute(
        path: '/home/driver-rating',
        builder: (context, state) => const DriverRatingView(),
      ),
      GoRoute(
        path: '/settings',
        builder: (context, state) => const SettingsView(),
      ),
      GoRoute(
        path: '/notifications',
        builder: (context, state) => const NotificationsView(),
      ),
      GoRoute(path: '/safety', builder: (context, state) => const SafetyView()),
      GoRoute(
        path: '/driver/home',
        builder: (context, state) => const DriverHomeView(),
      ),
      GoRoute(
        path: '/driver/active-trip',
        builder: (context, state) => const DriverActiveTripView(),
      ),
      GoRoute(
        path: '/driver/trip-summary',
        builder: (context, state) => const DriverTripSummaryView(),
      ),
      GoRoute(
        path: '/driver/trips',
        builder: (context, state) => const DriverTripHistoryView(),
      ),
      GoRoute(
        path: '/driver/earnings',
        builder: (context, state) => const DriverEarningsView(),
      ),
      GoRoute(
        path: '/driver/profile',
        builder: (context, state) => const DriverProfileView(),
      ),
      GoRoute(
        path: '/driver/payment',
        builder: (context, state) => const DriverPaymentView(),
      ),
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) =>
            MainShell(navigationShell: navigationShell),
        branches: [
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/home',
                builder: (context, state) => BlocProvider<volt_home.HomeCubit>(
                  create: (context) =>
                      sl<volt_home.HomeCubit>()..loadUserLocation(),
                  child: const HomeScreen(),
                ),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/trips',
                builder: (context, state) => const TripHistoryView(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/map',
                builder: (context, state) => BlocProvider(
                  create: (context) => MapCubit(
                    getUserLocationUseCase: const GetUserLocationUseCase(),
                  )..initLocation(),
                  child: const MapView(),
                ),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/payment',
                builder: (context, state) => const PaymentView(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/profile',
                builder: (context, state) => const ProfileView(),
              ),
            ],
          ),
        ],
      ),
    ],
  );
}

class _RideRouteExtras {
  final LatLng? origin;
  final LatLng? destination;

  const _RideRouteExtras({required this.origin, required this.destination});

  factory _RideRouteExtras.fromExtra(Object? extra) {
    if (extra is Map<String, dynamic>) {
      return _RideRouteExtras(
        origin: extra['origin'] as LatLng?,
        destination: extra['destination'] as LatLng?,
      );
    }
    return const _RideRouteExtras(origin: null, destination: null);
  }
}
