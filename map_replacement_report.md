# Map Replacement Report

## Old Map Files Found
- lib/features/home/views/home_view.dart
- lib/features/driver/driver_home/views/driver_home_view.dart
- lib/features/ride/views/ride_selection_view.dart
- lib/features/ride/views/active_trip_view.dart
- lib/features/ride/views/finding_driver_view.dart
- lib/features/driver/driver_trip/views/driver_active_trip_view.dart
- lib/features/map/view/map_screen.dart
- lib/features/map/view_model/map_cubit.dart
- lib/features/map/view_model/map_state.dart
- lib/features/map/view/widgets/map_marker_widget.dart
- lib/features/map/model/route_model.dart

## Deleted Legacy Map Files
- lib/features/map/view/map_screen.dart
- lib/features/map/view_model/map_cubit.dart
- lib/features/map/view_model/map_state.dart
- lib/features/map/view/widgets/map_marker_widget.dart
- lib/features/map/model/route_model.dart

## Verification
- flutter pub get: succeeded
- flutter analyze: no issues found
- flutter test: passed
- flutter build apk --debug: succeeded
- old map scan: no legacy map imports or old map files remain in lib/

## Full Updated File Contents

### pubspec.yaml
```yaml
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

### android/app/build.gradle.kts
```kts
plugins {
    id("com.android.application")
    // START: FlutterFire Configuration
    id("com.google.gms.google-services")
    // END: FlutterFire Configuration
    id("kotlin-android")
    // The Flutter Gradle Plugin must be applied after the Android and Kotlin Gradle plugins.
    id("dev.flutter.flutter-gradle-plugin")
}

android {
    namespace = "com.example.flutter_tasks_mostafa"
    compileSdk = flutter.compileSdkVersion
    ndkVersion = flutter.ndkVersion

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_17
        targetCompatibility = JavaVersion.VERSION_17
    }

    kotlinOptions {
        jvmTarget = JavaVersion.VERSION_17.toString()
    }

    defaultConfig {
        // TODO: Specify your own unique Application ID (https://developer.android.com/studio/build/application-id.html).
        applicationId = "com.example.flutter_tasks_mostafa"
        // You can update the following values to match your application needs.
        // For more information, see: https://flutter.dev/to/review-gradle-config.
        minSdk = flutter.minSdkVersion
        targetSdk = flutter.targetSdkVersion
        versionCode = flutter.versionCode
        versionName = flutter.versionName
    }

    buildTypes {
        release {
            // TODO: Add your own signing config for the release build.
            // Signing with the debug keys for now, so `flutter run --release` works.
            signingConfig = signingConfigs.getByName("debug")
        }
    }
}

flutter {
    source = "../.."
}
```

### android/app/src/main/AndroidManifest.xml
```xml
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
```plist
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
```dart
import 'package:flutter_bloc/flutter_bloc.dart';
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
import '../../features/map/domain/usecases/get_user_location_use_case.dart';
import '../../features/map/presentation/view/map_view.dart';
import '../../features/map/presentation/viewmodel/map_cubit.dart';

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
      GoRoute(
        path: '/map',
        builder: (context, state) => BlocProvider(
          create: (context) =>
              MapCubit(getUserLocationUseCase: const GetUserLocationUseCase())
                ..initMap(),
          child: const MapView(),
        ),
      ),
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

