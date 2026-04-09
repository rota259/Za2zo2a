# Project Fix Report

## Initial Analyzer Issues
- info - lib/core/widgets/loading_overlay.dart:21:33 - deprecated_member_use
- info - lib/features/auth/views/login_view.dart:165:60 - deprecated_member_use
- info - lib/features/auth/views/login_view.dart:277:40 - deprecated_member_use
- info - lib/features/driver/driver_earnings/views/driver_earnings_view.dart:442:37 - deprecated_member_use
- info - lib/features/driver/driver_earnings/views/driver_earnings_view.dart:496:40 - deprecated_member_use
- warning - lib/features/driver/driver_home/cubit/driver_home_cubit.dart:14:11 - unused_local_variable
- info - lib/features/driver/driver_home/views/driver_home_view.dart:100:40 - deprecated_member_use
- info - lib/features/driver/driver_home/widgets/driver_available_trips.dart:51:48 - deprecated_member_use
- info - lib/features/driver/driver_home/widgets/driver_offline_button.dart:40:69 - deprecated_member_use
- info - lib/features/driver/driver_home/widgets/driver_top_app_bar.dart:45:42 - deprecated_member_use
- info - lib/features/driver/driver_profile/views/driver_profile_view.dart:550:38 - deprecated_member_use
- info - lib/features/driver/driver_trip/views/driver_trip_history_view.dart:297:47 - deprecated_member_use
- info - lib/features/driver/driver_trip/views/driver_trip_history_view.dart:298:44 - deprecated_member_use
- info - lib/features/driver/driver_trip/views/driver_trip_summary_view.dart:80:54 - deprecated_member_use
- info - lib/features/driver/driver_trip/views/widgets/driver_active_trip_sheet.dart:67:46 - deprecated_member_use
- info - lib/features/home/views/widgets/app_drawer.dart:155:46 - deprecated_member_use
- info - lib/features/home/views/widgets/app_drawer.dart:307:28 - deprecated_member_use
- info - lib/features/payment/views/payment_view.dart:108:51 - deprecated_member_use
- info - lib/features/profile/views/profile_view.dart:317:48 - deprecated_member_use
- info - lib/features/profile/views/profile_view.dart:403:40 - deprecated_member_use
- info - lib/features/profile/views/settings_view.dart:99:21 - deprecated_member_use
- info - lib/features/ride/views/driver_rating_view.dart:302:56 - deprecated_member_use
- info - lib/features/ride/views/finding_driver_view.dart:81:49 - deprecated_member_use
- info - lib/features/ride/views/finding_driver_view.dart:111:58 - deprecated_member_use
- info - lib/features/ride/views/widgets/active_trip_details_sheet.dart:70:58 - deprecated_member_use
- info - lib/features/ride/views/widgets/active_trip_details_sheet.dart:224:58 - deprecated_member_use
- info - lib/features/ride/views/widgets/ride_selection_sheet.dart:106:41 - deprecated_member_use
- info - lib/features/safety/views/safety_view.dart:72:43 - deprecated_member_use
- info - lib/features/safety/views/safety_view.dart:96:43 - deprecated_member_use
- info - lib/features/safety/views/safety_view.dart:123:44 - deprecated_member_use
- info - lib/features/safety/views/safety_view.dart:207:48 - deprecated_member_use
- info - lib/features/safety/views/safety_view.dart:325:50 - deprecated_member_use
- info - lib/features/safety/views/safety_view.dart:427:42 - deprecated_member_use
- info - lib/features/safety/views/safety_view.dart:472:30 - deprecated_member_use
## Verification
- flutter analyze: No issues found
- flutter test: Passed
- flutter build apk --debug: Succeeded

## Changed Files
- android/app/src/main/AndroidManifest.xml
- ios/Runner/Info.plist
- lib/core/router/app_router.dart
- lib/core/services/location_service.dart
- lib/core/utils/responsive.dart
- lib/core/widgets/loading_overlay.dart
- lib/features/auth/views/login_view.dart
- lib/features/driver/driver_earnings/views/driver_earnings_view.dart
- lib/features/driver/driver_home/cubit/driver_home_cubit.dart
- lib/features/driver/driver_home/views/driver_home_view.dart
- lib/features/driver/driver_home/widgets/driver_available_trips.dart
- lib/features/driver/driver_home/widgets/driver_offline_button.dart
- lib/features/driver/driver_home/widgets/driver_top_app_bar.dart
- lib/features/driver/driver_profile/views/driver_profile_view.dart
- lib/features/driver/driver_trip/views/driver_trip_history_view.dart
- lib/features/driver/driver_trip/views/driver_trip_summary_view.dart
- lib/features/driver/driver_trip/views/widgets/driver_active_trip_sheet.dart
- lib/features/home/views/widgets/app_drawer.dart
- lib/features/map/data/models/map_location_model.dart
- lib/features/map/domain/usecases/get_user_location_use_case.dart
- lib/features/map/map_constants.dart
- lib/features/map/presentation/view/map_view.dart
- lib/features/map/presentation/view/widgets/map_canvas.dart
- lib/features/map/presentation/view/widgets/map_details_panel.dart
- lib/features/map/presentation/view/widgets/map_empty_state.dart
- lib/features/map/presentation/view/widgets/map_floating_actions.dart
- lib/features/map/presentation/view/widgets/map_interactive_pane.dart
- lib/features/map/presentation/view/widgets/map_loading_overlay.dart
- lib/features/map/presentation/view/widgets/map_location_info_content.dart
- lib/features/map/presentation/view/widgets/map_marker_icon.dart
- lib/features/map/presentation/view/widgets/map_mobile_info_sheet.dart
- lib/features/map/presentation/view/widgets/map_mobile_layout.dart
- lib/features/map/presentation/view/widgets/map_search_bar.dart
- lib/features/map/presentation/view/widgets/map_tablet_layout.dart
- lib/features/map/presentation/view/widgets/map_view_content.dart
- lib/features/map/presentation/viewmodel/map_cubit.dart
- lib/features/map/presentation/viewmodel/map_state.dart
- lib/features/map/view/map_screen.dart
- lib/features/map/view_model/map_cubit.dart
- lib/features/map/view_model/map_state.dart
- lib/features/payment/views/payment_view.dart
- lib/features/profile/views/profile_view.dart
- lib/features/profile/views/settings_view.dart
- lib/features/ride/views/driver_rating_view.dart
- lib/features/ride/views/finding_driver_view.dart
- lib/features/ride/views/widgets/active_trip_details_sheet.dart
- lib/features/ride/views/widgets/ride_selection_sheet.dart
- lib/features/safety/views/safety_view.dart
- macos/Flutter/GeneratedPluginRegistrant.swift
- pubspec.lock
- pubspec.yaml

## Full Corrected Contents

### android/app/src/main/AndroidManifest.xml
`$ext
<manifest xmlns:android="http://schemas.android.com/apk/res/android">
    <uses-permission android:name="android.permission.INTERNET" />
    <uses-permission android:name="android.permission.ACCESS_FINE_LOCATION" />
    <uses-permission android:name="android.permission.ACCESS_COARSE_LOCATION" />

    <application
        android:label="Za2zo2a"
        android:name="${applicationName}"
        android:icon="@mipmap/ic_launcher">
        <activity
            android:name=".MainActivity"
            android:exported="true"
            android:launchMode="singleTop"
            android:taskAffinity=""
            android:theme="@style/LaunchTheme"
            android:configChanges="orientation|keyboardHidden|keyboard|screenSize|smallestScreenSize|locale|layoutDirection|fontScale|screenLayout|density|uiMode"
            android:hardwareAccelerated="true"
            android:windowSoftInputMode="adjustResize">
            <!-- Specifies an Android theme to apply to this Activity as soon as
                 the Android process has started. This theme is visible to the user
                 while the Flutter UI initializes. After that, this theme continues
                 to determine the Window background behind the Flutter UI. -->
            <meta-data
              android:name="io.flutter.embedding.android.NormalTheme"
              android:resource="@style/NormalTheme"
              />
            <intent-filter>
                <action android:name="android.intent.action.MAIN"/>
                <category android:name="android.intent.category.LAUNCHER"/>
            </intent-filter>
        </activity>
        <!-- Don't delete the meta-data below.
             This is used by the Flutter tool to generate GeneratedPluginRegistrant.java -->
        <meta-data
            android:name="flutterEmbedding"
            android:value="2" />
    </application>
    <!-- Required to query activities that can process text, see:
         https://developer.android.com/training/package-visibility and
         https://developer.android.com/reference/android/content/Intent#ACTION_PROCESS_TEXT.

         In particular, this is used by the Flutter engine in io.flutter.plugin.text.ProcessTextPlugin. -->
    <queries>
        <intent>
            <action android:name="android.intent.action.PROCESS_TEXT"/>
            <data android:mimeType="text/plain"/>
        </intent>
    </queries>
</manifest>
```

### ios/Runner/Info.plist
`$ext
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
	<key>CFBundleDevelopmentRegion</key>
	<string>$(DEVELOPMENT_LANGUAGE)</string>
	<key>CFBundleDisplayName</key>
	<string>Za2zo2a</string>
	<key>CFBundleExecutable</key>
	<string>$(EXECUTABLE_NAME)</string>
	<key>CFBundleIdentifier</key>
	<string>$(PRODUCT_BUNDLE_IDENTIFIER)</string>
	<key>CFBundleInfoDictionaryVersion</key>
	<string>6.0</string>
	<key>CFBundleName</key>
	<string>za2zo2a</string>
	<key>CFBundlePackageType</key>
	<string>APPL</string>
	<key>CFBundleShortVersionString</key>
	<string>$(FLUTTER_BUILD_NAME)</string>
	<key>CFBundleSignature</key>
	<string>????</string>
	<key>CFBundleVersion</key>
	<string>$(FLUTTER_BUILD_NUMBER)</string>
	<key>LSRequiresIPhoneOS</key>
	<true/>
	<key>UILaunchStoryboardName</key>
	<string>LaunchScreen</string>
	<key>UIMainStoryboardFile</key>
	<string>Main</string>
	<key>UISupportedInterfaceOrientations</key>
	<array>
		<string>UIInterfaceOrientationPortrait</string>
		<string>UIInterfaceOrientationLandscapeLeft</string>
		<string>UIInterfaceOrientationLandscapeRight</string>
	</array>
	<key>UISupportedInterfaceOrientations~ipad</key>
	<array>
		<string>UIInterfaceOrientationPortrait</string>
		<string>UIInterfaceOrientationPortraitUpsideDown</string>
		<string>UIInterfaceOrientationLandscapeLeft</string>
		<string>UIInterfaceOrientationLandscapeRight</string>
	</array>
	<key>CADisableMinimumFrameDurationOnPhone</key>
	<true/>
	<key>UIApplicationSupportsIndirectInputEvents</key>
	<true/>
	<key>NSLocationWhenInUseUsageDescription</key>
	<string>This app uses your location to center the map and show your current position.</string>
	<key>NSLocationAlwaysUsageDescription</key>
	<string>This app may use location access to keep map-based trip experiences accurate.</string>
</dict>
</plist>
```

### lib/core/router/app_router.dart
`$ext
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
import '../../features/role_selection/views/role_selection_view.dart';
import '../../features/map/presentation/view/map_view.dart';

import '../../features/profile/views/profile_view.dart';
import '../../features/profile/views/settings_view.dart';
import '../../features/payment/views/payment_view.dart';
import '../../features/notifications/views/notifications_view.dart';
import '../../features/safety/views/safety_view.dart';

import '../../features/driver/driver_home/views/driver_home_view.dart';
import '../../features/driver/driver_trip/views/driver_active_trip_view.dart';
import '../../features/driver/driver_trip/views/driver_trip_summary_view.dart';
import '../../features/driver/driver_trip/views/driver_trip_history_view.dart';
import '../../features/driver/driver_earnings/views/driver_earnings_view.dart';
import '../../features/driver/driver_profile/views/driver_profile_view.dart';
import '../../features/driver/driver_payment/views/driver_payment_view.dart';

class AppRouter {
  static final router = GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => const SplashView(), // To be defined
      ),
      GoRoute(
        path: '/role-selection',
        builder: (context, state) => const RoleSelectionView(),
      ),
      GoRoute(path: '/map', builder: (context, state) => const MapView()),
      GoRoute(path: '/login', builder: (context, state) => const LoginView()),
      GoRoute(path: '/signup', builder: (context, state) => const SignupView()),
      GoRoute(path: '/otp', builder: (context, state) => const OtpView()),
      GoRoute(path: '/home', builder: (context, state) => const HomeView()),
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
    ],
  );
}
```

### lib/core/services/location_service.dart
`$ext
import 'package:geolocator/geolocator.dart';

class LocationService {
  /// Check permissions and get current position.
  /// Throws an error if permission is denied.
  static Future<Position> getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
        'Location permissions are permanently denied, we cannot request permissions.',
      );
    }

    return await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
  }

  /// Stream of location updates
  static Stream<Position> getLocationStream() {
    return Geolocator.getPositionStream(
      locationSettings: const LocationSettings(
        accuracy: LocationAccuracy.high,
        distanceFilter: 10,
      ),
    );
  }
}
```

### lib/core/utils/responsive.dart
`$ext
import 'package:flutter/material.dart';

extension ResponsiveContext on BuildContext {
  double get screenHeight => MediaQuery.of(this).size.height;
  double get screenWidth => MediaQuery.of(this).size.width;
  bool get isMobile => screenWidth < 600;
  bool get isTablet => screenWidth >= 600;

  /// Scales width proportionally based on the primary 390px Figma width design
  double widthPct(double px) => (px / 390) * screenWidth;

  /// Scales height proportionally based on the primary 844px Figma height design
  double heightPct(double px) => (px / 844) * screenHeight;

  /// Keeps a uniform scale for text based on width, but applies a clamp
  /// so it doesn't get ridiculously large on tablets or small on tiny screens
  double fontPct(double px) {
    double scale = screenWidth / 390;
    // Don't shrink fonts too small or grow them too big
    scale = scale.clamp(0.8, 1.2);
    return px * scale;
  }
}
```

### lib/core/widgets/loading_overlay.dart
`$ext
import 'package:flutter/material.dart';
import '../constants/app_colors.dart';

class LoadingOverlay extends StatelessWidget {
  final Widget child;
  final bool isLoading;

  const LoadingOverlay({
    super.key,
    required this.child,
    required this.isLoading,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        child,
        if (isLoading)
          Container(
            color: Colors.black.withValues(alpha: 0.3),
            child: Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(AppColors.primary),
              ),
            ),
          ),
      ],
    );
  }
}
```

### lib/features/auth/views/login_view.dart
`$ext
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../core/utils/responsive.dart';
import '../../../core/widgets/custom_text_field.dart';
import '../../../core/widgets/loading_overlay.dart';
import '../cubit/auth_cubit.dart';
import '../cubit/auth_state.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is AuthSuccess) {
          context.go('/home');
        } else if (state is AuthError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
              backgroundColor: AppColors.error,
            ),
          );
        }
      },
      builder: (context, state) {
        return LoadingOverlay(
          isLoading: state is AuthLoading,
          child: Scaffold(
            backgroundColor: AppColors.background,
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              centerTitle: true,
              leading: IconButton(
                icon: const Icon(Icons.arrow_back),
                color: AppColors.primary,
                onPressed: () => context.pop(),
              ),
              title: Text(
                'Za2zo2a',
                style: AppTextStyles.h2(context).copyWith(
                  fontWeight: FontWeight.bold,
                  fontSize: context.fontPct(20),
                ),
              ),
            ),
            body: SafeArea(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: context.widthPct(24)),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      SizedBox(height: context.heightPct(30)),
                      // â”€â”€ Logo
                      Container(
                        width: context.widthPct(60),
                        height: context.widthPct(60),
                        decoration: BoxDecoration(
                          color: const Color(0xFFFFEBEB),
                          borderRadius: BorderRadius.circular(
                            context.widthPct(12),
                          ),
                        ),
                        child: Icon(
                          Icons.flash_on_rounded,
                          color: AppColors.primary,
                          size: context.widthPct(30),
                        ),
                      ),
                      SizedBox(height: context.heightPct(24)),

                      // â”€â”€ Welcome Text
                      Text(
                        'Welcome Back',
                        style: AppTextStyles.h1(context).copyWith(
                          fontSize: context.fontPct(28),
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      SizedBox(height: context.heightPct(8)),
                      Text(
                        'Log in to your Za2zo2a account',
                        style: AppTextStyles.bodyMedium(
                          context,
                        ).copyWith(color: AppColors.textSecondary),
                      ),
                      SizedBox(height: context.heightPct(40)),

                      // â”€â”€ Email/Phone Field
                      _buildFieldLabel(context, 'Email or Phone'),
                      SizedBox(height: context.heightPct(8)),
                      CustomTextField(
                        controller: _emailController,
                        hintText: 'Enter your email or phone',
                        prefixIcon: Icon(
                          Icons.mail_outline_rounded,
                          color: AppColors.grey400,
                        ),
                        keyboardType: TextInputType.emailAddress,
                      ),
                      SizedBox(height: context.heightPct(20)),

                      // â”€â”€ Password Field
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _buildFieldLabel(context, 'Password'),
                          GestureDetector(
                            onTap: () {},
                            child: Text(
                              'Forgot Password?',
                              style: AppTextStyles.bodySmall(context).copyWith(
                                color: AppColors.primary,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: context.heightPct(8)),
                      CustomTextField(
                        controller: _passwordController,
                        hintText: 'Enter your password',
                        prefixIcon: Icon(
                          Icons.lock_outline_rounded,
                          color: AppColors.grey400,
                        ),
                        obscureText: true,
                        suffixIcon: Icon(
                          Icons.visibility_outlined,
                          color: AppColors.grey400,
                        ),
                      ),
                      SizedBox(height: context.heightPct(30)),

                      // â”€â”€ Login Button
                      SizedBox(
                        width: double.infinity,
                        height: context.heightPct(56),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primary,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                context.widthPct(12),
                              ),
                            ),
                            elevation: 8,
                            shadowColor: AppColors.primary.withValues(
                              alpha: 0.4,
                            ),
                          ),
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              context.read<AuthCubit>().login(
                                _emailController.text,
                                _passwordController.text,
                              );
                            }
                          },
                          child: Text(
                            'Login',
                            style: AppTextStyles.button(context).copyWith(
                              fontSize: context.fontPct(18),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: context.heightPct(40)),

                      // â”€â”€ Divider
                      Row(
                        children: [
                          const Expanded(child: Divider()),
                          Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: context.widthPct(16),
                            ),
                            child: Text(
                              'OR CONTINUE WITH',
                              style: AppTextStyles.caption(context).copyWith(
                                color: AppColors.grey400,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 1.2,
                              ),
                            ),
                          ),
                          const Expanded(child: Divider()),
                        ],
                      ),
                      SizedBox(height: context.heightPct(24)),

                      // â”€â”€ Social Buttons
                      Row(
                        children: [
                          Expanded(
                            child: _SocialButton(
                              icon: FaIcon(
                                FontAwesomeIcons.google,
                                size: context.widthPct(18),
                              ),
                              label: 'Google',
                              onTap: () {},
                            ),
                          ),
                          SizedBox(width: context.widthPct(16)),
                          Expanded(
                            child: _SocialButton(
                              icon: FaIcon(
                                FontAwesomeIcons.apple,
                                size: context.widthPct(18),
                              ),
                              label: 'Apple',
                              onTap: () {},
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: context.heightPct(40)),
                    ],
                  ),
                ),
              ),
            ),
            bottomNavigationBar: Padding(
              padding: EdgeInsets.only(bottom: context.heightPct(24)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Don't have an account? ",
                    style: AppTextStyles.bodyMedium(
                      context,
                    ).copyWith(color: AppColors.textSecondary),
                  ),
                  GestureDetector(
                    onTap: () => context.push('/signup'),
                    child: Text(
                      'Sign up for free',
                      style: AppTextStyles.bodyMedium(context).copyWith(
                        color: AppColors.primary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildFieldLabel(BuildContext context, String label) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        label,
        style: AppTextStyles.bodyMedium(context).copyWith(
          fontWeight: FontWeight.bold,
          color: AppColors.textPrimary.withValues(alpha: 0.8),
        ),
      ),
    );
  }
}

class _SocialButton extends StatelessWidget {
  final Widget icon;
  final String label;
  final VoidCallback onTap;

  const _SocialButton({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: context.heightPct(12)),
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.grey200),
          borderRadius: BorderRadius.circular(context.widthPct(12)),
          color: Colors.white,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            icon,
            SizedBox(width: context.widthPct(8)),
            Text(
              label,
              style: AppTextStyles.bodyMedium(
                context,
              ).copyWith(fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
```

### lib/features/driver/driver_earnings/views/driver_earnings_view.dart
`$ext
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../../../core/utils/responsive.dart';
import 'package:go_router/go_router.dart';
import '../cubit/driver_earnings_cubit.dart';

class DriverEarningsView extends StatefulWidget {
  const DriverEarningsView({super.key});

  @override
  State<DriverEarningsView> createState() => _DriverEarningsViewState();
}

class _DriverEarningsViewState extends State<DriverEarningsView> {
  @override
  void initState() {
    super.initState();
    context.read<DriverEarningsCubit>().loadEarnings();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // Top App Bar
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: context.widthPct(16),
                vertical: context.heightPct(12),
              ),
              child: Row(
                children: [
                  Icon(Icons.menu, color: Colors.black, size: 24),
                  SizedBox(width: context.widthPct(16)),
                  Text(
                    'VOLTRIDE',
                    style: TextStyle(
                      color: AppColors.primary,
                      fontWeight: FontWeight.w900,
                      fontSize: context.fontPct(18),
                      letterSpacing: 1.2,
                    ),
                  ),
                  const Spacer(),
                  CircleAvatar(
                    radius: context.widthPct(14),
                    backgroundColor: Colors.blueGrey.shade800,
                    child: Icon(
                      Icons.person,
                      color: Colors.amber.shade200,
                      size: context.widthPct(16),
                    ),
                  ),
                ],
              ),
            ),

            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: context.widthPct(20)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: context.heightPct(20)),
                    Text(
                      'AVAILABLE BALANCE',
                      style: TextStyle(
                        fontSize: 10,
                        color: AppColors.textSecondary,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.0,
                      ),
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.baseline,
                      textBaseline: TextBaseline.alphabetic,
                      children: [
                        Text(
                          '\$2,840',
                          style: AppTextStyles.h1(context).copyWith(
                            fontSize: context.fontPct(48),
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                        Text(
                          '.50',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: context.heightPct(16)),

                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.primary,
                              padding: EdgeInsets.symmetric(
                                vertical: context.heightPct(16),
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            onPressed: () => context.push('/driver/payment'),
                            child: Text(
                              'Withdraw',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: context.widthPct(12)),
                        Container(
                          padding: EdgeInsets.all(context.widthPct(14)),
                          decoration: BoxDecoration(
                            border: Border.all(color: AppColors.grey200),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Icon(
                            Icons.receipt_long_outlined,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: context.heightPct(32)),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Weekly Pulse',
                          style: AppTextStyles.h3(
                            context,
                          ).copyWith(fontWeight: FontWeight.bold),
                        ),
                        Text(
                          'MAY 12 - 18',
                          style: TextStyle(
                            fontSize: 10,
                            color: AppColors.primary,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1.0,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: context.heightPct(16)),

                    // Mock Bar Chart
                    SizedBox(
                      height: 120,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          _Bar(day: 'MON', height: 40, active: false),
                          _Bar(day: 'TUE', height: 60, active: false),
                          _Bar(day: 'WED', height: 80, active: false),
                          _Bar(day: 'THU', height: 100, active: true),
                          _Bar(day: 'FRI', height: 30, active: false),
                          _Bar(day: 'SAT', height: 50, active: false),
                          _Bar(day: 'SUN', height: 70, active: false),
                        ],
                      ),
                    ),
                    SizedBox(height: context.heightPct(24)),

                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'ONLINE TIME',
                                style: TextStyle(
                                  fontSize: 10,
                                  color: AppColors.textSecondary,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 1.0,
                                ),
                              ),
                              Text(
                                '32h 45m',
                                style: AppTextStyles.h3(
                                  context,
                                ).copyWith(fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          width: 1,
                          height: 40,
                          color: AppColors.grey200,
                        ),
                        Padding(padding: EdgeInsets.symmetric(horizontal: 20)),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'TOTAL TRIPS',
                                style: TextStyle(
                                  fontSize: 10,
                                  color: AppColors.textSecondary,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 1.0,
                                ),
                              ),
                              Text(
                                '148',
                                style: AppTextStyles.h3(
                                  context,
                                ).copyWith(fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: context.heightPct(32)),

                    Text(
                      'Performance',
                      style: AppTextStyles.h3(
                        context,
                      ).copyWith(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: context.heightPct(16)),

                    _PerformanceItem(
                      icon: Icons.calendar_today_outlined,
                      title: 'Today vs Yesterday',
                      subtitle: 'DAILY VELOCITY',
                      percentage: '^12%',
                      amount: '+\$42.20',
                      isPositive: true,
                    ),
                    _PerformanceItem(
                      icon: Icons.show_chart,
                      title: 'This Week vs Last',
                      subtitle: 'WEEKLY MOMENTUM',
                      percentage: '^8.4%',
                      amount: '+\$180.00',
                      isPositive: true,
                    ),
                    _PerformanceItem(
                      icon: Icons.calendar_month_outlined,
                      title: 'Monthly Growth',
                      subtitle: 'LONG-TERM TREND',
                      percentage: 'v3.1%',
                      amount: '-\$112.40',
                      isPositive: false,
                    ),
                    SizedBox(height: context.heightPct(24)),

                    // Refer a friend box
                    Container(
                      padding: EdgeInsets.all(context.widthPct(20)),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Colors.orange.shade400,
                            Colors.deepOrange.shade600,
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'REFER A FRIEND',
                            style: AppTextStyles.h3(context).copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.w900,
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            'Expand the fleet and earn high-voltage rewards.',
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: 12,
                            ),
                          ),
                          SizedBox(height: 16),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                '\$500',
                                style: AppTextStyles.h1(context).copyWith(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w900,
                                  fontSize: 36,
                                ),
                              ),
                              SizedBox(width: 8),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 6.0),
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 8,
                                    vertical: 4,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.white24,
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                  child: Text(
                                    'BONUS REWARD',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 9,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 16),
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.white,
                                foregroundColor: Colors.deepOrange,
                                padding: EdgeInsets.symmetric(vertical: 14),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              onPressed: () {},
                              child: Text(
                                'SEND INVITE CODE',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: context.heightPct(32)),
                  ],
                ),
              ),
            ),

            _buildBottomNavMenu(context),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomNavMenu(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 4,
            offset: Offset(0, -2),
          ),
        ],
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _NavIcon(
                icon: Icons.dashboard_outlined,
                label: 'HOME',
                onTap: () => context.go('/driver/home'),
              ),
              _NavIcon(
                icon: Icons.account_balance_wallet,
                label: 'EARNINGS',
                isActive: true,
                onTap: () {},
              ),
              _NavIcon(
                icon: Icons.rocket_launch_outlined,
                label: 'BOOSTER',
                onTap: () => context.go('/driver/trips'),
              ),
              _NavIcon(
                icon: Icons.person_outline,
                label: 'PROFILE',
                onTap: () => context.go('/driver/profile'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Bar extends StatelessWidget {
  final String day;
  final double height;
  final bool active;

  const _Bar({required this.day, required this.height, required this.active});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          width: 28,
          height: height,
          decoration: BoxDecoration(
            color: active
                ? AppColors.primary
                : AppColors.primary.withValues(alpha: 0.2),
            borderRadius: BorderRadius.vertical(top: Radius.circular(4)),
          ),
        ),
        SizedBox(height: 8),
        Text(
          day,
          style: TextStyle(
            fontSize: 10,
            color: active ? AppColors.primary : AppColors.textSecondary,
            fontWeight: active ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ],
    );
  }
}

class _PerformanceItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final String percentage;
  final String amount;
  final bool isPositive;

  const _PerformanceItem({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.percentage,
    required this.amount,
    required this.isPositive,
  });

  @override
  Widget build(BuildContext context) {
    final color = isPositive ? Colors.green : AppColors.primary;
    return Container(
      margin: EdgeInsets.only(bottom: 12),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: AppColors.grey200),
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [
          BoxShadow(color: Colors.black12, blurRadius: 4, offset: Offset(0, 2)),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: AppColors.primary.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: AppColors.primary),
          ),
          SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: AppTextStyles.bodyMedium(
                    context,
                  ).copyWith(fontWeight: FontWeight.bold),
                ),
                Text(
                  subtitle,
                  style: TextStyle(
                    fontSize: 9,
                    color: AppColors.textSecondary,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 0.5,
                  ),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                percentage,
                style: TextStyle(
                  color: color,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              Text(
                amount,
                style: TextStyle(fontSize: 12, color: AppColors.textSecondary),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _NavIcon extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isActive;
  final VoidCallback onTap;

  const _NavIcon({
    required this.icon,
    required this.label,
    this.isActive = false,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            color: isActive ? AppColors.primary : AppColors.grey400,
            size: 24,
          ),
          SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 9,
              color: isActive ? AppColors.primary : AppColors.grey400,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
```

