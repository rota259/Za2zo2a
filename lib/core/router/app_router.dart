import 'package:go_router/go_router.dart';

// We will import views as we create them
import '../../features/splash/views/splash_view.dart';
import '../../features/auth/views/login_view.dart';
import '../../features/auth/views/signup_view.dart';
import '../../features/auth/views/otp_view.dart';
import '../../features/home/views/home_view.dart';
import '../../features/ride/views/ride_selection_view.dart';
import '../../features/ride/views/active_trip_view.dart';
import '../../features/ride/views/finding_driver_view.dart';
import '../../features/ride/views/trip_summary_view.dart';
import '../../features/ride/views/driver_rating_view.dart';
import '../../features/home/views/search_location_view.dart';
import '../../features/trips/views/trip_history_view.dart';

import '../../features/profile/views/profile_view.dart';
import '../../features/profile/views/settings_view.dart';
import '../../features/payment/views/payment_view.dart';
import '../../features/earnings/views/earnings_view.dart';
import '../../features/notifications/views/notifications_view.dart';
import '../../features/safety/views/safety_view.dart';

class AppRouter {
  static final router = GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => const SplashView(), // To be defined
      ),
      GoRoute(
        path: '/login',
        builder: (context, state) => const LoginView(),
      ),
      GoRoute(
        path: '/signup',
        builder: (context, state) => const SignupView(),
      ),
      GoRoute(
        path: '/otp',
        builder: (context, state) => const OtpView(),
      ),
      GoRoute(
        path: '/home',
        builder: (context, state) => const HomeView(),
      ),
      GoRoute(
        path: '/home/search/:type',
        builder: (context, state) => SearchLocationView(locationType: state.pathParameters['type'] ?? 'destination'),
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
        path: '/trips',
        builder: (context, state) => const TripHistoryView(),
      ),
      GoRoute(
        path: '/profile',
        builder: (context, state) => const ProfileView(),
      ),
      GoRoute(
        path: '/settings',
        builder: (context, state) => const SettingsView(),
      ),
      GoRoute(
        path: '/payment',
        builder: (context, state) => const PaymentView(),
      ),
      GoRoute(
        path: '/earnings',
        builder: (context, state) => const EarningsView(),
      ),
      GoRoute(
        path: '/notifications',
        builder: (context, state) => const NotificationsView(),
      ),
      GoRoute(
        path: '/safety',
        builder: (context, state) => const SafetyView(),
      ),
    ],
  );
}