### lib/features/home/views/home_view.dart
```dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:latlong2/latlong.dart';

import '../../map/domain/usecases/get_user_location_use_case.dart';
import '../../map/presentation/view/map_view.dart';
import '../../map/presentation/viewmodel/map_cubit.dart';
import '../cubit/home_cubit.dart';
import '../cubit/home_state.dart';
import 'widgets/app_drawer.dart';
import 'widgets/where_to_sheet.dart';
import 'widgets/destination_sheet.dart';
import 'widgets/home_top_bar.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  late final MapCubit _mapCubit;

  @override
  void initState() {
    super.initState();
    _mapCubit = MapCubit(getUserLocationUseCase: const GetUserLocationUseCase())
      ..initMap();
  }

  @override
  void dispose() {
    _mapCubit.close();
    super.dispose();
  }

  void _onGpsTap(LatLng? coords) {
    final target = coords ?? _mapCubit.lastLoadedState?.userLocation;

    if (target != null) {
      _mapCubit.moveToLocation(target);
    } else {
      _mapCubit.initMap();
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        if (state is HomeLoading || state is HomeInitial) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        final bool hasDest =
            state is HomeLoaded &&
            state.selectedDestination != null &&
            state.selectedDestination!.isNotEmpty;

        return BlocProvider.value(
          value: _mapCubit,
          child: Scaffold(
            key: _scaffoldKey,
            drawer: const AppDrawer(),
            body: Stack(
              children: [
                const Positioned.fill(child: MapView.embedded()),
                HomeTopBar(
                  scaffoldKey: _scaffoldKey,
                  onGpsTap: () => _onGpsTap(
                    state is HomeLoaded ? state.currentLocationCoords : null,
                  ),
                ),
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: hasDest
                      ? DestinationSheet(state: state)
                      : const WhereToSheet(),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
```

### lib/features/driver/driver_home/views/driver_home_view.dart
```dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:latlong2/latlong.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/utils/responsive.dart';
import '../../../../features/map/domain/usecases/get_user_location_use_case.dart';
import '../../../../features/map/presentation/view/map_view.dart';
import '../../../../features/map/presentation/viewmodel/map_cubit.dart';
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
  late final MapCubit _mapCubit;

  @override
  void initState() {
    super.initState();
    _mapCubit = MapCubit(getUserLocationUseCase: const GetUserLocationUseCase())
      ..initMap();
  }

  @override
  void dispose() {
    _mapCubit.close();
    super.dispose();
  }

  void _onGpsTap(LatLng? coords) {
    final target = coords ?? _mapCubit.lastLoadedState?.userLocation;

    if (target != null) {
      _mapCubit.moveToLocation(target);
    } else {
      _mapCubit.initMap();
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
              : BlocProvider.value(
                  value: _mapCubit,
                  child: _buildOfflineOrWaitingView(context, state, isOnline),
                ),
          bottomNavigationBar: const DriverBottomNav(),
        );
      },
    );
  }

  Widget _buildOfflineOrWaitingView(
    BuildContext context,
    DriverHomeState state,
    bool isOnline,
  ) {
    return Stack(
      children: [
        const Positioned.fill(child: MapView.embedded()),
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

### lib/features/ride/views/ride_selection_view.dart
```dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/utils/responsive.dart';
import '../../map/domain/usecases/get_user_location_use_case.dart';
import '../../map/presentation/view/map_view.dart';
import '../../map/presentation/viewmodel/map_cubit.dart';
import '../cubit/ride_cubit.dart';
import '../cubit/ride_state.dart';
import 'widgets/ride_selection_sheet.dart';

class RideSelectionView extends StatefulWidget {
  const RideSelectionView({super.key});

  @override
  State<RideSelectionView> createState() => _RideSelectionViewState();
}

class _RideSelectionViewState extends State<RideSelectionView> {
  late final MapCubit _mapCubit;

  @override
  void initState() {
    super.initState();
    _mapCubit = MapCubit(getUserLocationUseCase: const GetUserLocationUseCase())
      ..initMap();
    context.read<RideCubit>().fetchRideOptions();
  }

  @override
  void dispose() {
    _mapCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RideCubit, RideState>(
      listener: (context, state) {
        if (state is RideActive) {
          context.push('/home/finding-driver');
        }
      },
      builder: (context, state) {
        return BlocProvider.value(
          value: _mapCubit,
          child: Scaffold(
            body: Stack(
              children: [
                const Positioned.fill(child: MapView.embedded()),
                SafeArea(
                  child: Padding(
                    padding: EdgeInsets.all(context.widthPct(16)),
                    child: CircleAvatar(
                      backgroundColor: Colors.white,
                      child: IconButton(
                        icon: Icon(
                          Icons.arrow_back,
                          color: AppColors.textPrimary,
                        ),
                        onPressed: () => context.pop(),
                      ),
                    ),
                  ),
                ),
                RideSelectionSheet(state: state),
              ],
            ),
          ),
        );
      },
    );
  }
}
```

### lib/features/ride/views/active_trip_view.dart
```dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../map/domain/usecases/get_user_location_use_case.dart';
import '../../map/presentation/view/map_view.dart';
import '../../map/presentation/viewmodel/map_cubit.dart';
import '../cubit/ride_cubit.dart';
import '../cubit/ride_state.dart';