### lib/features/driver/driver_home/cubit/driver_home_cubit.dart
`$ext
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/services/location_service.dart';
import '../data/repos/driver_home_repo.dart';
import 'driver_home_state.dart';

class DriverHomeCubit extends Cubit<DriverHomeState> {
  final DriverHomeRepo _repo;

  DriverHomeCubit(this._repo) : super(DriverHomeInitial()) {
    _fetchInitialLocation();
  }

  Future<void> _fetchInitialLocation() async {
    await LocationService.getCurrentLocation();
  }

  /// Toggle driver online/offline status.
  Future<void> goOnline() async {
    emit(DriverHomeLoading());
    try {
      await _repo.updateOnlineStatus(true);
      emit(const DriverHomeOnline(isListening: true));
      _listenForRequests();
    } catch (e) {
      emit(const DriverHomeError('Failed to go online. Please try again.'));
    }
  }

  Future<void> goOffline() async {
    emit(DriverHomeLoading());
    try {
      await _repo.updateOnlineStatus(false);
      emit(DriverHomeOffline());
    } catch (e) {
      emit(const DriverHomeError('Failed to go offline. Please try again.'));
    }
  }

  /// Simulates listening for incoming ride requests.
  /// In production, replace with WebSocket or FCM notification.
  void _listenForRequests() async {
    if (state is! DriverHomeOnline) return;
    try {
      final request = await _repo.fetchIncomingRequest();
      if (request != null && (state is DriverHomeOnline)) {
        emit(DriverHomeRequestReceived(request));
      }
    } catch (_) {
      // Silently ignore â€“ keep listening
    }
  }

  /// Accept the incoming ride request.
  Future<void> acceptRequest(String requestId) async {
    if (state is! DriverHomeRequestReceived) return;
    final currentRequest = (state as DriverHomeRequestReceived).request;
    try {
      await _repo.acceptRequest(requestId);
      emit(DriverHomeRequestAccepted(currentRequest));
    } catch (e) {
      emit(
        const DriverHomeError('Failed to accept request. Please try again.'),
      );
    }
  }

  /// Decline the incoming ride request and resume listening.
  Future<void> declineRequest(String requestId) async {
    try {
      await _repo.declineRequest(requestId);
      emit(const DriverHomeOnline(isListening: true));
      _listenForRequests();
    } catch (e) {
      emit(const DriverHomeError('Failed to decline request.'));
    }
  }

  /// Called when driver returns home after completing a trip.
  void resetToOnline() {
    emit(const DriverHomeOnline(isListening: true));
    _listenForRequests();
  }
}
```

### lib/features/driver/driver_home/views/driver_home_view.dart
`$ext
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/utils/responsive.dart';
import '../cubit/driver_home_cubit.dart';
import '../cubit/driver_home_state.dart';
import '../../../../features/home/views/widgets/map_floating_button.dart';
import '../../driver_trip/cubit/driver_trip_cubit.dart';
import '../../driver_trip/data/models/driver_trip_model.dart';
import '../widgets/driver_top_app_bar.dart';
import '../widgets/driver_stats_row.dart';
import '../widgets/driver_bonus_card.dart';
import '../widgets/driver_offline_button.dart';
import '../widgets/driver_available_trips.dart';
import '../widgets/driver_bottom_nav.dart';

class DriverHomeView extends StatefulWidget {
  const DriverHomeView({super.key});

  @override
  State<DriverHomeView> createState() => _DriverHomeViewState();
}

class _DriverHomeViewState extends State<DriverHomeView> {
  final MapController _mapController = MapController();

  void _onGpsTap(LatLng? coords) {
    if (coords != null) {
      _mapController.move(coords, 15.0);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DriverHomeCubit, DriverHomeState>(
      listener: (context, state) {
        if (state is DriverHomeRequestAccepted) {
          final req = state.request;
          final trip = DriverTripModel(
            id: req.id,
            riderName: req.riderName,
            riderPhoto: req.riderPhoto,
            riderRating: req.riderRating,
            pickupAddress: req.pickupAddress,
            destinationAddress: req.destinationAddress,
            distanceKm: req.distanceKm,
            durationMinutes: req.estimatedMinutes,
            fare: req.fare,
            paymentMethod: req.paymentMethod,
            rideType: req.rideType,
            status: 'heading_to_pickup',
            createdAt: DateTime.now(),
          );
          context.read<DriverTripCubit>().startHeadingToPickup(trip);
          context.push('/driver/active-trip');
        }
      },
      builder: (context, state) {
        final isOnline =
            state is DriverHomeOnline || state is DriverHomeRequestReceived;
        final hasRequest = state is DriverHomeRequestReceived;

        return Scaffold(
          backgroundColor: AppColors.grey100,
          body: hasRequest
              ? DriverAvailableTrips(req: (state).request)
              : _buildOfflineOrWaitingView(state, isOnline),
          bottomNavigationBar: const DriverBottomNav(),
        );
      },
    );
  }

  Widget _buildOfflineOrWaitingView(DriverHomeState state, bool isOnline) {
    final LatLng center =
        state.currentLocationCoords ?? const LatLng(30.0444, 31.2357);

    return Stack(
      children: [
        FlutterMap(
          mapController: _mapController,
          options: MapOptions(initialCenter: center, initialZoom: 15.0),
          children: [
            TileLayer(
              urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
              userAgentPackageName: 'com.example.flutter_tasks_mostafa',
            ),
          ],
        ),
        Center(
          child: Container(
            width: context.widthPct(40),
            height: context.widthPct(40),
            decoration: BoxDecoration(
              color: AppColors.primary.withValues(alpha: 0.2),
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Container(
                width: context.widthPct(16),
                height: context.widthPct(16),
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white, width: 2),
                ),
              ),
            ),
          ),
        ),
        SafeArea(
          child: Column(
            children: [
              DriverTopAppBar(isOnline: isOnline),
              const DriverStatsRow(),
              SizedBox(height: context.heightPct(16)),
              const DriverBonusCard(),
            ],
          ),
        ),
        Positioned(
          bottom: context.heightPct(100),
          right: context.widthPct(16),
          child: MapFloatingButton(
            icon: Icons.gps_fixed,
            onTap: () => _onGpsTap(state.currentLocationCoords),
          ),
        ),
        DriverOfflineButton(isOnline: isOnline),
      ],
    );
  }
}
```

### lib/features/driver/driver_home/widgets/driver_available_trips.dart
`$ext
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/constants/app_colors.dart';
import '../../../../../core/constants/app_text_styles.dart';
import '../../../../../core/utils/responsive.dart';
import '../data/models/ride_request_model.dart';
import '../cubit/driver_home_cubit.dart';

class DriverAvailableTrips extends StatelessWidget {
  final RideRequestModel req;
  const DriverAvailableTrips({super.key, required this.req});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // AppBar
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: context.widthPct(16),
              vertical: context.heightPct(12),
            ),
            child: Row(
              children: [
                CircleAvatar(
                  radius: context.widthPct(18),
                  backgroundColor: Colors.blueGrey.shade800,
                  child: Icon(
                    Icons.person,
                    color: Colors.amber.shade200,
                    size: context.widthPct(20),
                  ),
                ),
                SizedBox(width: context.widthPct(12)),
                Text(
                  'VoltRide',
                  style: AppTextStyles.h2(context).copyWith(
                    fontWeight: FontWeight.bold,
                    fontSize: context.fontPct(22),
                  ),
                ),
                const Spacer(),
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: context.widthPct(12),
                    vertical: context.heightPct(6),
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.primary.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(context.widthPct(20)),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.sensors,
                        color: AppColors.primary,
                        size: context.widthPct(14),
                      ),
                      SizedBox(width: context.widthPct(4)),
                      Text(
                        'ONLINE',
                        style: AppTextStyles.caption(context).copyWith(
                          color: AppColors.primary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: context.widthPct(16),
              vertical: context.heightPct(16),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Available Trips',
                  style: AppTextStyles.h1(
                    context,
                  ).copyWith(fontWeight: FontWeight.w900),
                ),
                Text(
                  '3 high-demand requests nearby',
                  style: AppTextStyles.bodyMedium(
                    context,
                  ).copyWith(color: AppColors.textSecondary),
                ),
              ],
            ),
          ),

          Expanded(
            child: ListView(
              padding: EdgeInsets.symmetric(horizontal: context.widthPct(16)),
              children: [
                // Highlighted Card
                Container(
                  margin: EdgeInsets.only(bottom: context.heightPct(16)),
                  padding: EdgeInsets.all(context.widthPct(16)),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(context.widthPct(16)),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 10,
                        offset: Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CircleAvatar(
                            radius: context.widthPct(22),
                            backgroundColor: Colors.grey.shade200,
                            backgroundImage: const NetworkImage(
                              'https://i.pravatar.cc/100?img=5',
                            ), // Dummy avatar
                          ),
                          SizedBox(width: context.widthPct(12)),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Sarah Jenkins',
                                  style: AppTextStyles.h3(
                                    context,
                                  ).copyWith(fontWeight: FontWeight.bold),
                                ),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.star,
                                      color: Colors.orange,
                                      size: context.widthPct(14),
                                    ),
                                    Text(
                                      ' 4.9',
                                      style: AppTextStyles.caption(
                                        context,
                                      ).copyWith(fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: context.widthPct(8),
                                  vertical: context.heightPct(4),
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.orange.shade50,
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: Text(
                                  'ðŸ”¥ SURGE 1.4x',
                                  style: AppTextStyles.caption(context)
                                      .copyWith(
                                        color: Colors.orange.shade800,
                                        fontWeight: FontWeight.bold,
                                      ),
                                ),
                              ),
                              SizedBox(height: context.heightPct(6)),
                              Text(
                                '\$24.50',
                                style: AppTextStyles.h2(context).copyWith(
                                  color: AppColors.primary,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                'CONSTANT PRICE',
                                style: TextStyle(
                                  fontSize: 8,
                                  color: AppColors.textSecondary,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: context.heightPct(20)),

                      // Route
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            children: [
                              Icon(
                                Icons.circle,
                                color: AppColors.primary,
                                size: 10,
                              ),
                              Container(
                                width: 2,
                                height: 30,
                                color: AppColors.grey200,
                              ),
                              Icon(Icons.circle, color: Colors.black, size: 10),
                            ],
                          ),
                          SizedBox(width: context.widthPct(12)),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'PICKUP',
                                  style: AppTextStyles.caption(
                                    context,
                                  ).copyWith(color: AppColors.textSecondary),
                                ),
                                Text(
                                  'Grand Central Terminal, NY',
                                  style: AppTextStyles.bodyMedium(
                                    context,
                                  ).copyWith(fontWeight: FontWeight.bold),
                                ),
                                SizedBox(height: context.heightPct(16)),
                                Text(
                                  'DESTINATION',
                                  style: AppTextStyles.caption(
                                    context,
                                  ).copyWith(color: AppColors.textSecondary),
                                ),
                                Text(
                                  'SoHo Boutique District, Broadway',
                                  style: AppTextStyles.bodyMedium(
                                    context,
                                  ).copyWith(fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: context.heightPct(24)),

                      Row(
                        children: [
                          Expanded(
                            flex: 1,
                            child: OutlinedButton(
                              style: OutlinedButton.styleFrom(
                                foregroundColor: AppColors.textSecondary,
                                side: BorderSide(color: AppColors.grey200),
                                padding: EdgeInsets.symmetric(
                                  vertical: context.heightPct(14),
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              onPressed: () => context
                                  .read<DriverHomeCubit>()
                                  .declineRequest(req.id),
                              child: Text(
                                'Decline',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                          SizedBox(width: context.widthPct(12)),
                          Expanded(
                            flex: 2,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.primary,
                                padding: EdgeInsets.symmetric(
                                  vertical: context.heightPct(14),
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                elevation: 0,
                              ),
                              onPressed: () => context
                                  .read<DriverHomeCubit>()
                                  .acceptRequest(req.id),
                              child: Text(
                                'Accept Trip',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                // Priority Request Card
                Container(
                  margin: EdgeInsets.only(bottom: context.heightPct(16)),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(context.widthPct(16)),
                    border: Border.all(color: Colors.orange.shade200, width: 2),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 10,
                        offset: Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: context.widthPct(16),
                          vertical: context.heightPct(10),
                        ),
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(color: AppColors.grey100),
                          ),
                        ),
                        child: Row(
                          children: [
                            Icon(Icons.bolt, color: Colors.orange, size: 18),
                            SizedBox(width: 4),
                            Text(
                              'PRIORITY REQUEST',
                              style: AppTextStyles.caption(context).copyWith(
                                color: Colors.orange,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 1.1,
                              ),
                            ),
                            const Spacer(),
                            Text(
                              '2 min away',
                              style: AppTextStyles.caption(
                                context,
                              ).copyWith(color: AppColors.textSecondary),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(context.widthPct(16)),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'RIDER',
                                      style: TextStyle(
                                        fontSize: 10,
                                        color: AppColors.textSecondary,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          'Marcus T.',
                                          style:
                                              AppTextStyles.bodyMedium(
                                                context,
                                              ).copyWith(
                                                fontWeight: FontWeight.bold,
                                              ),
                                        ),
                                        SizedBox(width: 8),
                                        Container(
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 4,
                                            vertical: 2,
                                          ),
                                          decoration: BoxDecoration(
                                            color: AppColors.grey100,
                                            borderRadius: BorderRadius.circular(
                                              4,
                                            ),
                                          ),
                                          child: Row(
                                            children: [
                                              Text(
                                                '4.7',
                                                style: TextStyle(
                                                  fontSize: 10,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              Icon(
                                                Icons.star,
                                                size: 10,
                                                color: Colors.blueGrey,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(
                                      'EARNINGS',
                                      style: TextStyle(
                                        fontSize: 10,
                                        color: AppColors.textSecondary,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      '\$18.20',
                                      style: AppTextStyles.h3(context).copyWith(
                                        color: AppColors.primary,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(height: context.heightPct(16)),
                            Container(
                              padding: EdgeInsets.all(context.widthPct(12)),
                              decoration: BoxDecoration(
                                color: AppColors.grey50,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.radio_button_unchecked,
                                        color: AppColors.primary,
                                        size: 14,
                                      ),
                                      SizedBox(width: 8),
                                      Text(
                                        'Williamsburg Bridge Plaza',
                                        style: AppTextStyles.bodySmall(context),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 8),
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.location_on_outlined,
                                        color: Colors.black,
                                        size: 14,
                                      ),
                                      SizedBox(width: 8),
                                      Text(
                                        'JFK Terminal 4 - Departures',
                                        style: AppTextStyles.bodySmall(context),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: context.heightPct(16)),
                            SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: AppColors.primary,
                                  padding: EdgeInsets.symmetric(
                                    vertical: context.heightPct(14),
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                                onPressed: () => context
                                    .read<DriverHomeCubit>()
                                    .acceptRequest(req.id),
                                child: Text(
                                  'ACCEPT RAPID RIDE',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 1.1,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
```

### lib/features/driver/driver_home/widgets/driver_offline_button.dart
`$ext
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/constants/app_colors.dart';
import '../../../../../core/constants/app_text_styles.dart';
import '../../../../../core/utils/responsive.dart';
import '../cubit/driver_home_cubit.dart';

class DriverOfflineButton extends StatelessWidget {
  final bool isOnline;

  const DriverOfflineButton({super.key, required this.isOnline});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: context.heightPct(20),
      left: context.widthPct(30),
      right: context.widthPct(30),
      child: GestureDetector(
        onTap: () {
          if (isOnline) {
            context.read<DriverHomeCubit>().goOffline();
          } else {
            context.read<DriverHomeCubit>().goOnline();
          }
        },
        child: Container(
          height: context.heightPct(60),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: isOnline
                  ? [Colors.grey.shade700, Colors.grey.shade900]
                  : [AppColors.primary, Colors.pinkAccent.shade400],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
            borderRadius: BorderRadius.circular(context.widthPct(30)),
            boxShadow: [
              BoxShadow(
                color: (isOnline ? Colors.grey : AppColors.primary).withValues(
                  alpha: 0.4,
                ),
                blurRadius: 15,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                isOnline ? Icons.power_settings_new : Icons.power_settings_new,
                color: Colors.white,
                size: context.widthPct(24),
              ),
              SizedBox(width: context.widthPct(10)),
              Text(
                isOnline ? 'GO OFFLINE' : 'GO ONLINE',
                style: AppTextStyles.button(
                  context,
                ).copyWith(fontWeight: FontWeight.bold, letterSpacing: 1.2),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
```

### lib/features/driver/driver_home/widgets/driver_top_app_bar.dart
`$ext
import 'package:flutter/material.dart';
import '../../../../../core/constants/app_colors.dart';
import '../../../../../core/constants/app_text_styles.dart';
import '../../../../../core/utils/responsive.dart';

class DriverTopAppBar extends StatelessWidget {
  final bool isOnline;

  const DriverTopAppBar({super.key, required this.isOnline});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: context.widthPct(16),
        vertical: context.heightPct(12),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: context.widthPct(18),
            backgroundColor: Colors.blueGrey.shade800,
            child: Icon(
              Icons.person,
              color: Colors.amber.shade200,
              size: context.widthPct(20),
            ),
          ),
          SizedBox(width: context.widthPct(12)),
          Text(
            'VoltRide',
            style: AppTextStyles.h2(context).copyWith(
              fontWeight: FontWeight.bold,
              fontSize: context.fontPct(22),
            ),
          ),
          const Spacer(),
          if (isOnline)
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: context.widthPct(12),
                vertical: context.heightPct(6),
              ),
              decoration: BoxDecoration(
                color: AppColors.primary.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(context.widthPct(20)),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.sensors,
                    color: AppColors.primary,
                    size: context.widthPct(14),
                  ),
                  SizedBox(width: context.widthPct(4)),
                  Text(
                    'ONLINE',
                    style: AppTextStyles.caption(context).copyWith(
                      color: AppColors.primary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            )
          else
            Icon(Icons.sensors_off, color: AppColors.grey500),
        ],
      ),
    );
  }
}
```

