import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../core/widgets/main_shell.dart';
import '../../features/auth/views/driver_signup_view.dart';
import '../../features/auth/views/login_view.dart';
import '../../features/auth/views/signup_view.dart';
import '../../features/driver/active_trip/driver_trip_cubit.dart'
    as driver_active;
import '../../features/driver/active_trip/driver_trip_screen.dart'
    as driver_active_view;
import '../../features/driver/data/driver_repo.dart';
import '../../features/driver/dispatch/driver_dispatch_cubit.dart';
import '../../features/driver/driver_earnings/views/driver_earnings_view.dart';
import '../../features/driver/driver_home/views/driver_home_view.dart';
import '../../features/driver/driver_payment/views/driver_payment_view.dart';
import '../../features/driver/driver_profile/views/driver_profile_view.dart';
import '../../features/driver/driver_trips/views/driver_trip_history_view.dart';
import '../../features/home/views/home_view.dart';
import '../../features/home/views/pick_on_map_view.dart';
import '../../features/home/views/search_location_view.dart';
import '../../features/notifications/views/notifications_view.dart';
import '../../features/payment/views/payment_view.dart';
import '../../features/profile/views/profile_view.dart';
import '../../features/profile/views/settings_view.dart';
import '../../features/role_selection/views/role_selection_view.dart';
import '../../features/safety/views/safety_view.dart';
import '../../features/splash/views/splash_view.dart';
import '../../features/trip/data/repos/maps_repo.dart';
import '../../features/trip/data/repos/trip_repo.dart';
import '../../features/trip/presentation/tracking/trip_tracking_cubit.dart';
import '../../features/trip/presentation/tracking/trip_tracking_screen.dart';
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
      GoRoute(
        path: '/signup/driver',
        builder: (context, state) => const DriverSignupView(),
      ),

      // ── Rider live trip tracking (after requesting a trip) ────────────────
      GoRoute(
        path: '/trip/:id',
        builder: (context, state) {
          final id = state.pathParameters['id']!;
          return BlocProvider<TripTrackingCubit>(
            create: (_) =>
                TripTrackingCubit(sl<TripRepo>(), sl<DriverRepo>(), id)
                  ..start(),
            child: const TripTrackingScreen(),
          );
        },
      ),
      GoRoute(
        path: '/home/search/:type',
        builder: (context, state) => SearchLocationView(
          locationType: state.pathParameters['type'] ?? 'destination',
        ),
      ),
      GoRoute(
        path: '/home/pick-on-map',
        builder: (context, state) => const PickOnMapView(),
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

      // ── Driver ────────────────────────────────────────────────────────────
      GoRoute(
        path: '/driver/home',
        builder: (context, state) => BlocProvider<DriverDispatchCubit>(
          create: (_) => DriverDispatchCubit(sl<DriverRepo>()),
          child: const DriverHomeView(),
        ),
      ),
      GoRoute(
        path: '/driver/dispatch',
        redirect: (_, __) => '/driver/home',
      ),
      // Active trip: heading-to-pickup → PIN start → in-progress → complete.
      GoRoute(
        path: '/driver/trip/:id',
        builder: (context, state) {
          final id = state.pathParameters['id']!;
          return BlocProvider<driver_active.DriverTripCubit>(
            create: (_) => driver_active.DriverTripCubit(
              sl<TripRepo>(),
              sl<DriverRepo>(),
              sl<MapsRepo>(),
              id,
            )..start(),
            child: const driver_active_view.DriverTripScreen(),
          );
        },
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

      // ── Rider bottom-nav shell ────────────────────────────────────────────
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) =>
            MainShell(navigationShell: navigationShell),
        branches: [
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/home',
                builder: (context, state) => const HomeView(),
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