import 'widgets/active_trip_app_bar.dart';
import 'widgets/active_trip_next_turn.dart';
import 'widgets/active_trip_map_controls.dart';
import 'widgets/active_trip_details_sheet.dart';

class ActiveTripView extends StatefulWidget {
  const ActiveTripView({super.key});

  @override
  State<ActiveTripView> createState() => _ActiveTripViewState();
}

class _ActiveTripViewState extends State<ActiveTripView> {
  late final MapCubit _mapCubit;

  @override
  void initState() {
    super.initState();
    _mapCubit = MapCubit(getUserLocationUseCase: const GetUserLocationUseCase())
      ..initMap();
  }

  @override
  void dispose() {
    _mapCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RideCubit, RideState>(
      listener: (context, state) {
        if (state is RideCompleted) {
          context.pushReplacement('/home/trip-summary');
        } else if (state is RideInitial) {
          context.go('/home');
        }
      },
      builder: (context, state) {
        if (state is! RideActive) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        final ride = state.activeRide;

        return Scaffold(
          body: BlocProvider.value(
            value: _mapCubit,
            child: Stack(
              children: [
                const Positioned.fill(child: MapView.embedded()),
                const ActiveTripAppBar(),
                const ActiveTripNextTurn(),
                ActiveTripMapControls(
                  onLocationPressed: () {
                    final userLocation =
                        _mapCubit.lastLoadedState?.userLocation;

                    if (userLocation != null) {
                      _mapCubit.moveToLocation(userLocation);
                    } else {
                      _mapCubit.initMap();
                    }
                  },
                ),
                ActiveTripDetailsSheet(ride: ride),
              ],
            ),
          ),
        );
      },
    );
  }
}
```

### lib/features/ride/views/finding_driver_view.dart
```dart
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/constants/app_colors.dart';
import '../../../../../core/constants/app_text_styles.dart';
import '../../../../../core/utils/responsive.dart';
import '../../map/domain/usecases/get_user_location_use_case.dart';
import '../../map/presentation/view/map_view.dart';
import '../../map/presentation/viewmodel/map_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
  late final MapCubit _mapCubit;

  @override
  void initState() {
    super.initState();
    _mapCubit = MapCubit(getUserLocationUseCase: const GetUserLocationUseCase())
      ..initMap();
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

  @override
  void dispose() {
    _controller.dispose();
    _mapCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider.value(
        value: _mapCubit,
        child: Stack(
          children: [
            const Positioned.fill(child: MapView.embedded()),
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
                                  color: AppColors.primary.withValues(
                                    alpha: 0.5,
                                  ),
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
      ),
    );
  }
}
```

### lib/features/driver/driver_trip/views/driver_active_trip_view.dart
```dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../map/domain/usecases/get_user_location_use_case.dart';
import '../../../map/presentation/view/map_view.dart';
import '../../../map/presentation/viewmodel/map_cubit.dart';
import '../cubit/driver_trip_cubit.dart';
import '../cubit/driver_trip_state.dart';

import 'widgets/driver_active_trip_app_bar.dart';
import 'widgets/driver_active_trip_next_turn.dart';
import 'widgets/driver_active_trip_controls.dart';
import 'widgets/driver_active_trip_sheet.dart';

class DriverActiveTripView extends StatefulWidget {
  const DriverActiveTripView({super.key});

  @override
  State<DriverActiveTripView> createState() => _DriverActiveTripViewState();
}

class _DriverActiveTripViewState extends State<DriverActiveTripView> {
  late final MapCubit _mapCubit;

  @override
  void initState() {
    super.initState();
    _mapCubit = MapCubit(getUserLocationUseCase: const GetUserLocationUseCase())
      ..initMap();
  }

  @override
  void dispose() {
    _mapCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DriverTripCubit, DriverTripState>(
      listener: (context, state) {
        if (state is DriverTripCompleted) {
          context.pushReplacement('/driver/trip-summary');
        }
        if (state is DriverTripInitial) {
          context.go('/driver/home');
        }
      },
      builder: (context, state) {
        final bool isHeadingToPickup = state is DriverHeadingToPickup;

        return Scaffold(
          backgroundColor: const Color(0xFF1C2B39),
          body: BlocProvider.value(
            value: _mapCubit,
            child: Stack(
              children: [
                const Positioned.fill(child: MapView.embedded()),
                const DriverActiveTripAppBar(),
                const DriverActiveTripNextTurn(),
                DriverActiveTripControls(
                  onLocationPressed: () {
                    final userLocation =
                        _mapCubit.lastLoadedState?.userLocation;

                    if (userLocation != null) {
                      _mapCubit.moveToLocation(userLocation);
                    } else {
                      _mapCubit.initMap();
                    }
                  },
                ),
                DriverActiveTripSheet(isHeadingToPickup: isHeadingToPickup),
              ],
            ),
          ),
        );
      },
    );
  }
}
```

### lib/features/map/map_constants.dart
```dart
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

### lib/features/map/data/models/map_location_model.dart
```dart
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
```dart
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

### lib/features/map/presentation/viewmodel/map_state.dart
```dart
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

### lib/features/map/presentation/viewmodel/map_cubit.dart
```dart
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
      moveToLocation(userLocation);
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

### lib/features/map/presentation/view/map_view.dart
```dart
import 'package:flutter/material.dart';
import 'widgets/map_view_content.dart';

class MapView extends StatelessWidget {
  final bool showScaffold;
  final bool showSearchBar;
  final bool showLocationDetails;
  final bool showMapControls;
  final bool allowMarkerCreation;

  const MapView({
    super.key,
    this.showScaffold = true,
    this.showSearchBar = true,
    this.showLocationDetails = true,
    this.showMapControls = true,
    this.allowMarkerCreation = true,
  });

  const MapView.embedded({
    super.key,
    this.showScaffold = false,
    this.showSearchBar = false,
    this.showLocationDetails = false,
    this.showMapControls = false,
    this.allowMarkerCreation = false,
  });

  @override
  Widget build(BuildContext context) {
    return MapViewContent(
      showScaffold: showScaffold,
      showSearchBar: showSearchBar,
      showLocationDetails: showLocationDetails,
      showMapControls: showMapControls,
      allowMarkerCreation: allowMarkerCreation,
    );
  }
}
```

### lib/features/map/presentation/view/widgets/map_canvas.dart
```dart
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
  final bool allowMarkerCreation;
  final ValueChanged<MapLocationModel> onMarkerSelected;
  final ValueChanged<LatLng> onMapTap;
  final VoidCallback onUserLocationSelected;
  final void Function(MapPosition position, bool hasGesture) onPositionChanged;

  const MapCanvas({
    super.key,
    required this.state,
    required this.selectedMarkerId,
    required this.mapController,
    required this.allowMarkerCreation,
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
        onTap: allowMarkerCreation
            ? (tapPosition, point) => onMapTap(point)
            : null,
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
```dart
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
```dart
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
```dart
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
```dart
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
  final bool showSearchBar;
  final bool showMapControls;
  final bool allowMarkerCreation;
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
    required this.showSearchBar,
    required this.showMapControls,
    required this.allowMarkerCreation,
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
            allowMarkerCreation: allowMarkerCreation,
            onMarkerSelected: onMarkerSelected,
            onMapTap: onMapTap,
            onPositionChanged: onPositionChanged,
            onUserLocationSelected: onUserLocationSelected,
          ),
        ),
        if (showSearchBar)
          const Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: SafeArea(
              bottom: false,
              child: Padding(
                padding: EdgeInsets.all(16),
                child: MapSearchBar(),
              ),
            ),
          ),
        if (showMapControls)
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
```dart
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
```dart
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
```dart
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
```dart
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
```dart
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
  final bool showSearchBar;
  final bool showMapControls;
  final bool allowMarkerCreation;
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
    required this.showSearchBar,
    required this.showMapControls,
    required this.allowMarkerCreation,
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
          showSearchBar: showSearchBar,
          showMapControls: showMapControls,
          allowMarkerCreation: allowMarkerCreation,
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
```dart
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
```dart
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
  final bool showSearchBar;
  final bool showMapControls;
  final bool allowMarkerCreation;
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
    required this.showSearchBar,
    required this.showMapControls,
    required this.allowMarkerCreation,
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
            showSearchBar: showSearchBar,
            showMapControls: showMapControls,
            allowMarkerCreation: allowMarkerCreation,
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
```dart
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
import 'map_interactive_pane.dart';
import 'map_loading_overlay.dart';
import 'map_mobile_layout.dart';
import 'map_tablet_layout.dart';

class MapViewContent extends StatefulWidget {
  final bool showScaffold;
  final bool showSearchBar;
  final bool showLocationDetails;
  final bool showMapControls;
  final bool allowMarkerCreation;

  const MapViewContent({
    super.key,
    required this.showScaffold,
    required this.showSearchBar,
    required this.showLocationDetails,
    required this.showMapControls,
    required this.allowMarkerCreation,
  });

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

  Widget _wrapContent(Widget child) {
    if (!widget.showScaffold) {
      return child;
    }

    return Scaffold(body: child);
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
          return _wrapContent(
            SafeArea(
              child: MapEmptyState(
                title: MapConstants.mapUnavailableTitle,
                description: state.message,
                onRetry: context.read<MapCubit>().initMap,
              ),
            ),
          );
        }

        return _wrapContent(
          LayoutBuilder(
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
              final content = widget.showLocationDetails
                  ? context.isMobile
                        ? MapMobileLayout(
                            state: mapState,
                            selectedMarker: selectedMarker,
                            mapController: _mapController,
                            showSearchBar: widget.showSearchBar,
                            showMapControls: widget.showMapControls,
                            allowMarkerCreation: widget.allowMarkerCreation,
                            onMapTap: _handleMapTap,
                            onPositionChanged: _handlePositionChanged,
                            onUserLocationSelected: () =>
                                _handleUserLocationSelected(mapState),
                            onMarkerSelected: _handleMarkerSelected,
                            onCenterOnUserLocation: () => context
                                .read<MapCubit>()
                                .moveToLocation(mapState.userLocation),
                            onZoomIn: () => _handleZoom(MapConstants.zoomStep),
                            onZoomOut: () =>
                                _handleZoom(-MapConstants.zoomStep),
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
                            showSearchBar: widget.showSearchBar,
                            showMapControls: widget.showMapControls,
                            allowMarkerCreation: widget.allowMarkerCreation,
                            onMapTap: _handleMapTap,
                            onPositionChanged: _handlePositionChanged,
                            onUserLocationSelected: () =>
                                _handleUserLocationSelected(mapState),
                            onMarkerSelected: _handleMarkerSelected,
                            onCenterOnUserLocation: () => context
                                .read<MapCubit>()
                                .moveToLocation(mapState.userLocation),
                            onZoomIn: () => _handleZoom(MapConstants.zoomStep),
                            onZoomOut: () =>
                                _handleZoom(-MapConstants.zoomStep),
                            onClearMarkers: () {
                              setState(() {
                                _selectedMarkerId = null;
                              });
                              context.read<MapCubit>().clearMarkers();
                            },
                          )
                  : MapInteractivePane(
                      state: mapState,
                      selectedMarkerId: selectedMarker?.id,
                      mapController: _mapController,
                      bottomInset: 16,
                      showSearchBar: widget.showSearchBar,
                      showMapControls: widget.showMapControls,
                      allowMarkerCreation: widget.allowMarkerCreation,
                      onMarkerSelected: _handleMarkerSelected,
                      onMapTap: _handleMapTap,
                      onPositionChanged: _handlePositionChanged,
                      onUserLocationSelected: () =>
                          _handleUserLocationSelected(mapState),
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