### lib/features/driver/driver_profile/views/driver_profile_view.dart
`$ext
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../../../core/utils/responsive.dart';
import '../cubit/driver_profile_cubit.dart';
import '../cubit/driver_profile_state.dart';

class DriverProfileView extends StatefulWidget {
  const DriverProfileView({super.key});

  @override
  State<DriverProfileView> createState() => _DriverProfileViewState();
}

class _DriverProfileViewState extends State<DriverProfileView> {
  @override
  void initState() {
    super.initState();
    context.read<DriverProfileCubit>().loadProfile();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.grey50, // Slight off-white background
      appBar: AppBar(
        title: Text('Profile & Account', style: AppTextStyles.h2(context)),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
      ),
      body: BlocBuilder<DriverProfileCubit, DriverProfileState>(
        builder: (context, state) {
          if (state is DriverProfileLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is DriverProfileError) {
            return Center(child: Text(state.message));
          }
          if (state is! DriverProfileLoaded) {
            return const SizedBox.shrink();
          }

          final profile = state.profile;

          return SingleChildScrollView(
            child: Column(
              children: [
                // â”€â”€ Old Profile Header Elements Combined with New Account Header â”€â”€ //
                Container(
                  color: Colors.white,
                  padding: EdgeInsets.symmetric(
                    horizontal: context.widthPct(20),
                    vertical: context.heightPct(24),
                  ),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Container(
                            width: context.widthPct(60),
                            height: context.widthPct(60),
                            decoration: BoxDecoration(
                              color: Colors.pink.shade50,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Icon(
                              Icons.person,
                              color: const Color(0xFFC2185B),
                              size: 30,
                            ),
                          ),
                          SizedBox(width: context.widthPct(16)),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  profile.name,
                                  style: AppTextStyles.h2(
                                    context,
                                  ).copyWith(fontWeight: FontWeight.w900),
                                ),
                                Text(
                                  'PRO TIER â€¢ ${profile.rating.toStringAsFixed(2)} RATING',
                                  style: TextStyle(
                                    color: Colors.orange,
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 0.5,
                                  ),
                                ),
                                SizedBox(height: 8),
                                Row(
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 8,
                                        vertical: 2,
                                      ),
                                      decoration: BoxDecoration(
                                        color: Colors.green.shade50,
                                        borderRadius: BorderRadius.circular(4),
                                      ),
                                      child: Text(
                                        'ACTIVE',
                                        style: TextStyle(
                                          color: Colors.green,
                                          fontSize: 8,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: 8),
                                    Text(
                                      'Verified Member since 2022',
                                      style: TextStyle(
                                        fontSize: 10,
                                        color: AppColors.textSecondary,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),

                      SizedBox(height: context.heightPct(24)),

                      // Old Profile Stats Row
                      Row(
                        children: [
                          _StatCard(
                            label: 'Acceptance',
                            value: '94%',
                            color: AppColors.success,
                          ),
                          SizedBox(width: context.widthPct(12)),
                          _StatCard(
                            label: 'Cancellation',
                            value: '2%',
                            color: AppColors.error,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                SizedBox(height: context.heightPct(16)),

                // â”€â”€ Combined Middle Content â”€â”€ //
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: context.widthPct(20),
                  ),
                  child: Column(
                    children: [
                      // Vehicle Box
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(context.widthPct(20)),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(color: AppColors.grey200),
                        ),
                        child: Stack(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'CURRENT VEHICLE',
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: AppColors.textSecondary,
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 0.5,
                                  ),
                                ),
                                SizedBox(height: 8),
                                Text(
                                  'EV-4029',
                                  style: AppTextStyles.h2(context).copyWith(
                                    fontWeight: FontWeight.w900,
                                    color: Colors.blueGrey.shade900,
                                  ),
                                ),
                                Text(
                                  'Metallic Burgundy',
                                  style: TextStyle(
                                    color: AppColors.textSecondary,
                                  ),
                                ),
                              ],
                            ),
                            Positioned(
                              right: 0,
                              bottom: 0,
                              child: Icon(
                                Icons.electric_car,
                                color: Colors.pink.shade100,
                                size: 40,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: context.heightPct(16)),

                      // Weekly Goal
                      Container(
                        padding: EdgeInsets.all(context.widthPct(20)),
                        decoration: BoxDecoration(
                          color: const Color(0xFF151D29), // Dark slate blue
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'WEEKLY GOAL',
                              style: TextStyle(
                                fontSize: 10,
                                color: Colors.white70,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 0.5,
                              ),
                            ),
                            SizedBox(height: 8),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.baseline,
                              textBaseline: TextBaseline.alphabetic,
                              children: [
                                Text(
                                  '84%',
                                  style: AppTextStyles.h1(context).copyWith(
                                    color: const Color(0xFFE91E63),
                                    fontWeight: FontWeight.w900,
                                  ),
                                ),
                                Text(
                                  ' of 500 mi',
                                  style: TextStyle(
                                    color: Colors.white70,
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 12),
                            Stack(
                              children: [
                                Container(
                                  height: 6,
                                  decoration: BoxDecoration(
                                    color: Colors.white24,
                                    borderRadius: BorderRadius.circular(3),
                                  ),
                                ),
                                Container(
                                  height: 6,
                                  width: context.widthPct(220),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFE91E63),
                                    borderRadius: BorderRadius.circular(3),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: context.heightPct(24)),

                      // Old Profile Lifetime Stats
                      Container(
                        padding: EdgeInsets.all(context.widthPct(16)),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(
                            context.widthPct(12),
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Lifetime Highlights',
                              style: AppTextStyles.h3(
                                context,
                              ).copyWith(fontWeight: FontWeight.bold),
                            ),
                            SizedBox(height: context.heightPct(12)),
                            _HighlightRow(
                              icon: Icons.thumb_up_outlined,
                              label: '5-Star Trips',
                              value: '4,289',
                            ),
                            SizedBox(height: context.heightPct(8)),
                            _HighlightRow(
                              icon: Icons.access_time,
                              label: 'Years Online',
                              value: '3.5',
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: context.heightPct(24)),

                      // Documents & Compliance
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'DOCUMENTS & COMPLIANCE',
                            style: TextStyle(
                              fontSize: 10,
                              color: Colors.black87,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 1.0,
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.pink.shade50,
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Text(
                              '5 TOTAL',
                              style: TextStyle(
                                color: const Color(0xFFC2185B),
                                fontSize: 8,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: context.heightPct(16)),

                      _DocumentItem(
                        icon: Icons.assignment_ind,
                        title: 'Driving License',
                        subtitle: 'Expires: Oct 2025',
                        status: 'VERIFIED',
                        isVerified: true,
                      ),
                      _DocumentItem(
                        icon: Icons.directions_car,
                        title: 'Car License',
                        subtitle: 'Plate: EV-4029',
                        status: 'VERIFIED',
                        isVerified: true,
                      ),
                      _DocumentItem(
                        icon: Icons.portrait,
                        title: 'Profile Photo',
                        subtitle: 'Updated 2 days ago',
                        status: 'PENDING',
                        isVerified: false,
                      ),
                      _DocumentItem(
                        icon: Icons.gavel,
                        title: 'Criminal Record',
                        subtitle: 'Annual Check',
                        status: 'VERIFIED',
                        isVerified: true,
                      ),
                      _DocumentItem(
                        icon: Icons.public,
                        title: 'Nationality ID',
                        subtitle: 'Government Issued',
                        status: 'VERIFIED',
                        isVerified: true,
                      ),

                      SizedBox(height: context.heightPct(24)),

                      // Action Buttons
                      OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          foregroundColor: const Color(0xFFC2185B),
                          side: BorderSide(color: Colors.pink.shade100),
                          minimumSize: const Size.fromHeight(50),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        onPressed: () {},
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Icon(Icons.swap_horiz, size: 20),
                            SizedBox(width: 8),
                            Text(
                              'Switch Account',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: context.heightPct(12)),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.pink.shade50,
                          foregroundColor: const Color(0xFFC2185B),
                          elevation: 0,
                          minimumSize: const Size.fromHeight(50),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        onPressed: () {},
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Icon(Icons.logout, size: 20),
                            SizedBox(width: 8),
                            Text(
                              'SIGN OUT',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: context.heightPct(32)),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
      bottomNavigationBar: _buildBottomNavMenu(context),
    );
  }

  Widget _buildBottomNavMenu(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 4,
            offset: Offset(0, -2),
          ),
        ],
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _NavIcon(
                icon: Icons.dashboard_outlined,
                label: 'HOME',
                onTap: () => context.go('/driver/home'),
              ),
              _NavIcon(
                icon: Icons.account_balance_wallet_outlined,
                label: 'EARNINGS',
                onTap: () => context.go('/driver/earnings'),
              ),
              _NavIcon(
                icon: Icons.rocket_launch_outlined,
                label: 'BOOSTER',
                onTap: () => context.go('/driver/trips'),
              ),
              _NavIcon(
                icon: Icons.person,
                label: 'PROFILE',
                isActive: true,
                onTap: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  final String label;
  final String value;
  final Color color;
  const _StatCard({
    required this.label,
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.symmetric(vertical: context.heightPct(12)),
        decoration: BoxDecoration(
          color: AppColors.grey50,
          borderRadius: BorderRadius.circular(context.widthPct(12)),
          border: Border.all(color: AppColors.grey200),
        ),
        child: Column(
          children: [
            Text(
              value,
              style: AppTextStyles.h2(
                context,
              ).copyWith(color: color, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: context.heightPct(4)),
            Text(label, style: AppTextStyles.caption(context)),
          ],
        ),
      ),
    );
  }
}

class _HighlightRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  const _HighlightRow({
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          padding: EdgeInsets.all(context.widthPct(8)),
          decoration: BoxDecoration(
            color: AppColors.primary.withValues(alpha: 0.1),
            shape: BoxShape.circle,
          ),
          child: Icon(
            icon,
            color: AppColors.primary,
            size: context.widthPct(16),
          ),
        ),
        SizedBox(width: context.widthPct(12)),
        Text(label, style: AppTextStyles.bodyMedium(context)),
        const Spacer(),
        Text(
          value,
          style: AppTextStyles.bodyMedium(
            context,
          ).copyWith(fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}

class _DocumentItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final String status;
  final bool isVerified;

  const _DocumentItem({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.status,
    required this.isVerified,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppColors.grey100,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: AppColors.textSecondary, size: 20),
          ),
          SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: AppTextStyles.bodyMedium(
                    context,
                  ).copyWith(fontWeight: FontWeight.bold),
                ),
                Text(
                  subtitle,
                  style: TextStyle(
                    fontSize: 10,
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
          Row(
            children: [
              Text(
                status,
                style: TextStyle(
                  fontSize: 9,
                  fontWeight: FontWeight.bold,
                  color: isVerified ? Colors.green : Colors.orange,
                ),
              ),
              SizedBox(width: 4),
              Icon(
                isVerified ? Icons.check_circle : Icons.access_time_filled,
                color: isVerified ? Colors.green : Colors.orange,
                size: 14,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _NavIcon extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isActive;
  final VoidCallback onTap;

  const _NavIcon({
    required this.icon,
    required this.label,
    this.isActive = false,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            color: isActive ? AppColors.primary : AppColors.grey400,
            size: 24,
          ),
          SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 9,
              color: isActive ? AppColors.primary : AppColors.grey400,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
```

### lib/features/driver/driver_trip/views/driver_trip_history_view.dart
`$ext
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../../../core/utils/responsive.dart';
import '../cubit/driver_trip_cubit.dart';
import '../cubit/driver_trip_state.dart';
import '../data/models/driver_trip_model.dart';

class DriverTripHistoryView extends StatefulWidget {
  const DriverTripHistoryView({super.key});

  @override
  State<DriverTripHistoryView> createState() => _DriverTripHistoryViewState();
}

class _DriverTripHistoryViewState extends State<DriverTripHistoryView> {
  @override
  void initState() {
    super.initState();
    context.read<DriverTripCubit>().loadTripHistory();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: AppColors.textPrimary),
          onPressed: () => context.go('/driver/home'),
        ),
        title: Text('Trip History', style: AppTextStyles.h2(context)),
        centerTitle: true,
      ),
      body: BlocBuilder<DriverTripCubit, DriverTripState>(
        builder: (context, state) {
          if (state is DriverTripLoading) {
            return Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation(AppColors.primary),
              ),
            );
          }

          if (state is DriverTripError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.error_outline,
                    size: context.widthPct(60),
                    color: AppColors.error,
                  ),
                  SizedBox(height: context.heightPct(16)),
                  Text(
                    state.message,
                    style: AppTextStyles.bodyMedium(context),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            );
          }

          if (state is! DriverTripHistoryLoaded || state.trips.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.history,
                    size: context.widthPct(70),
                    color: AppColors.grey300,
                  ),
                  SizedBox(height: context.heightPct(16)),
                  Text(
                    'No trips yet',
                    style: AppTextStyles.h3(
                      context,
                    ).copyWith(color: AppColors.textSecondary),
                  ),
                  SizedBox(height: context.heightPct(8)),
                  Text(
                    'Your completed trips will appear here.',
                    style: AppTextStyles.bodyMedium(
                      context,
                    ).copyWith(color: AppColors.textSecondary),
                  ),
                ],
              ),
            );
          }

          final trips = state.trips;
          // Group trips by date
          final Map<String, List<DriverTripModel>> grouped = {};
          for (final t in trips) {
            final key = _formatDate(t.createdAt);
            grouped.putIfAbsent(key, () => []).add(t);
          }

          return Column(
            children: [
              // â”€â”€ Summary Banner
              Container(
                margin: EdgeInsets.fromLTRB(
                  context.widthPct(16),
                  context.heightPct(8),
                  context.widthPct(16),
                  context.heightPct(16),
                ),
                padding: EdgeInsets.all(context.widthPct(16)),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [AppColors.primary, const Color(0xFFB71C1C)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(context.widthPct(16)),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _BannerStat(value: '${trips.length}', label: 'Total Trips'),
                    Container(
                      width: 1,
                      height: context.heightPct(36),
                      color: Colors.white24,
                    ),
                    _BannerStat(
                      value:
                          'EGP ${trips.fold(0.0, (s, t) => s + t.fare).toStringAsFixed(0)}',
                      label: 'Total Earned',
                    ),
                    Container(
                      width: 1,
                      height: context.heightPct(36),
                      color: Colors.white24,
                    ),
                    _BannerStat(
                      value:
                          '${trips.fold(0.0, (s, t) => s + t.distanceKm).toStringAsFixed(1)} km',
                      label: 'Total Distance',
                    ),
                  ],
                ),
              ),

              // â”€â”€ List
              Expanded(
                child: ListView.builder(
                  padding: EdgeInsets.symmetric(
                    horizontal: context.widthPct(16),
                  ),
                  itemCount: grouped.keys.length,
                  itemBuilder: (context, groupIdx) {
                    final dateKey = grouped.keys.elementAt(groupIdx);
                    final dayTrips = grouped[dateKey]!;
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(
                            vertical: context.heightPct(12),
                          ),
                          child: Text(
                            dateKey,
                            style: AppTextStyles.bodyMedium(context).copyWith(
                              fontWeight: FontWeight.bold,
                              color: AppColors.textSecondary,
                            ),
                          ),
                        ),
                        ...dayTrips.map((trip) => _TripCard(trip: trip)),
                      ],
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  String _formatDate(DateTime dt) {
    final now = DateTime.now();
    final diff = now.difference(dt).inDays;
    if (diff == 0) return 'Today';
    if (diff == 1) return 'Yesterday';
    return '${dt.day}/${dt.month}/${dt.year}';
  }
}

class _BannerStat extends StatelessWidget {
  final String value;
  final String label;
  const _BannerStat({required this.value, required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          value,
          style: AppTextStyles.bodyLarge(
            context,
          ).copyWith(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        Text(
          label,
          style: AppTextStyles.caption(context).copyWith(color: Colors.white70),
        ),
      ],
    );
  }
}

class _TripCard extends StatelessWidget {
  final DriverTripModel trip;
  const _TripCard({required this.trip});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: context.heightPct(12)),
      padding: EdgeInsets.all(context.widthPct(16)),
      decoration: BoxDecoration(
        color: AppColors.grey100,
        borderRadius: BorderRadius.circular(context.widthPct(14)),
      ),
      child: Column(
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: context.widthPct(20),
                backgroundColor: AppColors.grey200,
                child: Icon(
                  Icons.person,
                  color: AppColors.grey500,
                  size: context.widthPct(22),
                ),
              ),
              SizedBox(width: context.widthPct(12)),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      trip.riderName,
                      style: AppTextStyles.bodyMedium(
                        context,
                      ).copyWith(fontWeight: FontWeight.bold),
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.star,
                          color: Colors.amber,
                          size: context.widthPct(12),
                        ),
                        SizedBox(width: context.widthPct(2)),
                        Text(
                          trip.riderRating.toStringAsFixed(1),
                          style: AppTextStyles.caption(context),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    'EGP ${trip.fare.toStringAsFixed(0)}',
                    style: AppTextStyles.bodyLarge(context).copyWith(
                      fontWeight: FontWeight.bold,
                      color: AppColors.primary,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: context.heightPct(3)),
                    padding: EdgeInsets.symmetric(
                      horizontal: context.widthPct(8),
                      vertical: context.heightPct(2),
                    ),
                    decoration: BoxDecoration(
                      color: trip.paymentMethod == 'cash'
                          ? AppColors.success.withValues(alpha: 0.1)
                          : AppColors.info.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(context.widthPct(20)),
                    ),
                    child: Text(
                      trip.paymentMethod == 'cash' ? 'Cash' : 'Card',
                      style: AppTextStyles.caption(context).copyWith(
                        color: trip.paymentMethod == 'cash'
                            ? AppColors.success
                            : AppColors.info,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: context.heightPct(12)),
          Container(height: 1, color: AppColors.grey200),
          SizedBox(height: context.heightPct(12)),
          Row(
            children: [
              Icon(
                Icons.radio_button_checked,
                color: AppColors.success,
                size: context.widthPct(14),
              ),
              SizedBox(width: context.widthPct(6)),
              Expanded(
                child: Text(
                  trip.pickupAddress,
                  style: AppTextStyles.bodySmall(context),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          SizedBox(height: context.heightPct(4)),
          Row(
            children: [
              Icon(
                Icons.location_on,
                color: AppColors.error,
                size: context.widthPct(14),
              ),
              SizedBox(width: context.widthPct(6)),
              Expanded(
                child: Text(
                  trip.destinationAddress,
                  style: AppTextStyles.bodySmall(context),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          SizedBox(height: context.heightPct(12)),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _TripChip(
                icon: Icons.route,
                label: '${trip.distanceKm.toStringAsFixed(1)} km',
              ),
              _TripChip(
                icon: Icons.timer_outlined,
                label: '${trip.durationMinutes} min',
              ),
              _TripChip(
                icon: Icons.directions_car_outlined,
                label: trip.rideType,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _TripChip extends StatelessWidget {
  final IconData icon;
  final String label;
  const _TripChip({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: context.widthPct(14), color: AppColors.grey500),
        SizedBox(width: context.widthPct(4)),
        Text(
          label,
          style: AppTextStyles.caption(
            context,
          ).copyWith(color: AppColors.textSecondary),
        ),
      ],
    );
  }
}
```

### lib/features/driver/driver_trip/views/driver_trip_summary_view.dart
`$ext
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../../../core/utils/responsive.dart';
import '../cubit/driver_trip_cubit.dart';
import '../cubit/driver_trip_state.dart';

class DriverTripSummaryView extends StatefulWidget {
  const DriverTripSummaryView({super.key});

  @override
  State<DriverTripSummaryView> createState() => _DriverTripSummaryViewState();
}

class _DriverTripSummaryViewState extends State<DriverTripSummaryView> {
  double _riderRating = 5.0;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DriverTripCubit, DriverTripState>(
      listener: (context, state) {
        if (state is DriverTripInitial) {
          context.go('/driver/home');
        }
      },
      builder: (context, state) {
        return Scaffold(
          backgroundColor: AppColors.background,
          body: SafeArea(
            child: Column(
              children: [
                // Top AppBar
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: context.widthPct(16),
                    vertical: context.heightPct(12),
                  ),
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: context.widthPct(18),
                        backgroundColor: Colors.blueGrey.shade800,
                        child: Icon(
                          Icons.person,
                          color: Colors.amber.shade200,
                          size: context.widthPct(20),
                        ),
                      ),
                      SizedBox(width: context.widthPct(12)),
                      Text(
                        'VoltRide',
                        style: AppTextStyles.h2(context).copyWith(
                          fontWeight: FontWeight.bold,
                          fontSize: context.fontPct(20),
                        ),
                      ),
                      const Spacer(),
                      Icon(Icons.sensors, color: AppColors.primary, size: 20),
                    ],
                  ),
                ),

                Expanded(
                  child: SingleChildScrollView(
                    padding: EdgeInsets.symmetric(
                      horizontal: context.widthPct(24),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(height: context.heightPct(40)),

                        // Checkmark Icon
                        Container(
                          padding: EdgeInsets.all(context.widthPct(12)),
                          decoration: BoxDecoration(
                            color: AppColors.primary.withValues(alpha: 0.1),
                            shape: BoxShape.circle,
                          ),
                          child: Container(
                            padding: EdgeInsets.all(context.widthPct(16)),
                            decoration: BoxDecoration(
                              color: AppColors.primary,
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              Icons.check,
                              color: Colors.white,
                              size: context.widthPct(30),
                            ),
                          ),
                        ),
                        SizedBox(height: context.heightPct(24)),

                        Text(
                          'Trip Ended',
                          style: AppTextStyles.h1(
                            context,
                          ).copyWith(fontWeight: FontWeight.w900),
                        ),
                        SizedBox(height: context.heightPct(8)),
                        Text(
                          'How was your experience with the rider?',
                          style: AppTextStyles.bodyMedium(
                            context,
                          ).copyWith(color: AppColors.textSecondary),
                        ),
                        SizedBox(height: context.heightPct(32)),

                        // Rider Box
                        Container(
                          padding: EdgeInsets.all(context.widthPct(16)),
                          decoration: BoxDecoration(
                            color: AppColors.grey50,
                            borderRadius: BorderRadius.circular(
                              context.widthPct(16),
                            ),
                          ),
                          child: Row(
                            children: [
                              CircleAvatar(
                                radius: context.widthPct(24),
                                backgroundColor: Colors.blueGrey.shade900,
                                child: Text(
                                  'E',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                  ),
                                ),
                              ),
                              SizedBox(width: context.widthPct(16)),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Elena Rodriguez',
                                    style: AppTextStyles.h3(
                                      context,
                                    ).copyWith(fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    'RIDER SINCE 2022',
                                    style: TextStyle(
                                      fontSize: 10,
                                      color: AppColors.textSecondary,
                                      fontWeight: FontWeight.bold,
                                      letterSpacing: 0.5,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: context.heightPct(32)),

                        // Rating Stars
                        RatingBar.builder(
                          initialRating: 4,
                          minRating: 1,
                          direction: Axis.horizontal,
                          allowHalfRating: true,
                          itemCount: 5,
                          itemSize: context.widthPct(40),
                          itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                          itemBuilder: (context, _) =>
                              Icon(Icons.star, color: Colors.orange),
                          onRatingUpdate: (rating) {
                            setState(() => _riderRating = rating);
                          },
                        ),
                        SizedBox(height: context.heightPct(12)),
                        Text(
                          'GREAT PERFORMANCE',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.orange,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1.0,
                          ),
                        ),
                        SizedBox(height: context.heightPct(32)),

                        // Optional Feedback
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'OPTIONAL FEEDBACK',
                            style: TextStyle(
                              fontSize: 10,
                              color: AppColors.textSecondary,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        SizedBox(height: context.heightPct(8)),
                        TextField(
                          maxLines: 3,
                          decoration: InputDecoration(
                            hintText: 'Tell us about the trip...',
                            hintStyle: TextStyle(color: AppColors.grey400),
                            filled: true,
                            fillColor: AppColors.grey50,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide.none,
                            ),
                          ),
                        ),
                        SizedBox(height: context.heightPct(16)),

                        // Tags
                        Wrap(
                          spacing: 8,
                          runSpacing: 8,
                          children: [
                            _FeedbackTag('Punctual'),
                            _FeedbackTag('Polite'),
                            _FeedbackTag('Quiet'),
                            _FeedbackTag('Good Vibes'),
                          ],
                        ),
                        SizedBox(height: context.heightPct(40)),

                        // Submit Button
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.primary,
                              padding: EdgeInsets.symmetric(
                                vertical: context.heightPct(16),
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            onPressed: () {
                              context.read<DriverTripCubit>().reset();
                            },
                            child: Text(
                              'Submit Review >',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: context.heightPct(24)),
                      ],
                    ),
                  ),
                ),
                _buildBottomNavMenu(context),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildBottomNavMenu(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 10,
            offset: Offset(0, -2),
          ),
        ],
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _NavIcon(
                icon: Icons.dashboard_outlined,
                label: 'HOME',
                onTap: () => context.go('/driver/home'),
              ),
              _NavIcon(
                icon: Icons.account_balance_wallet_outlined,
                label: 'EARNINGS',
                onTap: () => context.go('/driver/earnings'),
              ),
              _NavIcon(
                icon: Icons.rocket_launch_outlined,
                label: 'BOOSTER',
                isActive: true,
                onTap: () {},
              ),
              _NavIcon(
                icon: Icons.person_outline,
                label: 'PROFILE',
                onTap: () => context.go('/driver/profile'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _FeedbackTag extends StatelessWidget {
  final String label;
  const _FeedbackTag(this.label);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.grey200),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.bold,
          color: Colors.black87,
        ),
      ),
    );
  }
}

class _NavIcon extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isActive;
  final VoidCallback onTap;

  const _NavIcon({
    required this.icon,
    required this.label,
    this.isActive = false,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            color: isActive ? AppColors.primary : AppColors.grey400,
            size: context.widthPct(24),
          ),
          SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: context.fontPct(9),
              color: isActive ? AppColors.primary : AppColors.grey400,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
```

### lib/features/driver/driver_trip/views/widgets/driver_active_trip_sheet.dart
`$ext
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/constants/app_colors.dart';
import '../../../../../core/constants/app_text_styles.dart';
import '../../../../../core/utils/responsive.dart';
import '../../cubit/driver_trip_cubit.dart';

class DriverActiveTripSheet extends StatelessWidget {
  final bool isHeadingToPickup;

  const DriverActiveTripSheet({super.key, required this.isHeadingToPickup});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: context.heightPct(12),
      left: context.widthPct(12),
      right: context.widthPct(12),
      child: Container(
        padding: EdgeInsets.all(context.widthPct(16)),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(context.widthPct(16)),
          boxShadow: const [BoxShadow(color: Colors.black26, blurRadius: 20)],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'CURRENT DESTINATION',
                        style: TextStyle(
                          fontSize: 9,
                          color: AppColors.textSecondary,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 0.5,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Pier 39, Beach St',
                        style: AppTextStyles.h3(
                          context,
                        ).copyWith(fontWeight: FontWeight.w900, fontSize: 18),
                      ),
                      Text(
                        'San Francisco, CA 94133',
                        style: AppTextStyles.bodySmall(
                          context,
                        ).copyWith(color: AppColors.textSecondary),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: context.widthPct(10),
                    vertical: context.heightPct(6),
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.primary.withValues(alpha: 0.08),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                    children: [
                      Text(
                        'CONSTANT PRICE',
                        style: TextStyle(
                          fontSize: 8,
                          color: AppColors.primary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        '\$24.50',
                        style: AppTextStyles.h3(context).copyWith(
                          color: AppColors.primary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: context.heightPct(24)),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.location_on_outlined,
                      color: AppColors.primary,
                      size: 16,
                    ),
                    const SizedBox(width: 8),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'DISTANCE',
                          style: TextStyle(
                            fontSize: 8,
                            color: AppColors.textSecondary,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          '2.8 km',
                          style: AppTextStyles.bodyMedium(
                            context,
                          ).copyWith(fontWeight: FontWeight.bold, fontSize: 13),
                        ),
                      ],
                    ),
                  ],
                ),
                Row(
                  children: [
                    Icon(Icons.access_time, color: AppColors.primary, size: 16),
                    const SizedBox(width: 8),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'TRIP TIME',
                          style: TextStyle(
                            fontSize: 8,
                            color: AppColors.textSecondary,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          '12:04',
                          style: AppTextStyles.bodyMedium(
                            context,
                          ).copyWith(fontWeight: FontWeight.bold, fontSize: 13),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: context.heightPct(24)),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF900020),
                  padding: EdgeInsets.symmetric(
                    vertical: context.heightPct(14),
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: () {
                  if (isHeadingToPickup) {
                    context.read<DriverTripCubit>().startTrip();
                  } else {
                    context.read<DriverTripCubit>().completeTrip();
                  }
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.stop_circle_outlined,
                      color: Colors.white,
                      size: 20,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      isHeadingToPickup ? 'ARRIVED' : 'END TRIP',
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w900,
                        letterSpacing: 1.2,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
```

### lib/features/home/views/widgets/app_drawer.dart
`$ext
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../../../core/utils/responsive.dart';
import '../../../profile/cubit/profile_cubit.dart';
import '../../../profile/cubit/profile_state.dart';
import 'dart:io';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: AppColors.background,
      child: Column(
        children: [
          // â”€â”€ Red Header
          BlocBuilder<ProfileCubit, ProfileState>(
            builder: (context, state) {
              final name = state is ProfileLoaded ? state.name : 'Alex Volt';
              final imagePath = state is ProfileLoaded
                  ? state.profileImagePath
                  : null;

              return Container(
                width: double.infinity,
                padding: EdgeInsets.only(
                  top: context.heightPct(56),
                  bottom: context.heightPct(24),
                  left: context.widthPct(20),
                  right: context.widthPct(20),
                ),
                color: AppColors.primary,
                child: Row(
                  children: [
                    // Avatar
                    CircleAvatar(
                      radius: context.widthPct(28),
                      backgroundColor: AppColors.grey200,
                      backgroundImage: imagePath != null
                          ? FileImage(File(imagePath))
                          : null,
                      child: imagePath == null
                          ? Icon(
                              Icons.person,
                              size: context.widthPct(30),
                              color: AppColors.grey500,
                            )
                          : null,
                    ),
                    SizedBox(width: context.widthPct(16)),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          name,
                          style: AppTextStyles.h3(context).copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: context.heightPct(4)),
                        Row(
                          children: [
                            Icon(
                              Icons.location_on,
                              color: Colors.white70,
                              size: context.fontPct(13),
                            ),
                            SizedBox(width: context.widthPct(2)),
                            Text(
                              '4.95 Rating',
                              style: AppTextStyles.bodySmall(
                                context,
                              ).copyWith(color: Colors.white70),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              );
            },
          ),

          // â”€â”€ Menu Items
          Expanded(
            child: ListView(
              padding: EdgeInsets.symmetric(vertical: context.heightPct(8)),
              children: [
                _DrawerItem(
                  icon: Icons.credit_card_outlined,
                  iconColor: AppColors.primary,
                  title: 'Payments',
                  onTap: () => context.push('/payment'),
                ),
                _DrawerItem(
                  icon: Icons.notifications_none_outlined,
                  iconColor: AppColors.primary,
                  title: 'Notifications',
                  onTap: () => context.push('/notifications'),
                ),
                _DrawerItem(
                  icon: Icons.person_outline,
                  iconColor: AppColors.primary,
                  title: 'Account',
                  onTap: () => context.push('/profile'),
                ),
                _DrawerItem(
                  icon: Icons.history,
                  iconColor: AppColors.primary,
                  title: 'Trip History',
                  onTap: () => context.push('/trips'),
                ),
                _DrawerItem(
                  icon: Icons.settings_outlined,
                  iconColor: AppColors.primary,
                  title: 'Settings',
                  onTap: () => context.push('/settings'),
                ),
                _DrawerItem(
                  icon: Icons.help_outline,
                  iconColor: AppColors.primary,
                  title: 'Help & Support',
                  onTap: () {},
                ),

                // â”€â”€ Safety Center section
                Padding(
                  padding: EdgeInsets.only(
                    left: context.widthPct(20),
                    top: context.heightPct(20),
                    bottom: context.heightPct(8),
                  ),
                  child: Text(
                    'SAFETY CENTER',
                    style: AppTextStyles.bodySmall(context).copyWith(
                      color: AppColors.textSecondary,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.1,
                    ),
                  ),
                ),

                // Safety header tile
                Container(
                  margin: EdgeInsets.symmetric(
                    horizontal: context.widthPct(12),
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.primary.withValues(alpha: 0.07),
                    borderRadius: BorderRadius.circular(context.widthPct(10)),
                  ),
                  child: ListTile(
                    leading: Icon(
                      Icons.shield_outlined,
                      color: AppColors.primary,
                    ),
                    title: Text(
                      'Safety Services',
                      style: AppTextStyles.bodyLarge(
                        context,
                      ).copyWith(fontWeight: FontWeight.bold),
                    ),
                    onTap: () {},
                  ),
                ),

                SizedBox(height: context.heightPct(4)),

                // Sub-items
                _SubDrawerItem(
                  icon: Icons.contact_emergency_outlined,
                  title: 'Call Emergency Contacts',
                  onTap: () => context.push('/safety'),
                ),
                _SubDrawerItem(
                  icon: Icons.emergency_outlined,
                  title: 'Call 122',
                  onTap: () => context.push('/safety'),
                ),
                _SubDrawerItem(
                  icon: Icons.support_agent_outlined,
                  title: 'Safety Support',
                  onTap: () => context.push('/safety'),
                ),

                SizedBox(height: context.heightPct(16)),

                // â”€â”€ Earn with us banner
                Container(
                  margin: EdgeInsets.symmetric(
                    horizontal: context.widthPct(12),
                  ),
                  padding: EdgeInsets.all(context.widthPct(14)),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFFF3E0),
                    borderRadius: BorderRadius.circular(context.widthPct(12)),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.trending_up, color: Colors.orange.shade700),
                      SizedBox(width: context.widthPct(10)),
                      Text(
                        'Earn with us',
                        style: AppTextStyles.bodyMedium(context).copyWith(
                          color: Colors.orange.shade800,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(width: context.widthPct(8)),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: context.widthPct(8),
                          vertical: context.heightPct(2),
                        ),
                        decoration: BoxDecoration(
                          color: Colors.orange.shade700,
                          borderRadius: BorderRadius.circular(
                            context.widthPct(4),
                          ),
                        ),
                        child: Text(
                          'NEW',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: context.fontPct(10),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // â”€â”€ Footer: version + sign out
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: context.widthPct(20),
              vertical: context.heightPct(16),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Za2zo2a v2.4.0',
                  style: AppTextStyles.bodySmall(
                    context,
                  ).copyWith(color: AppColors.textSecondary),
                ),
                GestureDetector(
                  onTap: () => context.go('/login'),
                  child: Row(
                    children: [
                      Icon(
                        Icons.logout,
                        color: AppColors.primary,
                        size: context.fontPct(16),
                      ),
                      SizedBox(width: context.widthPct(4)),
                      Text(
                        ' Sign Out',
                        style: AppTextStyles.bodySmall(context).copyWith(
                          color: AppColors.primary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _DrawerItem extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String title;
  final VoidCallback onTap;

  const _DrawerItem({
    required this.icon,
    required this.iconColor,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.symmetric(horizontal: context.widthPct(20)),
      leading: Container(
        padding: EdgeInsets.all(context.widthPct(8)),
        decoration: BoxDecoration(
          color: iconColor.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(context.widthPct(8)),
        ),
        child: Icon(icon, color: iconColor, size: context.widthPct(20)),
      ),
      title: Text(
        title,
        style: AppTextStyles.bodyLarge(
          context,
        ).copyWith(fontWeight: FontWeight.w500),
      ),
      trailing: Icon(
        Icons.chevron_right,
        color: AppColors.grey400,
        size: context.widthPct(20),
      ),
      onTap: () {
        context.pop();
        onTap();
      },
    );
  }
}

class _SubDrawerItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;

  const _SubDrawerItem({
    required this.icon,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.symmetric(
        horizontal: context.widthPct(28),
        vertical: 0,
      ),
      dense: true,
      leading: Icon(
        icon,
        size: context.widthPct(20),
        color: AppColors.textSecondary,
      ),
      title: Text(
        title,
        style: AppTextStyles.bodyMedium(
          context,
        ).copyWith(color: AppColors.textPrimary),
      ),
      onTap: () {
        context.pop();
        onTap();
      },
    );
  }
}
```

### lib/features/map/data/models/map_location_model.dart
`$ext
import 'package:equatable/equatable.dart';
import 'package:latlong2/latlong.dart';

class MapLocationModel extends Equatable {
  final String id;
  final double latitude;
  final double longitude;
  final String title;
  final String? description;

  const MapLocationModel({
    required this.id,
    required this.latitude,
    required this.longitude,
    required this.title,
    this.description,
  });

  LatLng get coordinates => LatLng(latitude, longitude);

  @override
  List<Object?> get props => [id, latitude, longitude, title, description];
}
```

### lib/features/map/domain/usecases/get_user_location_use_case.dart
`$ext
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';

import '../../map_constants.dart';

class GetUserLocationUseCase {
  const GetUserLocationUseCase();

  Future<LatLng> call() async {
    final isServiceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!isServiceEnabled) {
      throw const LocationAccessException(
        MapConstants.locationServicesDisabledMessage,
      );
    }

    var permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }

    if (permission == LocationPermission.denied) {
      throw const LocationAccessException(MapConstants.permissionDeniedMessage);
    }

    if (permission == LocationPermission.deniedForever) {
      throw const LocationAccessException(
        MapConstants.permissionDeniedForeverMessage,
      );
    }

    final position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    return LatLng(position.latitude, position.longitude);
  }
}

class LocationAccessException implements Exception {
  final String message;

  const LocationAccessException(this.message);

  @override
  String toString() => message;
}
```

### lib/features/map/map_constants.dart
`$ext
import 'package:latlong2/latlong.dart';

class MapConstants {
  const MapConstants._();

  static const String googleTileUrl =
      'https://{s}.google.com/vt/lyrs=m&x={x}&y={y}&z={z}';
  static const List<String> googleTileSubdomains = ['mt0', 'mt1', 'mt2', 'mt3'];
  static const String userAgentPackageName = 'com.example.za2zo2a';

  static const String searchHint = 'Search for a place';
  static const String loadingLocation = 'Fetching your current location...';
  static const String mapUnavailableTitle = 'Map unavailable';
  static const String mapUnavailableDescription =
      'Check location services and permissions, then try again.';
  static const String retryLabel = 'Retry';
  static const String locationDetailsTitle = 'Location details';
  static const String myLocationTitle = 'Your location';
  static const String myLocationDescription =
      'This is your current location on the map.';
  static const String pinnedLocationTitle = 'Pinned location';
  static const String pinnedLocationDescription =
      'Saved from your latest map tap.';
  static const String savedMarkersLabel = 'Saved markers';
  static const String latitudeLabel = 'Latitude';
  static const String longitudeLabel = 'Longitude';
  static const String clearMarkersLabel = 'Clear markers';
  static const String noMarkersTitle = 'No saved markers yet';
  static const String noMarkersDescription =
      'Tap anywhere on the map to add a marker and preview its details.';
  static const String currentLocationChip = 'Current location';
  static const String savedMarkerChip = 'Saved marker';
  static const String centerLocationTooltip = 'Center on my location';
  static const String zoomInTooltip = 'Zoom in';
  static const String zoomOutTooltip = 'Zoom out';
  static const String clearMarkersTooltip = 'Clear all markers';
  static const String markerIdPrefix = 'map_marker';
  static const String locationServicesDisabledMessage =
      'Location services are disabled.';
  static const String permissionDeniedMessage =
      'Location permission was denied.';
  static const String permissionDeniedForeverMessage =
      'Location permission is permanently denied. Enable it from system settings.';
  static const String unexpectedLocationErrorMessage =
      'Unable to fetch your current location right now.';

  static const double initialZoom = 15;
  static const double minZoom = 3;
  static const double maxZoom = 18;
  static const double zoomStep = 1;
  static const double mobileSheetHeight = 250;
  static const LatLng fallbackCenter = LatLng(30.0444, 31.2357);
}
```

### lib/features/map/presentation/view/map_view.dart
`$ext
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/usecases/get_user_location_use_case.dart';
import '../viewmodel/map_cubit.dart';
import 'widgets/map_view_content.dart';

class MapView extends StatelessWidget {
  const MapView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          MapCubit(getUserLocationUseCase: const GetUserLocationUseCase())
            ..initMap(),
      child: const MapViewContent(),
    );
  }
}
```

### lib/features/map/presentation/view/widgets/map_canvas.dart
`$ext
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

import '../../../data/models/map_location_model.dart';
import '../../../map_constants.dart';
import '../../viewmodel/map_state.dart';
import 'map_marker_icon.dart';

class MapCanvas extends StatelessWidget {
  final MapLoaded state;
  final String? selectedMarkerId;
  final MapController mapController;
  final ValueChanged<MapLocationModel> onMarkerSelected;
  final ValueChanged<LatLng> onMapTap;
  final VoidCallback onUserLocationSelected;
  final void Function(MapPosition position, bool hasGesture) onPositionChanged;

  const MapCanvas({
    super.key,
    required this.state,
    required this.selectedMarkerId,
    required this.mapController,
    required this.onMarkerSelected,
    required this.onMapTap,
    required this.onUserLocationSelected,
    required this.onPositionChanged,
  });

  @override
  Widget build(BuildContext context) {
    return FlutterMap(
      mapController: mapController,
      options: MapOptions(
        initialCenter: state.userLocation,
        initialZoom: MapConstants.initialZoom,
        onTap: (tapPosition, point) => onMapTap(point),
        onPositionChanged: onPositionChanged,
      ),
      children: [
        TileLayer(
          urlTemplate: MapConstants.googleTileUrl,
          subdomains: MapConstants.googleTileSubdomains,
          userAgentPackageName: MapConstants.userAgentPackageName,
        ),
        MarkerLayer(
          markers: [
            Marker(
              point: state.userLocation,
              width: 56,
              height: 56,
              child: GestureDetector(
                onTap: onUserLocationSelected,
                child: const MapMarkerIcon(isUserLocation: true),
              ),
            ),
            ...state.markers.map(
              (marker) => Marker(
                point: marker.coordinates,
                width: 60,
                height: 68,
                child: GestureDetector(
                  onTap: () => onMarkerSelected(marker),
                  child: MapMarkerIcon(
                    isSelected: selectedMarkerId == marker.id,
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
```

### lib/features/map/presentation/view/widgets/map_details_panel.dart
`$ext
import 'package:flutter/material.dart';

import '../../../../../core/constants/app_colors.dart';
import '../../../data/models/map_location_model.dart';
import '../../viewmodel/map_state.dart';
import 'map_location_info_content.dart';

class MapDetailsPanel extends StatelessWidget {
  final MapLoaded state;
  final MapLocationModel? selectedMarker;
  final VoidCallback onClearMarkers;

  const MapDetailsPanel({
    super.key,
    required this.state,
    required this.selectedMarker,
    required this.onClearMarkers,
  });

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: AppColors.grey50,
      child: SafeArea(
        left: false,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: DecoratedBox(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(28),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 18,
                  offset: Offset(0, 6),
                ),
              ],
            ),
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: MapLocationInfoContent(
                state: state,
                selectedMarker: selectedMarker,
                onClearMarkers: onClearMarkers,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
```

### lib/features/map/presentation/view/widgets/map_empty_state.dart
`$ext
import 'package:flutter/material.dart';

import '../../../../../core/constants/app_colors.dart';
import '../../../map_constants.dart';

class MapEmptyState extends StatelessWidget {
  final String title;
  final String description;
  final VoidCallback onRetry;

  const MapEmptyState({
    super.key,
    required this.title,
    required this.description,
    required this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.location_off_outlined, size: 72, color: AppColors.error),
            const SizedBox(height: 20),
            Text(
              title,
              style: TextStyle(
                color: AppColors.textPrimary,
                fontSize: 24,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              description,
              textAlign: TextAlign.center,
              style: TextStyle(color: AppColors.textSecondary, height: 1.4),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: onRetry,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: Colors.white,
              ),
              child: const Text(MapConstants.retryLabel),
            ),
          ],
        ),
      ),
    );
  }
}
```

### lib/features/map/presentation/view/widgets/map_floating_actions.dart
`$ext
import 'package:flutter/material.dart';

import '../../../../../core/constants/app_colors.dart';
import '../../../map_constants.dart';

class MapFloatingActions extends StatelessWidget {
  final bool hasMarkers;
  final VoidCallback onCenterOnUserLocation;
  final VoidCallback onZoomIn;
  final VoidCallback onZoomOut;
  final VoidCallback onClearMarkers;

  const MapFloatingActions({
    super.key,
    required this.hasMarkers,
    required this.onCenterOnUserLocation,
    required this.onZoomIn,
    required this.onZoomOut,
    required this.onClearMarkers,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        if (hasMarkers)
          Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: _MapActionButton(
              icon: Icons.delete_outline,
              tooltip: MapConstants.clearMarkersTooltip,
              onTap: onClearMarkers,
              backgroundColor: Colors.white,
              iconColor: AppColors.error,
            ),
          ),
        _MapActionButton(
          icon: Icons.gps_fixed,
          tooltip: MapConstants.centerLocationTooltip,
          onTap: onCenterOnUserLocation,
          backgroundColor: AppColors.primary,
          iconColor: Colors.white,
        ),
        const SizedBox(height: 12),
        _MapActionButton(
          icon: Icons.add,
          tooltip: MapConstants.zoomInTooltip,
          onTap: onZoomIn,
          backgroundColor: Colors.white,
          iconColor: AppColors.textPrimary,
        ),
        const SizedBox(height: 8),
        _MapActionButton(
          icon: Icons.remove,
          tooltip: MapConstants.zoomOutTooltip,
          onTap: onZoomOut,
          backgroundColor: Colors.white,
          iconColor: AppColors.textPrimary,
        ),
      ],
    );
  }
}

class _MapActionButton extends StatelessWidget {
  final IconData icon;
  final String tooltip;
  final VoidCallback onTap;
  final Color backgroundColor;
  final Color iconColor;

  const _MapActionButton({
    required this.icon,
    required this.tooltip,
    required this.onTap,
    required this.backgroundColor,
    required this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: backgroundColor,
      shape: const CircleBorder(),
      elevation: 4,
      child: InkWell(
        customBorder: const CircleBorder(),
        onTap: onTap,
        child: Tooltip(
          message: tooltip,
          child: SizedBox(
            width: 48,
            height: 48,
            child: Icon(icon, color: iconColor),
          ),
        ),
      ),
    );
  }
}
```

### lib/features/map/presentation/view/widgets/map_interactive_pane.dart
`$ext
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

import '../../../data/models/map_location_model.dart';
import '../../viewmodel/map_state.dart';
import 'map_canvas.dart';
import 'map_floating_actions.dart';
import 'map_search_bar.dart';

class MapInteractivePane extends StatelessWidget {
  final MapLoaded state;
  final String? selectedMarkerId;
  final MapController mapController;
  final double bottomInset;
  final ValueChanged<MapLocationModel> onMarkerSelected;
  final ValueChanged<LatLng> onMapTap;
  final VoidCallback onUserLocationSelected;
  final VoidCallback onCenterOnUserLocation;
  final VoidCallback onZoomIn;
  final VoidCallback onZoomOut;
  final VoidCallback onClearMarkers;
  final void Function(MapPosition position, bool hasGesture) onPositionChanged;

  const MapInteractivePane({
    super.key,
    required this.state,
    required this.selectedMarkerId,
    required this.mapController,
    required this.bottomInset,
    required this.onMarkerSelected,
    required this.onMapTap,
    required this.onUserLocationSelected,
    required this.onCenterOnUserLocation,
    required this.onZoomIn,
    required this.onZoomOut,
    required this.onClearMarkers,
    required this.onPositionChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: MapCanvas(
            state: state,
            selectedMarkerId: selectedMarkerId,
            mapController: mapController,
            onMarkerSelected: onMarkerSelected,
            onMapTap: onMapTap,
            onPositionChanged: onPositionChanged,
            onUserLocationSelected: onUserLocationSelected,
          ),
        ),
        const Positioned(
          top: 0,
          left: 0,
          right: 0,
          child: SafeArea(
            bottom: false,
            child: Padding(padding: EdgeInsets.all(16), child: MapSearchBar()),
          ),
        ),
        Positioned(
          right: 16,
          bottom: bottomInset,
          child: SafeArea(
            top: false,
            left: false,
            child: MapFloatingActions(
              hasMarkers: state.markers.isNotEmpty,
              onCenterOnUserLocation: onCenterOnUserLocation,
              onZoomIn: onZoomIn,
              onZoomOut: onZoomOut,
              onClearMarkers: onClearMarkers,
            ),
          ),
        ),
      ],
    );
  }
}
```

### lib/features/map/presentation/view/widgets/map_loading_overlay.dart
`$ext
import 'package:flutter/material.dart';

import '../../../../../core/constants/app_colors.dart';

class MapLoadingOverlay extends StatelessWidget {
  final String message;

  const MapLoadingOverlay({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: Colors.black38,
      child: Center(
        child: Container(
          margin: const EdgeInsets.all(24),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircularProgressIndicator(color: AppColors.primary),
              const SizedBox(height: 16),
              Text(
                message,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: AppColors.textPrimary,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
```

### lib/features/map/presentation/view/widgets/map_location_info_content.dart
`$ext
import 'package:flutter/material.dart';

import '../../../../../core/constants/app_colors.dart';
import '../../../data/models/map_location_model.dart';
import '../../../map_constants.dart';
import '../../viewmodel/map_state.dart';

class MapLocationInfoContent extends StatelessWidget {
  final MapLoaded state;
  final MapLocationModel? selectedMarker;
  final VoidCallback onClearMarkers;

  const MapLocationInfoContent({
    super.key,
    required this.state,
    required this.selectedMarker,
    required this.onClearMarkers,
  });

  @override
  Widget build(BuildContext context) {
    final selectedCoordinates =
        selectedMarker?.coordinates ?? state.userLocation;
    final title = selectedMarker?.title ?? MapConstants.myLocationTitle;
    final description =
        selectedMarker?.description ?? MapConstants.myLocationDescription;
    final chipLabel = selectedMarker == null
        ? MapConstants.currentLocationChip
        : MapConstants.savedMarkerChip;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              MapConstants.locationDetailsTitle,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
            ),
            const Spacer(),
            if (state.markers.isNotEmpty)
              TextButton.icon(
                onPressed: onClearMarkers,
                icon: Icon(Icons.delete_outline, color: AppColors.error),
                label: Text(
                  MapConstants.clearMarkersLabel,
                  style: TextStyle(color: AppColors.error),
                ),
              ),
          ],
        ),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            color: AppColors.grey100,
            borderRadius: BorderRadius.circular(999),
          ),
          child: Text(
            chipLabel,
            style: TextStyle(
              color: AppColors.textPrimary,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        const SizedBox(height: 16),
        Text(
          title,
          style: TextStyle(
            color: AppColors.textPrimary,
            fontSize: 22,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          description,
          style: TextStyle(
            color: AppColors.textSecondary,
            fontSize: 15,
            height: 1.4,
          ),
        ),
        const SizedBox(height: 20),
        Row(
          children: [
            Expanded(
              child: _MapInfoTile(
                label: MapConstants.latitudeLabel,
                value: selectedCoordinates.latitude.toStringAsFixed(5),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _MapInfoTile(
                label: MapConstants.longitudeLabel,
                value: selectedCoordinates.longitude.toStringAsFixed(5),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        _MapInfoTile(
          label: MapConstants.savedMarkersLabel,
          value: state.markers.length.toString(),
        ),
        if (state.markers.isEmpty) ...[
          const SizedBox(height: 16),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.grey50,
              borderRadius: BorderRadius.circular(18),
              border: Border.all(color: AppColors.grey200),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  MapConstants.noMarkersTitle,
                  style: TextStyle(
                    color: AppColors.textPrimary,
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  MapConstants.noMarkersDescription,
                  style: TextStyle(color: AppColors.textSecondary, height: 1.4),
                ),
              ],
            ),
          ),
        ],
      ],
    );
  }
}

class _MapInfoTile extends StatelessWidget {
  final String label;
  final String value;

  const _MapInfoTile({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.grey50,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: AppColors.grey200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(color: AppColors.textSecondary, fontSize: 13),
          ),
          const SizedBox(height: 6),
          Text(
            value,
            style: TextStyle(
              color: AppColors.textPrimary,
              fontSize: 16,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}
```

### lib/features/map/presentation/view/widgets/map_marker_icon.dart
`$ext
import 'package:flutter/material.dart';

import '../../../../../core/constants/app_colors.dart';

class MapMarkerIcon extends StatelessWidget {
  final bool isUserLocation;
  final bool isSelected;

  const MapMarkerIcon({
    super.key,
    this.isUserLocation = false,
    this.isSelected = false,
  });

  @override
  Widget build(BuildContext context) {
    if (isUserLocation) {
      return Center(
        child: Container(
          width: 26,
          height: 26,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: AppColors.primary,
            border: Border.all(color: Colors.white, width: 4),
            boxShadow: const [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 10,
                offset: Offset(0, 4),
              ),
            ],
          ),
          child: const Icon(Icons.my_location, size: 12, color: Colors.white),
        ),
      );
    }

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 42,
          height: 42,
          decoration: BoxDecoration(
            color: isSelected ? AppColors.primary : AppColors.secondary,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: Colors.white, width: 2),
            boxShadow: const [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 10,
                offset: Offset(0, 4),
              ),
            ],
          ),
          child: const Icon(Icons.location_on, color: Colors.white),
        ),
        Container(
          width: 4,
          height: 14,
          color: isSelected ? AppColors.primary : AppColors.secondary,
        ),
      ],
    );
  }
}
```

### lib/features/map/presentation/view/widgets/map_mobile_info_sheet.dart
`$ext
import 'package:flutter/material.dart';

import '../../../../../core/constants/app_colors.dart';
import '../../../data/models/map_location_model.dart';
import '../../../map_constants.dart';
import '../../viewmodel/map_state.dart';
import 'map_location_info_content.dart';

class MapMobileInfoSheet extends StatelessWidget {
  final MapLoaded state;
  final MapLocationModel? selectedMarker;
  final VoidCallback onClearMarkers;

  const MapMobileInfoSheet({
    super.key,
    required this.state,
    required this.selectedMarker,
    required this.onClearMarkers,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MapConstants.mobileSheetHeight,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(28)),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 18,
            offset: Offset(0, -6),
          ),
        ],
      ),
      child: Column(
        children: [
          const SizedBox(height: 12),
          Container(
            width: 44,
            height: 5,
            decoration: BoxDecoration(
              color: AppColors.grey300,
              borderRadius: BorderRadius.circular(999),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 20),
              child: MapLocationInfoContent(
                state: state,
                selectedMarker: selectedMarker,
                onClearMarkers: onClearMarkers,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
```

### lib/features/map/presentation/view/widgets/map_mobile_layout.dart
`$ext
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

import '../../../data/models/map_location_model.dart';
import '../../../map_constants.dart';
import '../../viewmodel/map_state.dart';
import 'map_interactive_pane.dart';
import 'map_mobile_info_sheet.dart';

class MapMobileLayout extends StatelessWidget {
  final MapLoaded state;
  final MapLocationModel? selectedMarker;
  final MapController mapController;
  final ValueChanged<MapLocationModel> onMarkerSelected;
  final ValueChanged<LatLng> onMapTap;
  final VoidCallback onUserLocationSelected;
  final VoidCallback onCenterOnUserLocation;
  final VoidCallback onZoomIn;
  final VoidCallback onZoomOut;
  final VoidCallback onClearMarkers;
  final void Function(MapPosition position, bool hasGesture) onPositionChanged;

  const MapMobileLayout({
    super.key,
    required this.state,
    required this.selectedMarker,
    required this.mapController,
    required this.onMarkerSelected,
    required this.onMapTap,
    required this.onUserLocationSelected,
    required this.onCenterOnUserLocation,
    required this.onZoomIn,
    required this.onZoomOut,
    required this.onClearMarkers,
    required this.onPositionChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        MapInteractivePane(
          state: state,
          selectedMarkerId: selectedMarker?.id,
          mapController: mapController,
          bottomInset: MapConstants.mobileSheetHeight - 24,
          onMarkerSelected: onMarkerSelected,
          onMapTap: onMapTap,
          onPositionChanged: onPositionChanged,
          onUserLocationSelected: onUserLocationSelected,
          onCenterOnUserLocation: onCenterOnUserLocation,
          onZoomIn: onZoomIn,
          onZoomOut: onZoomOut,
          onClearMarkers: onClearMarkers,
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: MapMobileInfoSheet(
            state: state,
            selectedMarker: selectedMarker,
            onClearMarkers: onClearMarkers,
          ),
        ),
      ],
    );
  }
}
```

### lib/features/map/presentation/view/widgets/map_search_bar.dart
`$ext
import 'package:flutter/material.dart';

import '../../../../../core/constants/app_colors.dart';
import '../../../map_constants.dart';

class MapSearchBar extends StatelessWidget {
  const MapSearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 16,
            offset: Offset(0, 6),
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        child: Row(
          children: [
            const Icon(Icons.search, color: Colors.black54),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                MapConstants.searchHint,
                style: const TextStyle(
                  color: Colors.black54,
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            Icon(Icons.tune, color: AppColors.primary),
          ],
        ),
      ),
    );
  }
}
```

### lib/features/map/presentation/view/widgets/map_tablet_layout.dart
`$ext
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

import '../../../data/models/map_location_model.dart';
import '../../viewmodel/map_state.dart';
import 'map_details_panel.dart';
import 'map_interactive_pane.dart';

class MapTabletLayout extends StatelessWidget {
  final MapLoaded state;
  final MapLocationModel? selectedMarker;
  final MapController mapController;
  final ValueChanged<MapLocationModel> onMarkerSelected;
  final ValueChanged<LatLng> onMapTap;
  final VoidCallback onUserLocationSelected;
  final VoidCallback onCenterOnUserLocation;
  final VoidCallback onZoomIn;
  final VoidCallback onZoomOut;
  final VoidCallback onClearMarkers;
  final void Function(MapPosition position, bool hasGesture) onPositionChanged;

  const MapTabletLayout({
    super.key,
    required this.state,
    required this.selectedMarker,
    required this.mapController,
    required this.onMarkerSelected,
    required this.onMapTap,
    required this.onUserLocationSelected,
    required this.onCenterOnUserLocation,
    required this.onZoomIn,
    required this.onZoomOut,
    required this.onClearMarkers,
    required this.onPositionChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 2,
          child: MapInteractivePane(
            state: state,
            selectedMarkerId: selectedMarker?.id,
            mapController: mapController,
            bottomInset: 16,
            onMarkerSelected: onMarkerSelected,
            onMapTap: onMapTap,
            onPositionChanged: onPositionChanged,
            onUserLocationSelected: onUserLocationSelected,
            onCenterOnUserLocation: onCenterOnUserLocation,
            onZoomIn: onZoomIn,
            onZoomOut: onZoomOut,
            onClearMarkers: onClearMarkers,
          ),
        ),
        Expanded(
          flex: 1,
          child: MapDetailsPanel(
            state: state,
            selectedMarker: selectedMarker,
            onClearMarkers: onClearMarkers,
          ),
        ),
      ],
    );
  }
}
```

### lib/features/map/presentation/view/widgets/map_view_content.dart
`$ext
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

import '../../../../../core/constants/app_colors.dart';
import '../../../../../core/utils/responsive.dart';
import '../../../data/models/map_location_model.dart';
import '../../../map_constants.dart';
import '../../viewmodel/map_cubit.dart';
import '../../viewmodel/map_state.dart';
import 'map_empty_state.dart';
import 'map_loading_overlay.dart';
import 'map_mobile_layout.dart';
import 'map_tablet_layout.dart';

class MapViewContent extends StatefulWidget {
  const MapViewContent({super.key});

  @override
  State<MapViewContent> createState() => _MapViewContentState();
}

class _MapViewContentState extends State<MapViewContent> {
  late final MapController _mapController;
  StreamSubscription<LatLng>? _cameraMoveSubscription;
  LatLng _currentCenter = MapConstants.fallbackCenter;
  double _currentZoom = MapConstants.initialZoom;
  String? _selectedMarkerId;

  @override
  void initState() {
    super.initState();
    _mapController = MapController();

    _cameraMoveSubscription = context.read<MapCubit>().cameraMoveStream.listen((
      target,
    ) {
      if (!mounted) {
        return;
      }

      _currentCenter = target;
      _mapController.move(target, _currentZoom);
    });
  }

  @override
  void dispose() {
    _cameraMoveSubscription?.cancel();
    super.dispose();
  }

  void _handleMapTap(LatLng point) {
    final marker = MapLocationModel(
      id: '${MapConstants.markerIdPrefix}_${DateTime.now().microsecondsSinceEpoch}',
      latitude: point.latitude,
      longitude: point.longitude,
      title: MapConstants.pinnedLocationTitle,
      description: MapConstants.pinnedLocationDescription,
    );

    setState(() {
      _selectedMarkerId = marker.id;
    });

    context.read<MapCubit>().addMarker(marker);
  }

  void _handleUserLocationSelected(MapLoaded state) {
    setState(() {
      _selectedMarkerId = null;
    });

    context.read<MapCubit>().moveToLocation(state.userLocation);
  }

  void _handleMarkerSelected(MapLocationModel marker) {
    setState(() {
      _selectedMarkerId = marker.id;
    });

    context.read<MapCubit>().moveToLocation(marker.coordinates);
  }

  void _handlePositionChanged(MapPosition position, bool hasGesture) {
    _currentCenter = position.center ?? _currentCenter;
    _currentZoom = position.zoom ?? _currentZoom;
  }

  void _handleZoom(double delta) {
    final nextZoom = (_currentZoom + delta).clamp(
      MapConstants.minZoom,
      MapConstants.maxZoom,
    );

    _currentZoom = nextZoom;
    _mapController.move(_currentCenter, nextZoom);
  }

  MapLocationModel? _resolveSelectedMarker(MapLoaded state) {
    if (_selectedMarkerId == null) {
      return null;
    }

    try {
      return state.markers.firstWhere(
        (marker) => marker.id == _selectedMarkerId,
      );
    } catch (_) {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MapCubit, MapState>(
      listener: (context, state) {
        if (state is MapLoaded) {
          _currentCenter = state.userLocation;

          if (_resolveSelectedMarker(state) == null &&
              _selectedMarkerId != null &&
              mounted) {
            setState(() {
              _selectedMarkerId = null;
            });
          }
        }

        if (state is MapError) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: AppColors.error,
              ),
            );
        }
      },
      builder: (context, state) {
        final cachedState = context.read<MapCubit>().lastLoadedState;
        final mapState = state is MapLoaded ? state : cachedState;

        if (state is MapError && mapState == null) {
          return Scaffold(
            body: SafeArea(
              child: MapEmptyState(
                title: MapConstants.mapUnavailableTitle,
                description: state.message,
                onRetry: context.read<MapCubit>().initMap,
              ),
            ),
          );
        }

        return Scaffold(
          body: LayoutBuilder(
            builder: (context, constraints) {
              if (mapState == null) {
                return Stack(
                  fit: StackFit.expand,
                  children: [
                    ColoredBox(color: AppColors.grey100),
                    if (state is MapLoading)
                      const MapLoadingOverlay(
                        message: MapConstants.loadingLocation,
                      ),
                  ],
                );
              }

              final selectedMarker = _resolveSelectedMarker(mapState);
              final content = context.isMobile
                  ? MapMobileLayout(
                      state: mapState,
                      selectedMarker: selectedMarker,
                      mapController: _mapController,
                      onMapTap: _handleMapTap,
                      onPositionChanged: _handlePositionChanged,
                      onUserLocationSelected: () =>
                          _handleUserLocationSelected(mapState),
                      onMarkerSelected: _handleMarkerSelected,
                      onCenterOnUserLocation: () => context
                          .read<MapCubit>()
                          .moveToLocation(mapState.userLocation),
                      onZoomIn: () => _handleZoom(MapConstants.zoomStep),
                      onZoomOut: () => _handleZoom(-MapConstants.zoomStep),
                      onClearMarkers: () {
                        setState(() {
                          _selectedMarkerId = null;
                        });
                        context.read<MapCubit>().clearMarkers();
                      },
                    )
                  : MapTabletLayout(
                      state: mapState,
                      selectedMarker: selectedMarker,
                      mapController: _mapController,
                      onMapTap: _handleMapTap,
                      onPositionChanged: _handlePositionChanged,
                      onUserLocationSelected: () =>
                          _handleUserLocationSelected(mapState),
                      onMarkerSelected: _handleMarkerSelected,
                      onCenterOnUserLocation: () => context
                          .read<MapCubit>()
                          .moveToLocation(mapState.userLocation),
                      onZoomIn: () => _handleZoom(MapConstants.zoomStep),
                      onZoomOut: () => _handleZoom(-MapConstants.zoomStep),
                      onClearMarkers: () {
                        setState(() {
                          _selectedMarkerId = null;
                        });
                        context.read<MapCubit>().clearMarkers();
                      },
                    );

              return Stack(
                fit: StackFit.expand,
                children: [
                  content,
                  if (state is MapLoading)
                    const MapLoadingOverlay(
                      message: MapConstants.loadingLocation,
                    ),
                ],
              );
            },
          ),
        );
      },
    );
  }
}
```

### lib/features/map/presentation/viewmodel/map_cubit.dart
`$ext
import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:latlong2/latlong.dart';

import '../../data/models/map_location_model.dart';
import '../../domain/usecases/get_user_location_use_case.dart';
import '../../map_constants.dart';
import 'map_state.dart';

class MapCubit extends Cubit<MapState> {
  final GetUserLocationUseCase _getUserLocationUseCase;
  final StreamController<LatLng> _cameraMoveController =
      StreamController<LatLng>.broadcast();

  MapLoaded? _lastLoadedState;

  MapCubit({required GetUserLocationUseCase getUserLocationUseCase})
    : _getUserLocationUseCase = getUserLocationUseCase,
      super(const MapInitial());

  Stream<LatLng> get cameraMoveStream => _cameraMoveController.stream;
  MapLoaded? get lastLoadedState => _lastLoadedState;

  Future<void> initMap() async {
    emit(const MapLoading());

    try {
      final userLocation = await _getUserLocationUseCase();
      final loadedState = MapLoaded(
        userLocation: userLocation,
        markers: const [],
      );

      _lastLoadedState = loadedState;
      emit(loadedState);
    } catch (error) {
      emit(MapError(_resolveErrorMessage(error)));
    }
  }

  void moveToLocation(LatLng target) {
    _cameraMoveController.add(target);
  }

  void addMarker(MapLocationModel marker) {
    final currentState = _lastLoadedState;
    if (currentState == null) {
      return;
    }

    final updatedMarkers = List<MapLocationModel>.from(currentState.markers);
    final markerIndex = updatedMarkers.indexWhere(
      (existingMarker) => existingMarker.id == marker.id,
    );

    if (markerIndex == -1) {
      updatedMarkers.add(marker);
    } else {
      updatedMarkers[markerIndex] = marker;
    }

    final updatedState = currentState.copyWith(markers: updatedMarkers);
    _lastLoadedState = updatedState;
    emit(updatedState);
    moveToLocation(marker.coordinates);
  }

  void clearMarkers() {
    final currentState = _lastLoadedState;
    if (currentState == null) {
      return;
    }

    final updatedState = currentState.copyWith(markers: const []);
    _lastLoadedState = updatedState;
    emit(updatedState);
    moveToLocation(updatedState.userLocation);
  }

  String _resolveErrorMessage(Object error) {
    if (error is LocationAccessException) {
      return error.message;
    }

    return MapConstants.unexpectedLocationErrorMessage;
  }

  @override
  Future<void> close() async {
    await _cameraMoveController.close();
    return super.close();
  }
}
```

### lib/features/map/presentation/viewmodel/map_state.dart
`$ext
import 'package:equatable/equatable.dart';
import 'package:latlong2/latlong.dart';

import '../../data/models/map_location_model.dart';

sealed class MapState extends Equatable {
  const MapState();

  @override
  List<Object?> get props => [];
}

final class MapInitial extends MapState {
  const MapInitial();
}

final class MapLoading extends MapState {
  const MapLoading();
}

final class MapLoaded extends MapState {
  final LatLng userLocation;
  final List<MapLocationModel> markers;

  const MapLoaded({required this.userLocation, required this.markers});

  MapLoaded copyWith({LatLng? userLocation, List<MapLocationModel>? markers}) {
    return MapLoaded(
      userLocation: userLocation ?? this.userLocation,
      markers: markers ?? this.markers,
    );
  }

  @override
  List<Object?> get props => [userLocation, markers];
}

final class MapError extends MapState {
  final String message;

  const MapError(this.message);

  @override
  List<Object?> get props => [message];
}
```

### lib/features/map/view/map_screen.dart
`$ext
import 'package:flutter/material.dart';

import '../presentation/view/map_view.dart';

@Deprecated('Use MapView from presentation/view/map_view.dart instead.')
class MapScreen extends StatelessWidget {
  const MapScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const MapView();
  }
}
```

### lib/features/map/view_model/map_cubit.dart
`$ext
export '../presentation/viewmodel/map_cubit.dart';
```

### lib/features/map/view_model/map_state.dart
`$ext
export '../presentation/viewmodel/map_state.dart';
```

### lib/features/payment/views/payment_view.dart
`$ext
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../../../core/utils/responsive.dart';
import '../cubit/payment_cubit.dart';
import '../cubit/payment_state.dart';

class PaymentView extends StatelessWidget {
  const PaymentView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.grey50,
      body: BlocBuilder<PaymentCubit, PaymentState>(
        builder: (context, state) {
          return SafeArea(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // â”€â”€ Top bar
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: context.widthPct(20),
                      vertical: context.heightPct(16),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.menu,
                          color: AppColors.primary,
                          size: context.widthPct(26),
                        ),
                        SizedBox(width: context.widthPct(8)),
                        Text(
                          'Crimson Velocity',
                          style: AppTextStyles.h2(context).copyWith(
                            color: AppColors.primary,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const Spacer(),
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: context.widthPct(12),
                            vertical: context.heightPct(5),
                          ),
                          decoration: BoxDecoration(
                            color: const Color(0xFFFF8F00),
                            borderRadius: BorderRadius.circular(
                              context.widthPct(20),
                            ),
                          ),
                          child: Text(
                            'PREMIUM',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: context.fontPct(10),
                              letterSpacing: 1.1,
                            ),
                          ),
                        ),
                        SizedBox(width: context.widthPct(10)),
                        CircleAvatar(
                          radius: context.widthPct(20),
                          backgroundColor: AppColors.grey200,
                          child: Icon(
                            Icons.person,
                            color: AppColors.grey500,
                            size: context.widthPct(20),
                          ),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: context.heightPct(4)),

                  // â”€â”€ Balance card
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: context.widthPct(16),
                    ),
                    child: Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(context.widthPct(24)),
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [Color(0xFFE23030), Color(0xFFFF6B6B)],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(
                          context.widthPct(16),
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'AVAILABLE BALANCE',
                            style: TextStyle(
                              color: Colors.white.withValues(alpha: 0.8),
                              fontSize: context.fontPct(11),
                              fontWeight: FontWeight.bold,
                              letterSpacing: 1.2,
                            ),
                          ),
                          SizedBox(height: context.heightPct(8)),
                          Text(
                            r'$142.50',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: context.fontPct(36),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: context.heightPct(20)),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                              foregroundColor: AppColors.primary,
                              padding: EdgeInsets.symmetric(
                                horizontal: context.widthPct(32),
                                vertical: context.heightPct(12),
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                  context.widthPct(50),
                                ),
                              ),
                              elevation: 0,
                            ),
                            onPressed: () {},
                            child: Text(
                              'Top Up',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: context.fontPct(14),
                                color: AppColors.primary,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  SizedBox(height: context.heightPct(20)),

                  // â”€â”€ Primary Method
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: context.widthPct(16),
                    ),
                    child: Container(
                      padding: EdgeInsets.all(context.widthPct(16)),
                      decoration: BoxDecoration(
                        color: AppColors.background,
                        borderRadius: BorderRadius.circular(
                          context.widthPct(12),
                        ),
                        boxShadow: const [
                          BoxShadow(
                            color: Color(0x0A000000),
                            blurRadius: 6,
                            offset: Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'PRIMARY METHOD',
                            style: AppTextStyles.bodySmall(context).copyWith(
                              color: AppColors.textSecondary,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 1.1,
                            ),
                          ),
                          SizedBox(height: context.heightPct(12)),
                          Row(
                            children: [
                              // Card icon
                              Container(
                                padding: EdgeInsets.all(context.widthPct(10)),
                                decoration: BoxDecoration(
                                  color: AppColors.grey50,
                                  borderRadius: BorderRadius.circular(
                                    context.widthPct(8),
                                  ),
                                ),
                                child: Icon(
                                  Icons.credit_card,
                                  color: AppColors.primary,
                                  size: context.widthPct(24),
                                ),
                              ),
                              SizedBox(width: context.widthPct(14)),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Visa â€¢â€¢â€¢â€¢ 4421',
                                      style: AppTextStyles.bodyLarge(
                                        context,
                                      ).copyWith(fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      'EXPIRY   09/27',
                                      style: AppTextStyles.bodySmall(context)
                                          .copyWith(
                                            color: AppColors.textSecondary,
                                          ),
                                    ),
                                  ],
                                ),
                              ),
                              GestureDetector(
                                onTap: () {},
                                child: Text(
                                  'Edit Card',
                                  style: AppTextStyles.bodySmall(context)
                                      .copyWith(
                                        color: AppColors.primary,
                                        fontWeight: FontWeight.bold,
                                      ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),

                  SizedBox(height: context.heightPct(12)),

                  // â”€â”€ Add Payment Method
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: context.widthPct(16),
                    ),
                    child: GestureDetector(
                      onTap: () {
                        context.read<PaymentCubit>().addCard('Visa **** 9999');
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: const Text('Card added (Demo)'),
                            backgroundColor: AppColors.success,
                          ),
                        );
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: context.widthPct(16),
                          vertical: context.heightPct(16),
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.background,
                          borderRadius: BorderRadius.circular(
                            context.widthPct(12),
                          ),
                          border: Border.all(
                            color: AppColors.grey200,
                            style: BorderStyle.solid,
                            width: 1.5,
                          ),
                        ),
                        child: Row(
                          children: [
                            Icon(
                              Icons.add,
                              color: AppColors.primary,
                              size: context.widthPct(20),
                            ),
                            SizedBox(width: context.widthPct(12)),
                            Text(
                              'Add Payment Method',
                              style: AppTextStyles.bodyLarge(context).copyWith(
                                color: AppColors.primary,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const Spacer(),
                            Icon(Icons.chevron_right, color: AppColors.grey400),
                          ],
                        ),
                      ),
                    ),
                  ),

                  SizedBox(height: context.heightPct(28)),

                  // â”€â”€ Recent Transactions header
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: context.widthPct(16),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Recent Transactions',
                          style: AppTextStyles.h3(
                            context,
                          ).copyWith(fontWeight: FontWeight.bold),
                        ),
                        GestureDetector(
                          onTap: () => context.push('/trips'),
                          child: Text(
                            'VIEW ALL',
                            style: AppTextStyles.bodySmall(context).copyWith(
                              color: AppColors.primary,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: context.heightPct(12)),

                  // â”€â”€ Transaction Cards
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: context.widthPct(16),
                    ),
                    child: Column(
                      children: const [
                        _TransactionCard(
                          icon: Icons.flight_takeoff,
                          iconBg: Color(0xFFFFEBEE),
                          iconColor: Color(0xFFE23030),
                          title: 'Airport Transfer',
                          date: 'Oct 24, 2023 â€¢ 10:45 AM',
                          amount: r'$32.00',
                        ),
                        _TransactionCard(
                          icon: Icons.bolt,
                          iconBg: Color(0xFFFFF3E0),
                          iconColor: Color(0xFFFF8F00),
                          title: 'Rush Hour Priority',
                          date: 'Oct 22, 2023 â€¢ 06:12 PM',
                          amount: r'$18.50',
                        ),
                        _TransactionCard(
                          icon: Icons.directions_car,
                          iconBg: Color(0xFFFFEBEE),
                          iconColor: Color(0xFFE23030),
                          title: 'City Centre Hop',
                          date: 'Oct 20, 2023 â€¢ 02:30 PM',
                          amount: r'$12.20',
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class _TransactionCard extends StatelessWidget {
  final IconData icon;
  final Color iconBg;
  final Color iconColor;
  final String title;
  final String date;
  final String amount;

  const _TransactionCard({
    required this.icon,
    required this.iconBg,
    required this.iconColor,
    required this.title,
    required this.date,
    required this.amount,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: context.heightPct(10)),
      padding: EdgeInsets.all(context.widthPct(16)),
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.circular(context.widthPct(12)),
        boxShadow: const [
          BoxShadow(
            color: Color(0x0A000000),
            blurRadius: 6,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(context.widthPct(10)),
            decoration: BoxDecoration(color: iconBg, shape: BoxShape.circle),
            child: Icon(icon, color: iconColor, size: context.widthPct(22)),
          ),
          SizedBox(width: context.widthPct(14)),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: AppTextStyles.bodyLarge(
                    context,
                  ).copyWith(fontWeight: FontWeight.bold),
                ),
                SizedBox(height: context.heightPct(2)),
                Text(
                  date,
                  style: AppTextStyles.bodySmall(
                    context,
                  ).copyWith(color: AppColors.textSecondary),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                amount,
                style: AppTextStyles.bodyLarge(
                  context,
                ).copyWith(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: context.heightPct(4)),
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: context.widthPct(6),
                  vertical: context.heightPct(2),
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFFE8F5E9),
                  borderRadius: BorderRadius.circular(context.widthPct(4)),
                ),
                child: Text(
                  'COMPLETED',
                  style: TextStyle(
                    color: const Color(0xFF388E3C),
                    fontSize: context.fontPct(9),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
```

### lib/features/profile/views/profile_view.dart
`$ext
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../../../core/utils/responsive.dart';
import '../cubit/profile_cubit.dart';
import '../cubit/profile_state.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();

  Future<void> _pickImage(BuildContext context) async {
    final picker = ImagePicker();
    final image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null && context.mounted) {
      context.read<ProfileCubit>().updateProfilePicture(image.path);
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.grey50,
      appBar: AppBar(
        backgroundColor: AppColors.grey50,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: AppColors.textPrimary),
          onPressed: () => context.pop(),
        ),
        title: Text('Rider Profile', style: AppTextStyles.h2(context)),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.edit, color: AppColors.primary),
            onPressed: () {
              // Push into edit mode
            },
          ),
        ],
      ),
      body: BlocConsumer<ProfileCubit, ProfileState>(
        listener: (context, state) {},
        builder: (context, state) {
          final name = state is ProfileLoaded ? state.name : 'Alex Rivera';
          final email = state is ProfileLoaded
              ? state.email
              : 'alex.rivera@voltride.com';
          final phone = state is ProfileLoaded
              ? state.phone
              : '+1 (555) 123-4567';
          final imagePath = state is ProfileLoaded
              ? state.profileImagePath
              : null;

          if (state is ProfileLoaded) {
            _nameController.text = name;
            _emailController.text = email;
            _phoneController.text = phone;
          }

          return SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // â”€â”€â”€â”€â”€ PROFILE HEADER SECTION â”€â”€â”€â”€â”€
                Container(
                  color: AppColors.background,
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(
                    vertical: context.heightPct(28),
                    horizontal: context.widthPct(24),
                  ),
                  child: Column(
                    children: [
                      // Avatar with PRO badge + camera
                      GestureDetector(
                        onTap: () => _pickImage(context),
                        child: Stack(
                          clipBehavior: Clip.none,
                          alignment: Alignment.bottomCenter,
                          children: [
                            // Outer red ring
                            Container(
                              padding: const EdgeInsets.all(3),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: AppColors.primary,
                                  width: 3,
                                ),
                              ),
                              child: CircleAvatar(
                                radius: context.widthPct(46),
                                backgroundColor: AppColors.grey200,
                                backgroundImage: imagePath != null
                                    ? FileImage(File(imagePath))
                                    : null,
                                child: imagePath == null
                                    ? Icon(
                                        Icons.person,
                                        size: context.widthPct(46),
                                        color: AppColors.grey500,
                                      )
                                    : null,
                              ),
                            ),
                            // PRO badge
                            Positioned(
                              bottom: -context.heightPct(2),
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: context.widthPct(10),
                                  vertical: context.heightPct(4),
                                ),
                                decoration: BoxDecoration(
                                  color: AppColors.primary,
                                  borderRadius: BorderRadius.circular(
                                    context.widthPct(20),
                                  ),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      'PRO',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: context.fontPct(10),
                                        fontWeight: FontWeight.bold,
                                        letterSpacing: 0.8,
                                      ),
                                    ),
                                    SizedBox(width: context.widthPct(4)),
                                    Icon(
                                      Icons.verified,
                                      color: Colors.white,
                                      size: context.fontPct(10),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: context.heightPct(20)),

                      // Name
                      Text(
                        name,
                        style: AppTextStyles.h2(
                          context,
                        ).copyWith(fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: context.heightPct(6)),

                      // Star Rating
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.star,
                            color: AppColors.warning,
                            size: context.fontPct(16),
                          ),
                          SizedBox(width: context.widthPct(4)),
                          Text(
                            '4.9',
                            style: AppTextStyles.bodyMedium(context).copyWith(
                              color: AppColors.warning,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            ' (128 reviews)',
                            style: AppTextStyles.bodySmall(
                              context,
                            ).copyWith(color: AppColors.textSecondary),
                          ),
                        ],
                      ),
                      SizedBox(height: context.heightPct(4)),

                      // Member since
                      Text(
                        'Member since March 2022',
                        style: AppTextStyles.bodySmall(
                          context,
                        ).copyWith(color: AppColors.textSecondary),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: context.heightPct(16)),

                // â”€â”€â”€â”€â”€ STATS ROW â”€â”€â”€â”€â”€
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: context.widthPct(20),
                  ),
                  child: Row(
                    children: [
                      // Total Trips
                      Expanded(
                        child: _StatCard(
                          icon: Icons.directions_car,
                          label: 'TOTAL TRIPS',
                          value: '142',
                          unit: '',
                        ),
                      ),
                      SizedBox(width: context.widthPct(16)),
                      // Distance
                      Expanded(
                        child: _StatCard(
                          icon: Icons.route,
                          label: 'DISTANCE',
                          value: '850',
                          unit: 'km',
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: context.heightPct(28)),

                // â”€â”€â”€â”€â”€ PERSONAL INFORMATION â”€â”€â”€â”€â”€
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: context.widthPct(20),
                  ),
                  child: Text(
                    'PERSONAL INFORMATION',
                    style: AppTextStyles.bodySmall(context).copyWith(
                      color: AppColors.primary,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.2,
                    ),
                  ),
                ),
                SizedBox(height: context.heightPct(12)),

                // Info Cards
                Container(
                  margin: EdgeInsets.symmetric(
                    horizontal: context.widthPct(20),
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.background,
                    borderRadius: BorderRadius.circular(context.widthPct(12)),
                  ),
                  child: Column(
                    children: [
                      _InfoRow(
                        icon: Icons.person_outline,
                        label: 'Full Name',
                        value: name,
                        showDivider: true,
                        showCheck: false,
                        onTap: () {},
                      ),
                      _InfoRow(
                        icon: Icons.mail_outline,
                        label: 'Email Address',
                        value: email,
                        showDivider: true,
                        showCheck: true,
                        onTap: () {},
                      ),
                      _InfoRow(
                        icon: Icons.phone_outlined,
                        label: 'Phone Number',
                        value: phone,
                        showDivider: false,
                        showCheck: true,
                        onTap: () {},
                      ),
                    ],
                  ),
                ),

                SizedBox(height: context.heightPct(16)),

                // â”€â”€â”€â”€â”€ PAYMENT METHODS â”€â”€â”€â”€â”€
                GestureDetector(
                  onTap: () => context.push('/home/payment'),
                  child: Container(
                    margin: EdgeInsets.symmetric(
                      horizontal: context.widthPct(20),
                    ),
                    padding: EdgeInsets.all(context.widthPct(20)),
                    decoration: BoxDecoration(
                      color: AppColors.primary.withValues(alpha: 0.08),
                      borderRadius: BorderRadius.circular(context.widthPct(16)),
                    ),
                    child: Row(
                      children: [
                        Container(
                          padding: EdgeInsets.all(context.widthPct(12)),
                          decoration: BoxDecoration(
                            color: AppColors.primary,
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            Icons.credit_card,
                            color: Colors.white,
                            size: context.widthPct(22),
                          ),
                        ),
                        SizedBox(width: context.widthPct(16)),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Payment Methods',
                                style: AppTextStyles.bodyLarge(
                                  context,
                                ).copyWith(fontWeight: FontWeight.bold),
                              ),
                              Text(
                                'Default: Visa ending in 4242',
                                style: AppTextStyles.bodySmall(
                                  context,
                                ).copyWith(color: AppColors.textSecondary),
                              ),
                            ],
                          ),
                        ),
                        Icon(
                          Icons.chevron_right,
                          color: AppColors.textSecondary,
                        ),
                      ],
                    ),
                  ),
                ),

                SizedBox(height: context.heightPct(40)),
              ],
            ),
          );
        },
      ),
    );
  }
}

// â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€
// Stat Card Widget
// â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€
class _StatCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final String unit;

  const _StatCard({
    required this.icon,
    required this.label,
    required this.value,
    required this.unit,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(context.widthPct(16)),
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.circular(context.widthPct(12)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.all(context.widthPct(10)),
            decoration: BoxDecoration(
              color: AppColors.primary.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(context.widthPct(8)),
            ),
            child: Icon(
              icon,
              color: AppColors.primary,
              size: context.widthPct(22),
            ),
          ),
          SizedBox(height: context.heightPct(12)),
          Text(
            label,
            style: AppTextStyles.bodySmall(context).copyWith(
              color: AppColors.textSecondary,
              letterSpacing: 0.8,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: context.heightPct(4)),
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: value,
                  style: AppTextStyles.h2(
                    context,
                  ).copyWith(fontWeight: FontWeight.bold),
                ),
                if (unit.isNotEmpty)
                  TextSpan(
                    text: ' $unit',
                    style: AppTextStyles.bodyMedium(context).copyWith(
                      color: AppColors.textSecondary,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€
// Info Row Widget
// â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€
class _InfoRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final bool showDivider;
  final bool showCheck;
  final VoidCallback onTap;

  const _InfoRow({
    required this.icon,
    required this.label,
    required this.value,
    required this.showDivider,
    required this.showCheck,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(context.widthPct(12)),
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: context.widthPct(16),
              vertical: context.heightPct(16),
            ),
            child: Row(
              children: [
                Icon(
                  icon,
                  color: AppColors.grey400,
                  size: context.widthPct(20),
                ),
                SizedBox(width: context.widthPct(16)),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        label,
                        style: AppTextStyles.bodySmall(context).copyWith(
                          color: AppColors.textSecondary,
                          fontSize: context.fontPct(11),
                        ),
                      ),
                      SizedBox(height: context.heightPct(2)),
                      Text(
                        value,
                        style: AppTextStyles.bodyLarge(context).copyWith(
                          color: AppColors.textPrimary,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
                if (showCheck)
                  Container(
                    padding: EdgeInsets.all(context.widthPct(4)),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: AppColors.primary, width: 1.5),
                    ),
                    child: Icon(
                      Icons.check,
                      color: AppColors.primary,
                      size: context.fontPct(12),
                    ),
                  ),
              ],
            ),
          ),
        ),
        if (showDivider)
          Divider(
            height: 1,
            color: AppColors.grey100,
            indent: context.widthPct(52),
          ),
      ],
    );
  }
}
```

### lib/features/profile/views/settings_view.dart
`$ext
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/theme/theme_cubit.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../../../core/utils/responsive.dart';

class SettingsView extends StatefulWidget {
  const SettingsView({super.key});

  @override
  State<SettingsView> createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: AppColors.textPrimary),
          onPressed: () => context.pop(),
        ),
        title: Text(
          'Settings',
          style: AppTextStyles.h3(
            context,
          ).copyWith(fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: context.heightPct(20)),
            // â”€â”€ Profile Section
            Center(
              child: Stack(
                children: [
                  Container(
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: AppColors.primary, width: 2),
                    ),
                    child: CircleAvatar(
                      radius: context.widthPct(50),
                      backgroundImage: const NetworkImage(
                        'https://i.pravatar.cc/150?u=alexvolt',
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: AppColors.primary,
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 2),
                      ),
                      child: Icon(
                        Icons.edit,
                        color: Colors.white,
                        size: context.widthPct(16),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: context.heightPct(16)),
            Text(
              'Alex Volt',
              style: AppTextStyles.h2(
                context,
              ).copyWith(fontWeight: FontWeight.bold),
            ),
            Text('alex@za2zo2a.com', style: AppTextStyles.bodySmall(context)),
            Text('+1 (555) 012-3456', style: AppTextStyles.bodySmall(context)),
            SizedBox(height: context.heightPct(30)),

            // â”€â”€ Preferences Section
            _buildSectionHeader(context, 'PREFERENCES'),
            BlocBuilder<ThemeCubit, ThemeMode>(
              builder: (context, themeMode) {
                return _SettingsTile(
                  icon: Icons.dark_mode_outlined,
                  iconColor: AppColors.primary,
                  iconBg: const Color(0xFFFFEBEB),
                  title: 'Dark Mode',
                  trailing: Switch.adaptive(
                    value: themeMode == ThemeMode.dark,
                    activeThumbColor: AppColors.primary,
                    activeTrackColor: AppColors.primary.withValues(alpha: 0.4),
                    onChanged: (val) {
                      context.read<ThemeCubit>().toggleTheme();
                    },
                  ),
                );
              },
            ),
            _SettingsTile(
              icon: Icons.translate,
              iconColor: Colors.orange,
              iconBg: const Color(0xFFFFF4E5),
              title: 'Language',
              subtitle: 'English (US)',
              onTap: () {},
            ),

            // â”€â”€ Saved Locations
            _buildSectionHeader(context, 'SAVED LOCATIONS'),
            _SettingsTile(
              icon: Icons.home_outlined,
              iconColor: Colors.blueGrey,
              iconBg: AppColors.grey100,
              title: 'Add Home',
              trailing: Icon(
                Icons.add_circle_outline,
                color: AppColors.grey400,
              ),
              onTap: () {},
            ),
            _SettingsTile(
              icon: Icons.work_outline,
              iconColor: Colors.blueGrey,
              iconBg: AppColors.grey100,
              title: 'Add Work',
              trailing: Icon(
                Icons.add_circle_outline,
                color: AppColors.grey400,
              ),
              onTap: () {},
            ),

            // â”€â”€ Security & Legal
            _buildSectionHeader(context, 'SECURITY & LEGAL'),
            _SettingsTile(
              icon: Icons.shield_outlined,
              iconColor: AppColors.primary,
              iconBg: const Color(0xFFFFEBEB),
              title: 'Privacy Settings',
              onTap: () {},
            ),
            _SettingsTile(
              icon: Icons.description_outlined,
              iconColor: Colors.blueGrey,
              iconBg: AppColors.grey100,
              title: 'Terms of Service',
              trailing: Icon(
                Icons.open_in_new,
                color: AppColors.grey400,
                size: 18,
              ),
              onTap: () {},
            ),

            SizedBox(height: context.heightPct(32)),
            // â”€â”€ Sign Out Button
            Padding(
              padding: EdgeInsets.symmetric(horizontal: context.widthPct(24)),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFF3F4F6),
                    elevation: 0,
                    padding: EdgeInsets.symmetric(
                      vertical: context.heightPct(14),
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(context.widthPct(12)),
                    ),
                  ),
                  onPressed: () => context.go('/login'),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.logout, color: AppColors.primary, size: 20),
                      SizedBox(width: context.widthPct(8)),
                      Text(
                        'Sign Out',
                        style: AppTextStyles.bodyLarge(context).copyWith(
                          color: AppColors.primary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: context.heightPct(24)),
            Text(
              'ZA2ZO2A VERSION 4.2.0 (BUILD 882)',
              style: AppTextStyles.caption(
                context,
              ).copyWith(color: AppColors.grey400, letterSpacing: 1.1),
            ),
            SizedBox(height: context.heightPct(32)),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(BuildContext context, String title) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.only(
        left: context.widthPct(24),
        top: context.heightPct(20),
        bottom: context.heightPct(12),
      ),
      child: Text(
        title,
        style: AppTextStyles.caption(context).copyWith(
          color: AppColors.primary,
          fontWeight: FontWeight.bold,
          letterSpacing: 1.2,
        ),
      ),
    );
  }
}

class _SettingsTile extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final Color iconBg;
  final String title;
  final String? subtitle;
  final Widget? trailing;
  final VoidCallback? onTap;

  const _SettingsTile({
    required this.icon,
    required this.iconColor,
    required this.iconBg,
    required this.title,
    this.subtitle,
    this.trailing,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.symmetric(horizontal: context.widthPct(24)),
      leading: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: iconBg,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Icon(icon, color: iconColor, size: 24),
      ),
      title: Text(
        title,
        style: AppTextStyles.bodyLarge(
          context,
        ).copyWith(fontWeight: FontWeight.w600),
      ),
      subtitle: subtitle != null
          ? Text(subtitle!, style: AppTextStyles.bodySmall(context))
          : null,
      trailing:
          trailing ??
          Icon(Icons.chevron_right, color: AppColors.grey400, size: 20),
      onTap: onTap,
    );
  }
}
```

### lib/features/ride/views/driver_rating_view.dart
`$ext
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../../../core/utils/responsive.dart';
import '../cubit/ride_cubit.dart';

class DriverRatingView extends StatefulWidget {
  const DriverRatingView({super.key});

  @override
  State<DriverRatingView> createState() => _DriverRatingViewState();
}

class _DriverRatingViewState extends State<DriverRatingView> {
  double _rating = 0;
  final _feedbackController = TextEditingController();
  final List<String> _quickTags = [
    'Great Service',
    'Clean Car',
    'Expert Driving',
  ];
  final Set<String> _selectedTags = {};

  @override
  void dispose() {
    _feedbackController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            // â”€â”€ Top bar
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: context.widthPct(8),
                vertical: context.heightPct(4),
              ),
              child: Row(
                children: [
                  IconButton(
                    icon: Icon(Icons.close, color: AppColors.textPrimary),
                    onPressed: () {
                      context.read<RideCubit>().cancelRide();
                      context.go('/home');
                    },
                  ),
                  Expanded(
                    child: Text(
                      'Rate Driver',
                      textAlign: TextAlign.center,
                      style: AppTextStyles.h2(context),
                    ),
                  ),
                  SizedBox(width: context.widthPct(48)), // balance space
                ],
              ),
            ),

            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: EdgeInsets.symmetric(horizontal: context.widthPct(24)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: context.heightPct(16)),

                    // â”€â”€ Driver Avatar with verified badge
                    Stack(
                      clipBehavior: Clip.none,
                      alignment: Alignment.bottomRight,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(3),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: AppColors.primary,
                              width: 2.5,
                            ),
                          ),
                          child: CircleAvatar(
                            radius: context.widthPct(48),
                            backgroundColor: AppColors.grey200,
                            child: Icon(
                              Icons.person,
                              size: context.widthPct(46),
                              color: AppColors.grey400,
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 2,
                          right: 2,
                          child: Container(
                            padding: EdgeInsets.all(context.widthPct(5)),
                            decoration: BoxDecoration(
                              color: AppColors.primary,
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: AppColors.background,
                                width: 2,
                              ),
                            ),
                            child: Icon(
                              Icons.verified,
                              color: Colors.white,
                              size: context.fontPct(14),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: context.heightPct(16)),

                    // â”€â”€ Driver Name
                    Text(
                      'Marcus Thompson',
                      style: AppTextStyles.h2(
                        context,
                      ).copyWith(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: context.heightPct(4)),
                    Text(
                      'Toyota Camry â€¢ ABC-1234',
                      style: AppTextStyles.bodyMedium(
                        context,
                      ).copyWith(color: AppColors.primary),
                    ),
                    SizedBox(height: context.heightPct(4)),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.star,
                          color: AppColors.warning,
                          size: context.fontPct(14),
                        ),
                        SizedBox(width: context.widthPct(4)),
                        Text(
                          '4.9',
                          style: AppTextStyles.bodySmall(context).copyWith(
                            color: AppColors.warning,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          ' (1,462 trips)',
                          style: AppTextStyles.bodySmall(
                            context,
                          ).copyWith(color: AppColors.textSecondary),
                        ),
                      ],
                    ),

                    SizedBox(height: context.heightPct(32)),

                    // â”€â”€ How was your ride
                    Text(
                      'How was your ride?',
                      style: AppTextStyles.h3(
                        context,
                      ).copyWith(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: context.heightPct(20)),

                    // â”€â”€ Star Rating bar
                    RatingBar.builder(
                      initialRating: _rating,
                      minRating: 0,
                      direction: Axis.horizontal,
                      allowHalfRating: false,
                      itemCount: 5,
                      unratedColor: AppColors.grey300,
                      itemPadding: EdgeInsets.symmetric(
                        horizontal: context.widthPct(6),
                      ),
                      itemSize: context.widthPct(40),
                      itemBuilder: (context, _) =>
                          Icon(Icons.star, color: AppColors.warning),
                      onRatingUpdate: (rating) =>
                          setState(() => _rating = rating),
                    ),

                    SizedBox(height: context.heightPct(28)),

                    // â”€â”€ Optional feedback text
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Optional feedback',
                        style: AppTextStyles.bodySmall(
                          context,
                        ).copyWith(color: AppColors.textSecondary),
                      ),
                    ),
                    SizedBox(height: context.heightPct(8)),
                    TextField(
                      controller: _feedbackController,
                      maxLines: 3,
                      style: AppTextStyles.bodyMedium(context),
                      decoration: InputDecoration(
                        hintText: 'Tell us more about your experience...',
                        hintStyle: AppTextStyles.bodyMedium(
                          context,
                        ).copyWith(color: AppColors.grey400),
                        filled: true,
                        fillColor: AppColors.grey50,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(
                            context.widthPct(12),
                          ),
                          borderSide: BorderSide(color: AppColors.grey200),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(
                            context.widthPct(12),
                          ),
                          borderSide: BorderSide(color: AppColors.grey200),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(
                            context.widthPct(12),
                          ),
                          borderSide: BorderSide(color: AppColors.primary),
                        ),
                        contentPadding: EdgeInsets.all(context.widthPct(16)),
                      ),
                    ),

                    SizedBox(height: context.heightPct(20)),

                    // â”€â”€ Quick Tags
                    Wrap(
                      spacing: context.widthPct(10),
                      runSpacing: context.heightPct(8),
                      children: _quickTags.map((tag) {
                        final selected = _selectedTags.contains(tag);
                        return GestureDetector(
                          onTap: () => setState(() {
                            selected
                                ? _selectedTags.remove(tag)
                                : _selectedTags.add(tag);
                          }),
                          child: Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: context.widthPct(16),
                              vertical: context.heightPct(8),
                            ),
                            decoration: BoxDecoration(
                              color: selected
                                  ? AppColors.primary
                                  : AppColors.background,
                              border: Border.all(
                                color: selected
                                    ? AppColors.primary
                                    : AppColors.grey300,
                              ),
                              borderRadius: BorderRadius.circular(
                                context.widthPct(20),
                              ),
                            ),
                            child: Text(
                              tag,
                              style: AppTextStyles.bodySmall(context).copyWith(
                                color: selected
                                    ? Colors.white
                                    : AppColors.textPrimary,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    ),

                    SizedBox(height: context.heightPct(24)),

                    // â”€â”€ Add tip row
                    Container(
                      padding: EdgeInsets.all(context.widthPct(16)),
                      decoration: BoxDecoration(
                        color: AppColors.grey50,
                        borderRadius: BorderRadius.circular(
                          context.widthPct(12),
                        ),
                        border: Border.all(color: AppColors.grey200),
                      ),
                      child: Row(
                        children: [
                          Container(
                            padding: EdgeInsets.all(context.widthPct(8)),
                            decoration: BoxDecoration(
                              color: AppColors.primary.withValues(alpha: 0.1),
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              Icons.card_giftcard,
                              color: AppColors.primary,
                              size: context.widthPct(18),
                            ),
                          ),
                          SizedBox(width: context.widthPct(12)),
                          Expanded(
                            child: Text(
                              'Add a tip for Marcus?',
                              style: AppTextStyles.bodyMedium(
                                context,
                              ).copyWith(fontWeight: FontWeight.w500),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              // show tip bottom sheet
                              _showTipSheet(context);
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: context.widthPct(14),
                                vertical: context.heightPct(8),
                              ),
                              decoration: BoxDecoration(
                                color: AppColors.primary,
                                borderRadius: BorderRadius.circular(
                                  context.widthPct(8),
                                ),
                              ),
                              child: Text(
                                'Add Tip',
                                style: AppTextStyles.bodySmall(context)
                                    .copyWith(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: context.heightPct(30)),
                  ],
                ),
              ),
            ),

            // â”€â”€ Submit button pinned at bottom
            Padding(
              padding: EdgeInsets.all(context.widthPct(24)),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    padding: EdgeInsets.symmetric(
                      vertical: context.heightPct(18),
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(context.widthPct(50)),
                    ),
                    elevation: 0,
                  ),
                  icon: const Icon(Icons.check, color: Colors.white),
                  label: Text(
                    'Submit Feedback â†’',
                    style: AppTextStyles.button(context).copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  onPressed: () {
                    context.read<RideCubit>().cancelRide();
                    context.go('/home');
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showTipSheet(BuildContext context) {
    final tips = [2, 5, 10, 20];
    int selected = 5;
    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.background,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(context.widthPct(24)),
        ),
      ),
      builder: (ctx) => StatefulBuilder(
        builder: (ctx, setModalState) => Padding(
          padding: EdgeInsets.all(context.widthPct(24)),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Add a tip for Marcus', style: AppTextStyles.h3(context)),
              SizedBox(height: context.heightPct(24)),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: tips.map((amt) {
                  final isSel = selected == amt;
                  return GestureDetector(
                    onTap: () => setModalState(() => selected = amt),
                    child: Container(
                      width: context.widthPct(72),
                      padding: EdgeInsets.symmetric(
                        vertical: context.heightPct(14),
                      ),
                      decoration: BoxDecoration(
                        color: isSel ? AppColors.primary : AppColors.grey50,
                        borderRadius: BorderRadius.circular(
                          context.widthPct(10),
                        ),
                        border: Border.all(
                          color: isSel ? AppColors.primary : AppColors.grey200,
                        ),
                      ),
                      child: Center(
                        child: Text(
                          '\$$amt',
                          style: AppTextStyles.bodyLarge(context).copyWith(
                            color: isSel ? Colors.white : AppColors.textPrimary,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
              SizedBox(height: context.heightPct(24)),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(context.widthPct(50)),
                    ),
                    padding: EdgeInsets.symmetric(
                      vertical: context.heightPct(16),
                    ),
                  ),
                  onPressed: () => Navigator.pop(ctx),
                  child: Text(
                    'Confirm \$$selected Tip',
                    style: AppTextStyles.button(
                      context,
                    ).copyWith(color: Colors.white),
                  ),
                ),
              ),
              SizedBox(height: context.heightPct(8)),
            ],
          ),
        ),
      ),
    );
  }
}
```

### lib/features/ride/views/finding_driver_view.dart
`$ext
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import '../../../../../core/constants/app_colors.dart';
import '../../../../../core/constants/app_text_styles.dart';
import '../../../../../core/utils/responsive.dart';
import '../../../../../core/services/location_service.dart';

class FindingDriverView extends StatefulWidget {
  const FindingDriverView({super.key});

  @override
  State<FindingDriverView> createState() => _FindingDriverViewState();
}

class _FindingDriverViewState extends State<FindingDriverView>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _opacityAnimation;
  final MapController _mapController = MapController();
  LatLng _currentLocation = const LatLng(30.0444, 31.2357);

  @override
  void initState() {
    super.initState();
    _getUserLocation();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat();
    _scaleAnimation = Tween<double>(
      begin: 0.5,
      end: 1.5,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutQuad));
    _opacityAnimation = Tween<double>(
      begin: 1.0,
      end: 0.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutQuad));

    Future.delayed(const Duration(seconds: 4), () {
      if (mounted) context.pushReplacement('/home/active-trip');
    });
  }

  Future<void> _getUserLocation() async {
    try {
      final pos = await LocationService.getCurrentLocation();
      setState(() => _currentLocation = LatLng(pos.latitude, pos.longitude));
      _mapController.move(_currentLocation, 15.0);
    } catch (e) {
      debugPrint('Error: $e');
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          FlutterMap(
            mapController: _mapController,
            options: MapOptions(
              initialCenter: _currentLocation,
              initialZoom: 15.0,
            ),
            children: [
              TileLayer(
                urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                userAgentPackageName: 'com.example',
              ),
            ],
          ),
          Container(color: AppColors.background.withValues(alpha: 0.85)),
          SafeArea(
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.all(context.widthPct(16)),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: IconButton(
                      icon: const Icon(Icons.close),
                      onPressed: () => context.pop(),
                    ),
                  ),
                ),
                const Spacer(),
                Center(
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      AnimatedBuilder(
                        animation: _controller,
                        builder: (context, child) => Transform.scale(
                          scale: _scaleAnimation.value,
                          child: Opacity(
                            opacity: _opacityAnimation.value,
                            child: Container(
                              width: context.widthPct(150),
                              height: context.widthPct(150),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: AppColors.primary.withValues(alpha: 0.5),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        width: context.widthPct(80),
                        height: context.widthPct(80),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColors.primary,
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.black26,
                              blurRadius: 10,
                              spreadRadius: 2,
                            ),
                          ],
                        ),
                        child: const Icon(
                          Icons.search,
                          color: Colors.white,
                          size: 40,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: context.heightPct(40)),
                Text(
                  'Finding the fastest driver\nfor your route...',
                  textAlign: TextAlign.center,
                  style: AppTextStyles.h2(context).copyWith(height: 1.4),
                ),
                SizedBox(height: context.heightPct(16)),
                Text(
                  'Please wait while we connect you to the best drivers nearby.',
                  textAlign: TextAlign.center,
                  style: AppTextStyles.bodyMedium(
                    context,
                  ).copyWith(color: AppColors.textSecondary),
                ),
                const Spacer(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
```

### lib/features/ride/views/widgets/active_trip_details_sheet.dart
`$ext
import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../../../core/utils/responsive.dart';
import '../../data/models/ride_model.dart';

class ActiveTripDetailsSheet extends StatelessWidget {
  final RideModel ride;

  const ActiveTripDetailsSheet({super.key, required this.ride});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        padding: EdgeInsets.fromLTRB(
          context.widthPct(24),
          context.heightPct(16),
          context.widthPct(24),
          context.heightPct(24),
        ),
        decoration: BoxDecoration(
          color: AppColors.background,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(context.widthPct(24)),
            topRight: Radius.circular(context.widthPct(24)),
          ),
          boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 20)],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: context.widthPct(40),
                height: 4,
                decoration: BoxDecoration(
                  color: AppColors.grey300,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            SizedBox(height: context.heightPct(24)),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '8 mins',
                      style: AppTextStyles.h1(context).copyWith(
                        color: AppColors.primary,
                        fontSize: context.fontPct(28),
                      ),
                    ),
                    Text(
                      'Arriving at 4:25 PM â€¢ 2.4 km',
                      style: AppTextStyles.bodyMedium(
                        context,
                      ).copyWith(color: AppColors.textSecondary),
                    ),
                  ],
                ),
                Row(
                  children: [
                    CircleAvatar(
                      backgroundColor: AppColors.primary.withValues(alpha: 0.1),
                      radius: context.widthPct(24),
                      child: Icon(Icons.call, color: AppColors.primary),
                    ),
                    SizedBox(width: context.widthPct(12)),
                    CircleAvatar(
                      backgroundColor: AppColors.primary,
                      radius: context.widthPct(24),
                      child: const Icon(Icons.chat_bubble, color: Colors.white),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: context.heightPct(24)),
            Stack(
              children: [
                Container(
                  height: 6,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: AppColors.grey200,
                    borderRadius: BorderRadius.circular(3),
                  ),
                ),
                Container(
                  height: 6,
                  width: context.widthPct(220),
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    borderRadius: BorderRadius.circular(3),
                  ),
                ),
              ],
            ),
            SizedBox(height: context.heightPct(24)),
            Container(
              padding: EdgeInsets.all(context.widthPct(16)),
              decoration: BoxDecoration(
                color: AppColors.grey50,
                borderRadius: BorderRadius.circular(context.widthPct(12)),
              ),
              child: Row(
                children: [
                  Stack(
                    clipBehavior: Clip.none,
                    children: [
                      CircleAvatar(
                        radius: context.widthPct(24),
                        backgroundColor: const Color(0xFF2C3E50),
                        child: Icon(
                          Icons.person,
                          color: const Color(0xFFE5CC98),
                          size: context.widthPct(30),
                        ),
                      ),
                      Positioned(
                        bottom: -8,
                        left: 4,
                        right: 4,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 4,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.primary,
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                ride.driverRating.toString(),
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const Icon(
                                Icons.star,
                                color: Colors.white,
                                size: 8,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(width: context.widthPct(16)),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(ride.driverName, style: AppTextStyles.h3(context)),
                        Text(
                          ride.title,
                          style: AppTextStyles.bodySmall(context),
                        ),
                        Text(
                          ride.licensePlate,
                          style: AppTextStyles.bodySmall(context).copyWith(
                            color: AppColors.primary,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: context.widthPct(60),
                    height: context.heightPct(40),
                    decoration: BoxDecoration(
                      color: AppColors.grey200,
                      borderRadius: BorderRadius.circular(context.widthPct(8)),
                    ),
                    child: Icon(Icons.directions_car, color: AppColors.grey500),
                  ),
                ],
              ),
            ),
            SizedBox(height: context.heightPct(24)),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    style: OutlinedButton.styleFrom(
                      side: BorderSide(color: AppColors.grey200),
                      padding: EdgeInsets.symmetric(
                        vertical: context.heightPct(16),
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                          context.widthPct(12),
                        ),
                      ),
                    ),
                    icon: Icon(Icons.share, color: AppColors.primary),
                    label: Text(
                      'Share\nStatus',
                      textAlign: TextAlign.center,
                      style: AppTextStyles.bodyMedium(
                        context,
                      ).copyWith(fontWeight: FontWeight.bold),
                    ),
                    onPressed: () {},
                  ),
                ),
                SizedBox(width: context.widthPct(16)),
                Expanded(
                  child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary.withValues(alpha: 0.1),
                      elevation: 0,
                      padding: EdgeInsets.symmetric(
                        vertical: context.heightPct(16),
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                          context.widthPct(12),
                        ),
                      ),
                    ),
                    icon: Icon(Icons.cell_tower, color: AppColors.primary),
                    label: Text(
                      'Emergency\nSOS',
                      textAlign: TextAlign.center,
                      style: AppTextStyles.bodyMedium(context).copyWith(
                        fontWeight: FontWeight.bold,
                        color: AppColors.primary,
                      ),
                    ),
                    onPressed: () {},
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
```

### lib/features/ride/views/widgets/ride_selection_sheet.dart
`$ext
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../../../core/utils/responsive.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../cubit/ride_cubit.dart';
import '../../cubit/ride_state.dart';
import '../../data/models/ride_model.dart';

class RideSelectionSheet extends StatefulWidget {
  final RideState state;
  const RideSelectionSheet({super.key, required this.state});

  @override
  State<RideSelectionSheet> createState() => _RideSelectionSheetState();
}

class _RideSelectionSheetState extends State<RideSelectionSheet> {
  RideModel? _selectedRide;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.background,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(context.widthPct(24)),
            topRight: Radius.circular(context.widthPct(24)),
          ),
          boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 10)],
        ),
        child: SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(height: context.heightPct(12)),
              Container(
                width: context.widthPct(40),
                height: context.heightPct(4),
                decoration: BoxDecoration(
                  color: AppColors.grey300,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              SizedBox(height: context.heightPct(16)),
              Text('Choose a Ride', style: AppTextStyles.h3(context)),
              SizedBox(height: context.heightPct(16)),
              if (widget.state is RideLoading)
                Padding(
                  padding: EdgeInsets.all(context.widthPct(32)),
                  child: const CircularProgressIndicator(),
                )
              else if (widget.state is RideOptionsLoaded)
                _buildRideOptions(
                  context,
                  (widget.state as RideOptionsLoaded).rides,
                ),
              Padding(
                padding: EdgeInsets.all(context.widthPct(16)),
                child: CustomButton(
                  text: _selectedRide == null
                      ? 'Select a Ride'
                      : 'Confirm ${_selectedRide!.title}',
                  onPressed: _selectedRide == null
                      ? () {}
                      : () => context.read<RideCubit>().requestRide(
                          _selectedRide!,
                        ),
                  backgroundColor: _selectedRide == null
                      ? AppColors.grey400
                      : AppColors.primary,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRideOptions(BuildContext context, List<RideModel> rides) {
    return Expanded(
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: rides.length,
        itemBuilder: (context, index) {
          final ride = rides[index];
          final isSelected = _selectedRide?.id == ride.id;
          return GestureDetector(
            onTap: () => setState(() => _selectedRide = ride),
            child: Container(
              margin: EdgeInsets.symmetric(
                horizontal: context.widthPct(16),
                vertical: context.heightPct(8),
              ),
              decoration: BoxDecoration(
                border: Border.all(
                  color: isSelected ? AppColors.primary : AppColors.grey200,
                  width: isSelected ? 2 : 1,
                ),
                borderRadius: BorderRadius.circular(context.widthPct(12)),
                color: isSelected
                    ? AppColors.primary.withValues(alpha: 0.05)
                    : Colors.white,
              ),
              padding: EdgeInsets.all(context.widthPct(16)),
              child: Row(
                children: [
                  Icon(
                    Icons.directions_car,
                    size: context.widthPct(40),
                    color: AppColors.textPrimary,
                  ),
                  SizedBox(width: context.widthPct(16)),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          ride.title,
                          style: AppTextStyles.bodyLarge(
                            context,
                          ).copyWith(fontWeight: FontWeight.bold),
                        ),
                        Text(
                          '${ride.durationMinutes} min',
                          style: AppTextStyles.bodySmall(context),
                        ),
                      ],
                    ),
                  ),
                  Text(
                    '\$${ride.price.toStringAsFixed(2)}',
                    style: AppTextStyles.h3(context),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
```

### lib/features/safety/views/safety_view.dart
`$ext
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../core/utils/responsive.dart';

class SafetyView extends StatefulWidget {
  const SafetyView({super.key});

  @override
  State<SafetyView> createState() => _SafetyViewState();
}

class _SafetyViewState extends State<SafetyView> {
  bool _holding = false;

  final List<_Contact> _contacts = const [
    _Contact(
      name: 'Sarah Jenkins',
      relation: 'Wife',
      phone: '+1 (555) 012-3456',
    ),
    _Contact(
      name: 'Marcus Volt',
      relation: 'Brother',
      phone: '+1 (555) 012-7890',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: AppColors.primary),
          onPressed: () => context.pop(),
        ),
        title: Text('Safety & Emergency', style: AppTextStyles.h2(context)),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: EdgeInsets.fromLTRB(
          context.widthPct(16),
          context.heightPct(8),
          context.widthPct(16),
          context.heightPct(40),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // â”€â”€ SOS Card
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(context.widthPct(24)),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFFE23030), Color(0xFFFF6B6B)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(context.widthPct(16)),
              ),
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.all(context.widthPct(16)),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.2),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.wifi_tethering,
                      color: Colors.white,
                      size: context.widthPct(36),
                    ),
                  ),
                  SizedBox(height: context.heightPct(12)),
                  Text(
                    'SOS EMERGENCY',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: context.fontPct(22),
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.2,
                    ),
                  ),
                  SizedBox(height: context.heightPct(8)),
                  Text(
                    'Immediately notify authorities and your\nemergency contacts.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white.withValues(alpha: 0.85),
                      fontSize: context.fontPct(13),
                      height: 1.4,
                    ),
                  ),
                  SizedBox(height: context.heightPct(20)),
                  GestureDetector(
                    onLongPress: () {
                      setState(() => _holding = true);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: const Text(
                            'ðŸš¨ SOS Activated! Contacting emergency services...',
                          ),
                          backgroundColor: AppColors.error,
                        ),
                      );
                    },
                    onLongPressEnd: (_) => setState(() => _holding = false),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 150),
                      padding: EdgeInsets.symmetric(
                        horizontal: context.widthPct(32),
                        vertical: context.heightPct(14),
                      ),
                      decoration: BoxDecoration(
                        color: _holding
                            ? Colors.white.withValues(alpha: 0.9)
                            : Colors.white,
                        borderRadius: BorderRadius.circular(
                          context.widthPct(50),
                        ),
                        border: Border.all(color: Colors.white, width: 2),
                      ),
                      child: Text(
                        'HOLD TO ACTIVATE SOS',
                        style: TextStyle(
                          color: AppColors.primary,
                          fontWeight: FontWeight.bold,
                          fontSize: context.fontPct(13),
                          letterSpacing: 1.1,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: context.heightPct(20)),

            // â”€â”€ Map placeholder
            ClipRRect(
              borderRadius: BorderRadius.circular(context.widthPct(12)),
              child: Container(
                height: context.heightPct(160),
                color: const Color(0xFFCDD5BF),
                child: Stack(
                  children: [
                    Positioned.fill(
                      child: CustomPaint(painter: _GridPainter()),
                    ),
                    Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.map,
                            color: Colors.white70,
                            size: context.widthPct(40),
                          ),
                          SizedBox(height: context.heightPct(4)),
                          Text(
                            'New York',
                            style: TextStyle(
                              color: Colors.white70,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Positioned(
                      top: context.heightPct(40),
                      left: context.widthPct(60),
                      child: Icon(
                        Icons.location_on,
                        color: AppColors.primary,
                        size: context.widthPct(28),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            SizedBox(height: context.heightPct(20)),

            // â”€â”€ Share Trip Status
            Container(
              padding: EdgeInsets.all(context.widthPct(16)),
              decoration: BoxDecoration(
                color: AppColors.grey50,
                borderRadius: BorderRadius.circular(context.widthPct(12)),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.all(context.widthPct(8)),
                    decoration: BoxDecoration(
                      color: AppColors.primary.withValues(alpha: 0.1),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.share_location,
                      color: AppColors.primary,
                      size: context.widthPct(22),
                    ),
                  ),
                  SizedBox(width: context.widthPct(14)),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Share Trip Status',
                          style: AppTextStyles.bodyLarge(
                            context,
                          ).copyWith(fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: context.heightPct(4)),
                        Text(
                          'Keep your loved ones informed. Let them track your ride in real-time until you arrive safely.',
                          style: AppTextStyles.bodySmall(context).copyWith(
                            color: AppColors.textSecondary,
                            height: 1.4,
                          ),
                        ),
                        SizedBox(height: context.heightPct(14)),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.primary,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                  context.widthPct(50),
                                ),
                              ),
                              padding: EdgeInsets.symmetric(
                                vertical: context.heightPct(14),
                              ),
                              elevation: 0,
                            ),
                            onPressed: () {},
                            child: Text(
                              'Share with Family',
                              style: AppTextStyles.button(context).copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: context.heightPct(24)),

            // â”€â”€ Emergency Contacts header
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Emergency Contacts',
                  style: AppTextStyles.h3(
                    context,
                  ).copyWith(fontWeight: FontWeight.bold),
                ),
                GestureDetector(
                  onTap: () {},
                  child: Row(
                    children: [
                      Icon(
                        Icons.add_circle_outline,
                        color: AppColors.primary,
                        size: context.fontPct(16),
                      ),
                      SizedBox(width: context.widthPct(4)),
                      Text(
                        'Add New',
                        style: AppTextStyles.bodySmall(context).copyWith(
                          color: AppColors.primary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: context.heightPct(12)),

            // â”€â”€ Contacts list
            ..._contacts.map(
              (c) => Container(
                margin: EdgeInsets.only(bottom: context.heightPct(10)),
                padding: EdgeInsets.all(context.widthPct(16)),
                decoration: BoxDecoration(
                  color: AppColors.background,
                  borderRadius: BorderRadius.circular(context.widthPct(12)),
                  boxShadow: const [
                    BoxShadow(
                      color: Color(0x0A000000),
                      blurRadius: 6,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Container(
                      padding: EdgeInsets.all(context.widthPct(10)),
                      decoration: BoxDecoration(
                        color: AppColors.primary.withValues(alpha: 0.1),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.person_outline,
                        color: AppColors.primary,
                        size: context.widthPct(20),
                      ),
                    ),
                    SizedBox(width: context.widthPct(14)),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            c.name,
                            style: AppTextStyles.bodyLarge(
                              context,
                            ).copyWith(fontWeight: FontWeight.bold),
                          ),
                          Text(
                            '${c.relation} â€¢ ${c.phone}',
                            style: AppTextStyles.bodySmall(
                              context,
                            ).copyWith(color: AppColors.textSecondary),
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                      icon: Icon(
                        Icons.phone_outlined,
                        color: AppColors.primary,
                      ),
                      onPressed: () {},
                    ),
                  ],
                ),
              ),
            ),

            SizedBox(height: context.heightPct(24)),

            // â”€â”€ Bottom 2 cards
            Row(
              children: [
                Expanded(
                  child: _BottomCard(
                    icon: Icons.shield_outlined,
                    title: 'Safety Center',
                    subtitle: 'Read our safety guide',
                    onTap: () {},
                  ),
                ),
                SizedBox(width: context.widthPct(12)),
                Expanded(
                  child: _BottomCard(
                    icon: Icons.mic_outlined,
                    title: 'Audio Record',
                    subtitle: 'Securely record ride audio',
                    onTap: () {},
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _BottomCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  const _BottomCard({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(context.widthPct(16)),
        decoration: BoxDecoration(
          color: AppColors.grey50,
          borderRadius: BorderRadius.circular(context.widthPct(12)),
          border: Border.all(color: AppColors.grey200),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.all(context.widthPct(8)),
              decoration: BoxDecoration(
                color: AppColors.primary.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(context.widthPct(8)),
              ),
              child: Icon(
                icon,
                color: AppColors.primary,
                size: context.widthPct(20),
              ),
            ),
            SizedBox(height: context.heightPct(8)),
            Text(
              title,
              style: AppTextStyles.bodyMedium(
                context,
              ).copyWith(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: context.heightPct(2)),
            Text(
              subtitle,
              style: AppTextStyles.bodySmall(
                context,
              ).copyWith(color: AppColors.textSecondary),
            ),
          ],
        ),
      ),
    );
  }
}

class _Contact {
  final String name;
  final String relation;
  final String phone;
  const _Contact({
    required this.name,
    required this.relation,
    required this.phone,
  });
}

class _GridPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withValues(alpha: 0.15)
      ..strokeWidth = 1;
    for (double x = 0; x < size.width; x += 30) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), paint);
    }
    for (double y = 0; y < size.height; y += 30) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter old) => false;
}
```

### macos/Flutter/GeneratedPluginRegistrant.swift
`$ext
//
//  Generated file. Do not edit.
//

import FlutterMacOS
import Foundation

import file_selector_macos
import firebase_auth
import firebase_core
import geolocator_apple
import sqflite_darwin

func RegisterGeneratedPlugins(registry: FlutterPluginRegistry) {
  FileSelectorPlugin.register(with: registry.registrar(forPlugin: "FileSelectorPlugin"))
  FLTFirebaseAuthPlugin.register(with: registry.registrar(forPlugin: "FLTFirebaseAuthPlugin"))
  FLTFirebaseCorePlugin.register(with: registry.registrar(forPlugin: "FLTFirebaseCorePlugin"))
  GeolocatorPlugin.register(with: registry.registrar(forPlugin: "GeolocatorPlugin"))
  SqflitePlugin.register(with: registry.registrar(forPlugin: "SqflitePlugin"))
}
```

### pubspec.lock
`$ext
# Generated by pub
# See https://dart.dev/tools/pub/glossary#lockfile
packages:
  _flutterfire_internals:
    dependency: transitive
    description:
      name: _flutterfire_internals
      sha256: "37a42d06068e2fe3deddb2da079a8c4d105f241225ba27b7122b37e9865fd8f7"
      url: "https://pub.dev"
    source: hosted
    version: "1.3.35"
  async:
    dependency: transitive
    description:
      name: async
      sha256: "758e6d74e971c3e5aceb4110bfd6698efc7f501675bcfe0c775459a8140750eb"
      url: "https://pub.dev"
    source: hosted
    version: "2.13.0"
  bloc:
    dependency: transitive
    description:
      name: bloc
      sha256: "106842ad6569f0b60297619e9e0b1885c2fb9bf84812935490e6c5275777804e"
      url: "https://pub.dev"
    source: hosted
    version: "8.1.4"
  boolean_selector:
    dependency: transitive
    description:
      name: boolean_selector
      sha256: "8aab1771e1243a5063b8b0ff68042d67334e3feab9e95b9490f9a6ebf73b42ea"
      url: "https://pub.dev"
    source: hosted
    version: "2.1.2"
  cached_network_image:
    dependency: "direct main"
    description:
      name: cached_network_image
      sha256: "7c1183e361e5c8b0a0f21a28401eecdbde252441106a9816400dd4c2b2424916"
      url: "https://pub.dev"
    source: hosted
    version: "3.4.1"
  cached_network_image_platform_interface:
    dependency: transitive
    description:
      name: cached_network_image_platform_interface
      sha256: "35814b016e37fbdc91f7ae18c8caf49ba5c88501813f73ce8a07027a395e2829"
      url: "https://pub.dev"
    source: hosted
    version: "4.1.1"
  cached_network_image_web:
    dependency: transitive
    description:
      name: cached_network_image_web
      sha256: "980842f4e8e2535b8dbd3d5ca0b1f0ba66bf61d14cc3a17a9b4788a3685ba062"
      url: "https://pub.dev"
    source: hosted
    version: "1.3.1"
  characters:
    dependency: transitive
    description:
      name: characters
      sha256: f71061c654a3380576a52b451dd5532377954cf9dbd272a78fc8479606670803
      url: "https://pub.dev"
    source: hosted
    version: "1.4.0"
  clock:
    dependency: transitive
    description:
      name: clock
      sha256: fddb70d9b5277016c77a80201021d40a2247104d9f4aa7bab7157b7e3f05b84b
      url: "https://pub.dev"
    source: hosted
    version: "1.1.2"
  code_assets:
    dependency: transitive
    description:
      name: code_assets
      sha256: "83ccdaa064c980b5596c35dd64a8d3ecc68620174ab9b90b6343b753aa721687"
      url: "https://pub.dev"
    source: hosted
    version: "1.0.0"
  collection:
    dependency: transitive
    description:
      name: collection
      sha256: "2f5709ae4d3d59dd8f7cd309b4e023046b57d8a6c82130785d2b0e5868084e76"
      url: "https://pub.dev"
    source: hosted
    version: "1.19.1"
  cross_file:
    dependency: transitive
    description:
      name: cross_file
      sha256: "28bb3ae56f117b5aec029d702a90f57d285cd975c3c5c281eaca38dbc47c5937"
      url: "https://pub.dev"
    source: hosted
    version: "0.3.5+2"
  crypto:
    dependency: transitive
    description:
      name: crypto
      sha256: c8ea0233063ba03258fbcf2ca4d6dadfefe14f02fab57702265467a19f27fadf
      url: "https://pub.dev"
    source: hosted
    version: "3.0.7"
  cupertino_icons:
    dependency: "direct main"
    description:
      name: cupertino_icons
      sha256: ba631d1c7f7bef6b729a622b7b752645a2d076dba9976925b8f25725a30e1ee6
      url: "https://pub.dev"
    source: hosted
    version: "1.0.8"
  dio:
    dependency: "direct main"
    description:
      name: dio
      sha256: aff32c08f92787a557dd5c0145ac91536481831a01b4648136373cddb0e64f8c
      url: "https://pub.dev"
    source: hosted
    version: "5.9.2"
  dio_web_adapter:
    dependency: transitive
    description:
      name: dio_web_adapter
      sha256: "2f9e64323a7c3c7ef69567d5c800424a11f8337b8b228bad02524c9fb3c1f340"
      url: "https://pub.dev"
    source: hosted
    version: "2.1.2"
  equatable:
    dependency: "direct main"
    description:
      name: equatable
      sha256: "3e0141505477fd8ad55d6eb4e7776d3fe8430be8e497ccb1521370c3f21a3e2b"
      url: "https://pub.dev"
    source: hosted
    version: "2.0.8"
  fake_async:
    dependency: transitive
    description:
      name: fake_async
      sha256: "5368f224a74523e8d2e7399ea1638b37aecfca824a3cc4dfdf77bf1fa905ac44"
      url: "https://pub.dev"
    source: hosted
    version: "1.3.3"
  ffi:
    dependency: transitive
    description:
      name: ffi
      sha256: "6d7fd89431262d8f3125e81b50d3847a091d846eafcd4fdb88dd06f36d705a45"
      url: "https://pub.dev"
    source: hosted
    version: "2.2.0"
  file:
    dependency: transitive
    description:
      name: file
      sha256: a3b4f84adafef897088c160faf7dfffb7696046cb13ae90b508c2cbc95d3b8d4
      url: "https://pub.dev"
    source: hosted
    version: "7.0.1"
  file_selector_linux:
    dependency: transitive
    description:
      name: file_selector_linux
      sha256: "2567f398e06ac72dcf2e98a0c95df2a9edd03c2c2e0cacd4780f20cdf56263a0"
      url: "https://pub.dev"
    source: hosted
    version: "0.9.4"
  file_selector_macos:
    dependency: transitive
    description:
      name: file_selector_macos
      sha256: "5e0bbe9c312416f1787a68259ea1505b52f258c587f12920422671807c4d618a"
      url: "https://pub.dev"
    source: hosted
    version: "0.9.5"
  file_selector_platform_interface:
    dependency: transitive
    description:
      name: file_selector_platform_interface
      sha256: "35e0bd61ebcdb91a3505813b055b09b79dfdc7d0aee9c09a7ba59ae4bb13dc85"
      url: "https://pub.dev"
    source: hosted
    version: "2.7.0"
  file_selector_windows:
    dependency: transitive
    description:
      name: file_selector_windows
      sha256: "62197474ae75893a62df75939c777763d39c2bc5f73ce5b88497208bc269abfd"
      url: "https://pub.dev"
    source: hosted
    version: "0.9.3+5"
  firebase_auth:
    dependency: "direct main"
    description:
      name: firebase_auth
      sha256: "279b2773ff61afd9763202cb5582e2b995ee57419d826b9af6517302a59b672f"
      url: "https://pub.dev"
    source: hosted
    version: "4.16.0"
  firebase_auth_platform_interface:
    dependency: transitive
    description:
      name: firebase_auth_platform_interface
      sha256: a0270e1db3b2098a14cb2a2342b3cd2e7e458e0c391b1f64f6f78b14296ec093
      url: "https://pub.dev"
    source: hosted
    version: "7.3.0"
  firebase_auth_web:
    dependency: transitive
    description:
      name: firebase_auth_web
      sha256: c7b1379ccef7abf4b6816eede67a868c44142198e42350f51c01d8fc03f95a7d
      url: "https://pub.dev"
    source: hosted
    version: "5.8.13"
  firebase_core:
    dependency: "direct main"
    description:
      name: firebase_core
      sha256: "26de145bb9688a90962faec6f838247377b0b0d32cc0abecd9a4e43525fc856c"
      url: "https://pub.dev"
    source: hosted
    version: "2.32.0"
  firebase_core_platform_interface:
    dependency: transitive
    description:
      name: firebase_core_platform_interface
      sha256: "8bcfad6d7033f5ea951d15b867622a824b13812178bfec0c779b9d81de011bbb"
      url: "https://pub.dev"
    source: hosted
    version: "5.4.2"
  firebase_core_web:
    dependency: transitive
    description:
      name: firebase_core_web
      sha256: eb3afccfc452b2b2075acbe0c4b27de62dd596802b4e5e19869c1e926cbb20b3
      url: "https://pub.dev"
    source: hosted
    version: "2.24.0"
  fixnum:
    dependency: transitive
    description:
      name: fixnum
      sha256: b6dc7065e46c974bc7c5f143080a6764ec7a4be6da1285ececdc37be96de53be
      url: "https://pub.dev"
    source: hosted
    version: "1.1.1"
  flutter:
    dependency: "direct main"
    description: flutter
    source: sdk
    version: "0.0.0"
  flutter_bloc:
    dependency: "direct main"
    description:
      name: flutter_bloc
      sha256: b594505eac31a0518bdcb4b5b79573b8d9117b193cc80cc12e17d639b10aa27a
      url: "https://pub.dev"
    source: hosted
    version: "8.1.6"
  flutter_cache_manager:
    dependency: transitive
    description:
      name: flutter_cache_manager
      sha256: "400b6592f16a4409a7f2bb929a9a7e38c72cceb8ffb99ee57bbf2cb2cecf8386"
      url: "https://pub.dev"
    source: hosted
    version: "3.4.1"
  flutter_lints:
    dependency: "direct dev"
    description:
      name: flutter_lints
      sha256: "3105dc8492f6183fb076ccf1f351ac3d60564bff92e20bfc4af9cc1651f4e7e1"
      url: "https://pub.dev"
    source: hosted
    version: "6.0.0"
  flutter_map:
    dependency: "direct main"
    description:
      name: flutter_map
      sha256: "87cc8349b8fa5dccda5af50018c7374b6645334a0d680931c1fe11bce88fa5bb"
      url: "https://pub.dev"
    source: hosted
    version: "6.2.1"
  flutter_plugin_android_lifecycle:
    dependency: transitive
    description:
      name: flutter_plugin_android_lifecycle
      sha256: "38d1c268de9097ff59cf0e844ac38759fc78f76836d37edad06fa21e182055a0"
      url: "https://pub.dev"
    source: hosted
    version: "2.0.34"
  flutter_rating_bar:
    dependency: "direct main"
    description:
      name: flutter_rating_bar
      sha256: d2af03469eac832c591a1eba47c91ecc871fe5708e69967073c043b2d775ed93
      url: "https://pub.dev"
    source: hosted
    version: "4.0.1"
  flutter_screenutil:
    dependency: "direct main"
    description:
      name: flutter_screenutil
      sha256: "8239210dd68bee6b0577aa4a090890342d04a136ce1c81f98ee513fc0ce891de"
      url: "https://pub.dev"
    source: hosted
    version: "5.9.3"
  flutter_svg:
    dependency: "direct main"
    description:
      name: flutter_svg
      sha256: "6ff9fa12892ae074092de2fa6a9938fb21dbabfdaa2ff57dc697ff912fc8d4b2"
      url: "https://pub.dev"
    source: hosted
    version: "1.1.6"
  flutter_test:
    dependency: "direct dev"
    description: flutter
    source: sdk
    version: "0.0.0"
  flutter_web_plugins:
    dependency: transitive
    description: flutter
    source: sdk
    version: "0.0.0"
  font_awesome_flutter:
    dependency: "direct main"
    description:
      name: font_awesome_flutter
      sha256: "09dcde8ab90ffae1a7d65ff2ef96fc62a17ad9d0ce7c127b317ded676b0d5935"
      url: "https://pub.dev"
    source: hosted
    version: "11.0.0"
  geocoding:
    dependency: "direct main"
    description:
      name: geocoding
      sha256: "606be036287842d779d7ec4e2f6c9435fc29bbbd3c6da6589710f981d8852895"
      url: "https://pub.dev"
    source: hosted
    version: "4.0.0"
  geocoding_android:
    dependency: transitive
    description:
      name: geocoding_android
      sha256: ba810da90d6633cbb82bbab630e5b4a3b7d23503263c00ae7f1ef0316dcae5b9
      url: "https://pub.dev"
    source: hosted
    version: "4.0.1"
  geocoding_ios:
    dependency: transitive
    description:
      name: geocoding_ios
      sha256: "18ab1c8369e2b0dcb3a8ccc907319334f35ee8cf4cfef4d9c8e23b13c65cb825"
      url: "https://pub.dev"
    source: hosted
    version: "3.1.0"
  geocoding_platform_interface:
    dependency: transitive
    description:
      name: geocoding_platform_interface
      sha256: "8c2c8226e5c276594c2e18bfe88b19110ed770aeb7c1ab50ede570be8b92229b"
      url: "https://pub.dev"
    source: hosted
    version: "3.2.0"
  geolocator:
    dependency: "direct main"
    description:
      name: geolocator
      sha256: f4efb8d3c4cdcad2e226af9661eb1a0dd38c71a9494b22526f9da80ab79520e5
      url: "https://pub.dev"
    source: hosted
    version: "10.1.1"
  geolocator_android:
    dependency: transitive
    description:
      name: geolocator_android
      sha256: fcb1760a50d7500deca37c9a666785c047139b5f9ee15aa5469fae7dbbe3170d
      url: "https://pub.dev"
    source: hosted
    version: "4.6.2"
  geolocator_apple:
    dependency: transitive
    description:
      name: geolocator_apple
      sha256: dbdd8789d5aaf14cf69f74d4925ad1336b4433a6efdf2fce91e8955dc921bf22
      url: "https://pub.dev"
    source: hosted
    version: "2.3.13"
  geolocator_platform_interface:
    dependency: transitive
    description:
      name: geolocator_platform_interface
      sha256: "30cb64f0b9adcc0fb36f628b4ebf4f731a2961a0ebd849f4b56200205056fe67"
      url: "https://pub.dev"
    source: hosted
    version: "4.2.6"
  geolocator_web:
    dependency: transitive
    description:
      name: geolocator_web
      sha256: "102e7da05b48ca6bf0a5bda0010f886b171d1a08059f01bfe02addd0175ebece"
      url: "https://pub.dev"
    source: hosted
    version: "2.2.1"
  geolocator_windows:
    dependency: transitive
    description:
      name: geolocator_windows
      sha256: "175435404d20278ffd220de83c2ca293b73db95eafbdc8131fe8609be1421eb6"
      url: "https://pub.dev"
    source: hosted
    version: "0.2.5"
  glob:
    dependency: transitive
    description:
      name: glob
      sha256: c3f1ee72c96f8f78935e18aa8cecced9ab132419e8625dc187e1c2408efc20de
      url: "https://pub.dev"
    source: hosted
    version: "2.1.3"
  go_router:
    dependency: "direct main"
    description:
      name: go_router
      sha256: f02fd7d2a4dc512fec615529824fdd217fecb3a3d3de68360293a551f21634b3
      url: "https://pub.dev"
    source: hosted
    version: "14.8.1"
  google_fonts:
    dependency: "direct main"
    description:
      name: google_fonts
      sha256: ba03d03bcaa2f6cb7bd920e3b5027181db75ab524f8891c8bc3aa603885b8055
      url: "https://pub.dev"
    source: hosted
    version: "6.3.3"
  hooks:
    dependency: transitive
    description:
      name: hooks
      sha256: e79ed1e8e1929bc6ecb6ec85f0cb519c887aa5b423705ded0d0f2d9226def388
      url: "https://pub.dev"
    source: hosted
    version: "1.0.2"
  http:
    dependency: transitive
    description:
      name: http
      sha256: "87721a4a50b19c7f1d49001e51409bddc46303966ce89a65af4f4e6004896412"
      url: "https://pub.dev"
    source: hosted
    version: "1.6.0"
  http_parser:
    dependency: transitive
    description:
      name: http_parser
      sha256: "178d74305e7866013777bab2c3d8726205dc5a4dd935297175b19a23a2e66571"
      url: "https://pub.dev"
    source: hosted
    version: "4.1.2"
  image_picker:
    dependency: "direct main"
    description:
      name: image_picker
      sha256: "784210112be18ea55f69d7076e2c656a4e24949fa9e76429fe53af0c0f4fa320"
      url: "https://pub.dev"
    source: hosted
    version: "1.2.1"
  image_picker_android:
    dependency: transitive
    description:
      name: image_picker_android
      sha256: "9eae0cbd672549dacc18df855c2a23782afe4854ada5190b7d63b30ee0b0d3fd"
      url: "https://pub.dev"
    source: hosted
    version: "0.8.13+15"
  image_picker_for_web:
    dependency: transitive
    description:
      name: image_picker_for_web
      sha256: "66257a3191ab360d23a55c8241c91a6e329d31e94efa7be9cf7a212e65850214"
      url: "https://pub.dev"
    source: hosted
    version: "3.1.1"
  image_picker_ios:
    dependency: transitive
    description:
      name: image_picker_ios
      sha256: b9c4a438a9ff4f60808c9cf0039b93a42bb6c2211ef6ebb647394b2b3fa84588
      url: "https://pub.dev"
    source: hosted
    version: "0.8.13+6"
  image_picker_linux:
    dependency: transitive
    description:
      name: image_picker_linux
      sha256: "1f81c5f2046b9ab724f85523e4af65be1d47b038160a8c8deed909762c308ed4"
      url: "https://pub.dev"
    source: hosted
    version: "0.2.2"
  image_picker_macos:
    dependency: transitive
    description:
      name: image_picker_macos
      sha256: "86f0f15a309de7e1a552c12df9ce5b59fe927e71385329355aec4776c6a8ec91"
      url: "https://pub.dev"
    source: hosted
    version: "0.2.2+1"
  image_picker_platform_interface:
    dependency: transitive
    description:
      name: image_picker_platform_interface
      sha256: "567e056716333a1647c64bb6bd873cff7622233a5c3f694be28a583d4715690c"
      url: "https://pub.dev"
    source: hosted
    version: "2.11.1"
  image_picker_windows:
    dependency: transitive
    description:
      name: image_picker_windows
      sha256: d248c86554a72b5495a31c56f060cf73a41c7ff541689327b1a7dbccc33adfae
      url: "https://pub.dev"
    source: hosted
    version: "0.2.2"
  intl:
    dependency: transitive
    description:
      name: intl
      sha256: "3df61194eb431efc39c4ceba583b95633a403f46c9fd341e550ce0bfa50e9aa5"
      url: "https://pub.dev"
    source: hosted
    version: "0.20.2"
  js:
    dependency: transitive
    description:
      name: js
      sha256: f2c445dce49627136094980615a031419f7f3eb393237e4ecd97ac15dea343f3
      url: "https://pub.dev"
    source: hosted
    version: "0.6.7"
  latlong2:
    dependency: "direct main"
    description:
      name: latlong2
      sha256: "98227922caf49e6056f91b6c56945ea1c7b166f28ffcd5fb8e72fc0b453cc8fe"
      url: "https://pub.dev"
    source: hosted
    version: "0.9.1"
  leak_tracker:
    dependency: transitive
    description:
      name: leak_tracker
      sha256: "33e2e26bdd85a0112ec15400c8cbffea70d0f9c3407491f672a2fad47915e2de"
      url: "https://pub.dev"
    source: hosted
    version: "11.0.2"
  leak_tracker_flutter_testing:
    dependency: transitive
    description:
      name: leak_tracker_flutter_testing
      sha256: "1dbc140bb5a23c75ea9c4811222756104fbcd1a27173f0c34ca01e16bea473c1"
      url: "https://pub.dev"
    source: hosted
    version: "3.0.10"
  leak_tracker_testing:
    dependency: transitive
    description:
      name: leak_tracker_testing
      sha256: "8d5a2d49f4a66b49744b23b018848400d23e54caf9463f4eb20df3eb8acb2eb1"
      url: "https://pub.dev"
    source: hosted
    version: "3.0.2"
  lints:
    dependency: transitive
    description:
      name: lints
      sha256: "12f842a479589fea194fe5c5a3095abc7be0c1f2ddfa9a0e76aed1dbd26a87df"
      url: "https://pub.dev"
    source: hosted
    version: "6.1.0"
  lists:
    dependency: transitive
    description:
      name: lists
      sha256: "4ca5c19ae4350de036a7e996cdd1ee39c93ac0a2b840f4915459b7d0a7d4ab27"
      url: "https://pub.dev"
    source: hosted
    version: "1.0.1"
  logger:
    dependency: transitive
    description:
      name: logger
      sha256: "25aee487596a6257655a1e091ec2ae66bc30e7af663592cc3a27e6591e05035c"
      url: "https://pub.dev"
    source: hosted
    version: "2.7.0"
  logging:
    dependency: transitive
    description:
      name: logging
      sha256: c8245ada5f1717ed44271ed1c26b8ce85ca3228fd2ffdb75468ab01979309d61
      url: "https://pub.dev"
    source: hosted
    version: "1.3.0"
  matcher:
    dependency: transitive
    description:
      name: matcher
      sha256: dc58c723c3c24bf8d3e2d3ad3f2f9d7bd9cf43ec6feaa64181775e60190153f2
      url: "https://pub.dev"
    source: hosted
    version: "0.12.17"
  material_color_utilities:
    dependency: transitive
    description:
      name: material_color_utilities
      sha256: f7142bb1154231d7ea5f96bc7bde4bda2a0945d2806bb11670e30b850d56bdec
      url: "https://pub.dev"
    source: hosted
    version: "0.11.1"
  meta:
    dependency: transitive
    description:
      name: meta
      sha256: "23f08335362185a5ea2ad3a4e597f1375e78bce8a040df5c600c8d3552ef2394"
      url: "https://pub.dev"
    source: hosted
    version: "1.17.0"
  mgrs_dart:
    dependency: transitive
    description:
      name: mgrs_dart
      sha256: fb89ae62f05fa0bb90f70c31fc870bcbcfd516c843fb554452ab3396f78586f7
      url: "https://pub.dev"
    source: hosted
    version: "2.0.0"
  mime:
    dependency: transitive
    description:
      name: mime
      sha256: "41a20518f0cb1256669420fdba0cd90d21561e560ac240f26ef8322e45bb7ed6"
      url: "https://pub.dev"
    source: hosted
    version: "2.0.0"
  native_toolchain_c:
    dependency: transitive
    description:
      name: native_toolchain_c
      sha256: "6ba77bb18063eebe9de401f5e6437e95e1438af0a87a3a39084fbd37c90df572"
      url: "https://pub.dev"
    source: hosted
    version: "0.17.6"
  nested:
    dependency: transitive
    description:
      name: nested
      sha256: "03bac4c528c64c95c722ec99280375a6f2fc708eec17c7b3f07253b626cd2a20"
      url: "https://pub.dev"
    source: hosted
    version: "1.0.0"
  objective_c:
    dependency: transitive
    description:
      name: objective_c
      sha256: "100a1c87616ab6ed41ec263b083c0ef3261ee6cd1dc3b0f35f8ddfa4f996fe52"
      url: "https://pub.dev"
    source: hosted
    version: "9.3.0"
  octo_image:
    dependency: transitive
    description:
      name: octo_image
      sha256: "34faa6639a78c7e3cbe79be6f9f96535867e879748ade7d17c9b1ae7536293bd"
      url: "https://pub.dev"
    source: hosted
    version: "2.1.0"
  path:
    dependency: transitive
    description:
      name: path
      sha256: "75cca69d1490965be98c73ceaea117e8a04dd21217b37b292c9ddbec0d955bc5"
      url: "https://pub.dev"
    source: hosted
    version: "1.9.1"
  path_drawing:
    dependency: transitive
    description:
      name: path_drawing
      sha256: bbb1934c0cbb03091af082a6389ca2080345291ef07a5fa6d6e078ba8682f977
      url: "https://pub.dev"
    source: hosted
    version: "1.0.1"
  path_parsing:
    dependency: transitive
    description:
      name: path_parsing
      sha256: "883402936929eac138ee0a45da5b0f2c80f89913e6dc3bf77eb65b84b409c6ca"
      url: "https://pub.dev"
    source: hosted
    version: "1.1.0"
  path_provider:
    dependency: transitive
    description:
      name: path_provider
      sha256: "50c5dd5b6e1aaf6fb3a78b33f6aa3afca52bf903a8a5298f53101fdaee55bbcd"
      url: "https://pub.dev"
    source: hosted
    version: "2.1.5"
  path_provider_android:
    dependency: transitive
    description:
      name: path_provider_android
      sha256: "149441ca6e4f38193b2e004c0ca6376a3d11f51fa5a77552d8bd4d2b0c0912ba"
      url: "https://pub.dev"
    source: hosted
    version: "2.2.23"
  path_provider_foundation:
    dependency: transitive
    description:
      name: path_provider_foundation
      sha256: "2a376b7d6392d80cd3705782d2caa734ca4727776db0b6ec36ef3f1855197699"
      url: "https://pub.dev"
    source: hosted
    version: "2.6.0"
  path_provider_linux:
    dependency: transitive
    description:
      name: path_provider_linux
      sha256: f7a1fe3a634fe7734c8d3f2766ad746ae2a2884abe22e241a8b301bf5cac3279
      url: "https://pub.dev"
    source: hosted
    version: "2.2.1"
  path_provider_platform_interface:
    dependency: transitive
    description:
      name: path_provider_platform_interface
      sha256: "88f5779f72ba699763fa3a3b06aa4bf6de76c8e5de842cf6f29e2e06476c2334"
      url: "https://pub.dev"
    source: hosted
    version: "2.1.2"
  path_provider_windows:
    dependency: transitive
    description:
      name: path_provider_windows
      sha256: bd6f00dbd873bfb70d0761682da2b3a2c2fccc2b9e84c495821639601d81afe7
      url: "https://pub.dev"
    source: hosted
    version: "2.3.0"
  petitparser:
    dependency: transitive
    description:
      name: petitparser
      sha256: "1a97266a94f7350d30ae522c0af07890c70b8e62c71e8e3920d1db4d23c057d1"
      url: "https://pub.dev"
    source: hosted
    version: "7.0.1"
  platform:
    dependency: transitive
    description:
      name: platform
      sha256: "5d6b1b0036a5f331ebc77c850ebc8506cbc1e9416c27e59b439f917a902a4984"
      url: "https://pub.dev"
    source: hosted
    version: "3.1.6"
  plugin_platform_interface:
    dependency: transitive
    description:
      name: plugin_platform_interface
      sha256: "4820fbfdb9478b1ebae27888254d445073732dae3d6ea81f0b7e06d5dedc3f02"
      url: "https://pub.dev"
    source: hosted
    version: "2.1.8"
  polylabel:
    dependency: transitive
    description:
      name: polylabel
      sha256: "41b9099afb2aa6c1730bdd8a0fab1400d287694ec7615dd8516935fa3144214b"
      url: "https://pub.dev"
    source: hosted
    version: "1.0.1"
  proj4dart:
    dependency: transitive
    description:
      name: proj4dart
      sha256: c8a659ac9b6864aa47c171e78d41bbe6f5e1d7bd790a5814249e6b68bc44324e
      url: "https://pub.dev"
    source: hosted
    version: "2.1.0"
  provider:
    dependency: "direct main"
    description:
      name: provider
      sha256: "4e82183fa20e5ca25703ead7e05de9e4cceed1fbd1eadc1ac3cb6f565a09f272"
      url: "https://pub.dev"
    source: hosted
    version: "6.1.5+1"
  pub_semver:
    dependency: transitive
    description:
      name: pub_semver
      sha256: "5bfcf68ca79ef689f8990d1160781b4bad40a3bd5e5218ad4076ddb7f4081585"
      url: "https://pub.dev"
    source: hosted
    version: "2.2.0"
  rxdart:
    dependency: transitive
    description:
      name: rxdart
      sha256: "5c3004a4a8dbb94bd4bf5412a4def4acdaa12e12f269737a5751369e12d1a962"
      url: "https://pub.dev"
    source: hosted
    version: "0.28.0"
  sky_engine:
    dependency: transitive
    description: flutter
    source: sdk
    version: "0.0.0"
  smooth_page_indicator:
    dependency: "direct main"
    description:
      name: smooth_page_indicator
      sha256: b21ebb8bc39cf72d11c7cfd809162a48c3800668ced1c9da3aade13a32cf6c1c
      url: "https://pub.dev"
    source: hosted
    version: "1.2.1"
  source_span:
    dependency: transitive
    description:
      name: source_span
      sha256: "254ee5351d6cb365c859e20ee823c3bb479bf4a293c22d17a9f1bf144ce86f7c"
      url: "https://pub.dev"
    source: hosted
    version: "1.10.1"
  sqflite:
    dependency: transitive
    description:
      name: sqflite
      sha256: e2297b1da52f127bc7a3da11439985d9b536f75070f3325e62ada69a5c585d03
      url: "https://pub.dev"
    source: hosted
    version: "2.4.2"
  sqflite_android:
    dependency: transitive
    description:
      name: sqflite_android
      sha256: "881e28efdcc9950fd8e9bb42713dcf1103e62a2e7168f23c9338d82db13dec40"
      url: "https://pub.dev"
    source: hosted
    version: "2.4.2+3"
  sqflite_common:
    dependency: transitive
    description:
      name: sqflite_common
      sha256: "6ef422a4525ecc601db6c0a2233ff448c731307906e92cabc9ba292afaae16a6"
      url: "https://pub.dev"
    source: hosted
    version: "2.5.6"
  sqflite_darwin:
    dependency: transitive
    description:
      name: sqflite_darwin
      sha256: "279832e5cde3fe99e8571879498c9211f3ca6391b0d818df4e17d9fff5c6ccb3"
      url: "https://pub.dev"
    source: hosted
    version: "2.4.2"
  sqflite_platform_interface:
    dependency: transitive
    description:
      name: sqflite_platform_interface
      sha256: "8dd4515c7bdcae0a785b0062859336de775e8c65db81ae33dd5445f35be61920"
      url: "https://pub.dev"
    source: hosted
    version: "2.4.0"
  stack_trace:
    dependency: transitive
    description:
      name: stack_trace
      sha256: "8b27215b45d22309b5cddda1aa2b19bdfec9df0e765f2de506401c071d38d1b1"
      url: "https://pub.dev"
    source: hosted
    version: "1.12.1"
  stream_channel:
    dependency: transitive
    description:
      name: stream_channel
      sha256: "969e04c80b8bcdf826f8f16579c7b14d780458bd97f56d107d3950fdbeef059d"
      url: "https://pub.dev"
    source: hosted
    version: "2.1.4"
  string_scanner:
    dependency: transitive
    description:
      name: string_scanner
      sha256: "921cd31725b72fe181906c6a94d987c78e3b98c2e205b397ea399d4054872b43"
      url: "https://pub.dev"
    source: hosted
    version: "1.4.1"
  synchronized:
    dependency: transitive
    description:
      name: synchronized
      sha256: c254ade258ec8282947a0acbbc90b9575b4f19673533ee46f2f6e9b3aeefd7c0
      url: "https://pub.dev"
    source: hosted
    version: "3.4.0"
  term_glyph:
    dependency: transitive
    description:
      name: term_glyph
      sha256: "7f554798625ea768a7518313e58f83891c7f5024f88e46e7182a4558850a4b8e"
      url: "https://pub.dev"
    source: hosted
    version: "1.2.2"
  test_api:
    dependency: transitive
    description:
      name: test_api
      sha256: ab2726c1a94d3176a45960b6234466ec367179b87dd74f1611adb1f3b5fb9d55
      url: "https://pub.dev"
    source: hosted
    version: "0.7.7"
  typed_data:
    dependency: transitive
    description:
      name: typed_data
      sha256: f9049c039ebfeb4cf7a7104a675823cd72dba8297f264b6637062516699fa006
      url: "https://pub.dev"
    source: hosted
    version: "1.4.0"
  unicode:
    dependency: transitive
    description:
      name: unicode
      sha256: "0f69e46593d65245774d4f17125c6084d2c20b4e473a983f6e21b7d7762218f1"
      url: "https://pub.dev"
    source: hosted
    version: "0.3.1"
  uuid:
    dependency: transitive
    description:
      name: uuid
      sha256: "1fef9e8e11e2991bb773070d4656b7bd5d850967a2456cfc83cf47925ba79489"
      url: "https://pub.dev"
    source: hosted
    version: "4.5.3"
  vector_math:
    dependency: transitive
    description:
      name: vector_math
      sha256: d530bd74fea330e6e364cda7a85019c434070188383e1cd8d9777ee586914c5b
      url: "https://pub.dev"
    source: hosted
    version: "2.2.0"
  vm_service:
    dependency: transitive
    description:
      name: vm_service
      sha256: "45caa6c5917fa127b5dbcfbd1fa60b14e583afdc08bfc96dda38886ca252eb60"
      url: "https://pub.dev"
    source: hosted
    version: "15.0.2"
  web:
    dependency: transitive
    description:
      name: web
      sha256: "868d88a33d8a87b18ffc05f9f030ba328ffefba92d6c127917a2ba740f9cfe4a"
      url: "https://pub.dev"
    source: hosted
    version: "1.1.1"
  wkt_parser:
    dependency: transitive
    description:
      name: wkt_parser
      sha256: "8a555fc60de3116c00aad67891bcab20f81a958e4219cc106e3c037aa3937f13"
      url: "https://pub.dev"
    source: hosted
    version: "2.0.0"
  xdg_directories:
    dependency: transitive
    description:
      name: xdg_directories
      sha256: "7a3f37b05d989967cdddcbb571f1ea834867ae2faa29725fd085180e0883aa15"
      url: "https://pub.dev"
    source: hosted
    version: "1.1.0"
  xml:
    dependency: transitive
    description:
      name: xml
      sha256: "971043b3a0d3da28727e40ed3e0b5d18b742fa5a68665cca88e74b7876d5e025"
      url: "https://pub.dev"
    source: hosted
    version: "6.6.1"
  yaml:
    dependency: transitive
    description:
      name: yaml
      sha256: b9da305ac7c39faa3f030eccd175340f968459dae4af175130b3fc47e40d76ce
      url: "https://pub.dev"
    source: hosted
    version: "3.1.3"
sdks:
  dart: ">=3.10.7 <4.0.0"
  flutter: ">=3.38.4"
```

### pubspec.yaml
`$ext
name: za2zo2a
description: "A new Flutter project."
# The following line prevents the package from being accidentally published to
# pub.dev using `flutter pub publish`. This is preferred for private packages.
publish_to: 'none' # Remove this line if you wish to publish to pub.dev

# The following defines the version and build number for your application.
# A version number is three numbers separated by dots, like 1.2.43
# followed by an optional build number separated by a +.
# Both the version and the builder number may be overridden in flutter
# build by specifying --build-name and --build-number, respectively.
# In Android, build-name is used as versionName while build-number used as versionCode.
# Read more about Android versioning at https://developer.android.com/studio/publish/versioning
# In iOS, build-name is used as CFBundleShortVersionString while build-number is used as CFBundleVersion.
# Read more about iOS versioning at
# https://developer.apple.com/library/archive/documentation/General/Reference/InfoPlistKeyReference/Articles/CoreFoundationKeys.html
# In Windows, build-name is used as the major, minor, and patch parts
# of the product and file versions while build-number is used as the build suffix.
version: 1.0.0+1

environment:
  sdk: ^3.10.7

# Dependencies specify other packages that your package needs in order to work.
# To automatically upgrade your package dependencies to the latest versions
# consider running `flutter pub upgrade --major-versions`. Alternatively,
# dependencies can be manually updated by changing the version numbers below to
# the latest version available on pub.dev. To see which dependencies have newer
# versions available, run `flutter pub outdated`.
dependencies:
  flutter:
    sdk: flutter
  firebase_core: ^2.8.0
  firebase_auth: ^4.6.0
  provider: ^6.0.5
  flutter_svg: ^1.1.6   # Ù„Ùˆ ÙÙŠ Ø£ÙŠ Ø£ÙŠÙ‚ÙˆÙ†Ø§Øª SVG


  # The following adds the Cupertino Icons font to your application.
  # Use with the CupertinoIcons class for iOS style icons.
  cupertino_icons: ^1.0.8
  flutter_bloc: ^8.1.3
  go_router: ^14.6.2
  dio: ^5.7.0
  google_fonts: ^6.2.1
  flutter_rating_bar: ^4.0.1
  smooth_page_indicator: ^1.1.0
  equatable: ^2.0.5
  flutter_screenutil: ^5.9.3
  font_awesome_flutter: ^11.0.0
  image_picker: ^1.2.1
  geolocator: ^10.1.0
  geocoding: ^4.0.0
  flutter_map: ^6.0.0
  latlong2: ^0.9.0
  cached_network_image: ^3.4.1

dev_dependencies:
  flutter_test:
    sdk: flutter

  # The "flutter_lints" package below contains a set of recommended lints to
  # encourage good coding practices. The lint set provided by the package is
  # activated in the `analysis_options.yaml` file located at the root of your
  # package. See that file for information about deactivating specific lint
  # rules and activating additional ones.
  flutter_lints: ^6.0.0

# For information on the generic Dart part of this file, see the
# following page: https://dart.dev/tools/pub/pubspec

# The following section is specific to Flutter packages.
flutter:

  # The following line ensures that the Material Icons font is
  # included with your application, so that you can use the icons in
  # the material Icons class.
  uses-material-design: true

  # To add assets to your application, add an assets section, like this:
  # assets:
  #   - images/a_dot_ham.jpeg
  #   - images/a_dot_ham.jpeg

  # An image asset can refer to one or more resolution-specific "variants", see
  # https://flutter.dev/to/resolution-aware-images

  # For details regarding adding assets from package dependencies, see
  # https://flutter.dev/to/asset-from-package

  # To add custom fonts to your application, add a fonts section here,
  # in this "flutter" section. Each entry in this list should have a
  # "family" key with the font family name, and a "fonts" key with a
  # list giving the asset and other descriptors for the font. For
  # example:
  # fonts:
  #   - family: Schyler
  #     fonts:
  #       - asset: fonts/Schyler-Regular.ttf
  #       - asset: fonts/Schyler-Italic.ttf
  #         style: italic
  #   - family: Trajan Pro
  #     fonts:
  #       - asset: fonts/TrajanPro.ttf
  #       - asset: fonts/TrajanPro_Bold.ttf
  #         weight: 700
  #
  # For details regarding fonts from package dependencies,
  # see https://flutter.dev/to/font-from-package
```


