import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:go_router/go_router.dart';
import 'package:latlong2/latlong.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/network/api_error.dart';
import '../../../../injection_container.dart';
import '../../../trip/data/models/trip_models.dart';
import '../../../trip/data/repos/trip_repo.dart';
import '../cubit/home_cubit.dart';
import '../cubit/home_state.dart';
import '../widgets/home_bottom_sheet.dart';
import '../widgets/home_map_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  final _searchController = TextEditingController();
  final _mapController = MapController();
  LatLng _currentCenter = const LatLng(30.0444, 31.2357);
  double _currentZoom = AppConstants.initialMapZoom;
  String? _animatedPlaceKey;
  AnimationController? _animationController;

  @override
  void dispose() {
    _animationController?.dispose();
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _showLocationDialog() async {
    await showDialog<void>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text(AppStrings.locationAccessTitle),
        content: const Text(AppStrings.locationDeniedMessage),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(),
            child: const Text(AppStrings.retry),
          ),
          TextButton(
            onPressed: () async {
              Navigator.of(dialogContext).pop();
              await Geolocator.openAppSettings();
            },
            child: const Text(AppStrings.openSettings),
          ),
        ],
      ),
    );
  }

  void _safeMoveMap(LatLng target, double zoom) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) {
        return;
      }
      try {
        _mapController.move(target, zoom);
      } catch (_) {}
    });
  }

  void _animateTo(LatLng target, double zoom) {
    _animationController?.dispose();
    _animationController = AnimationController(
      vsync: this,
      duration: AppConstants.mapAnimationDuration,
    );
    final latTween = Tween(
      begin: _currentCenter.latitude,
      end: target.latitude,
    );
    final lngTween = Tween(
      begin: _currentCenter.longitude,
      end: target.longitude,
    );
    final zoomTween = Tween(begin: _currentZoom, end: zoom);

    _animationController!.addListener(() {
      final nextCenter = LatLng(
        latTween.evaluate(_animationController!),
        lngTween.evaluate(_animationController!),
      );
      final nextZoom = zoomTween.evaluate(_animationController!);
      _currentCenter = nextCenter;
      _currentZoom = nextZoom;
      _safeMoveMap(nextCenter, nextZoom);
    });
    _animationController!.forward();
  }

  void _handleQuickChip(String label) {
    _searchController.text = label;
    _searchController.selection = TextSelection.fromPosition(
      TextPosition(offset: label.length),
    );
    setState(() {});
    context.read<HomeCubit>().onSearchChanged(label);
  }

  bool _requesting = false;

  Future<void> _handleRequestRide(HomeState state) async {
    if (state.selectedLocation == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text(AppStrings.noDestinationAvailable)),
      );
      return;
    }
    if (state.userLocation == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text(AppStrings.rideStartUnavailable)),
      );
      return;
    }
    // Guard against double-request while POST /api/trips is in flight.
    if (_requesting) return;
    _requesting = true;

    final origin = state.userLocation!;
    final dest = state.selectedLocation!;
    showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (_) => const Center(child: CircularProgressIndicator()),
    );

    try {
      final trip = await sl<TripRepo>().requestTrip(
        origin: GeoPoint(lat: origin.latitude, lng: origin.longitude),
        destination: GeoPoint(
          lat: dest.latitude,
          lng: dest.longitude,
          address: state.query.trim().isEmpty ? null : state.query.trim(),
        ),
      );
      if (!mounted) return;
      Navigator.of(context, rootNavigator: true).pop(); // dismiss loader
      context.go('/trip/${trip.id}');
    } on ApiError catch (e) {
      if (!mounted) return;
      Navigator.of(context, rootNavigator: true).pop();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.message), backgroundColor: AppColors.error),
      );
    } finally {
      _requesting = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.sizeOf(context).height;

    return BlocConsumer<HomeCubit, HomeState>(
      listener: (context, state) async {
        if (state is HomeLocationLoaded) {
          _currentCenter = state.userLocation!;
          if (state.selectedLocation == null) {
            _safeMoveMap(state.userLocation!, AppConstants.initialMapZoom);
          }
        }

        if (state is HomeSearchError) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: Text(state.message),
                action: SnackBarAction(
                  label: AppStrings.retry,
                  onPressed: context.read<HomeCubit>().retrySearch,
                ),
              ),
            );
        }

        if (state is HomeLocationError && state.openSettings) {
          await _showLocationDialog();
        }

        final selected = state.selectedLocation;
        final key = selected == null
            ? null
            : '${selected.latitude}_${selected.longitude}';
        if (selected != null && key != _animatedPlaceKey) {
          _animatedPlaceKey = key;
          _animateTo(selected, AppConstants.initialMapZoom);
        }
      },
      builder: (context, state) {
        if (_searchController.text != state.query) {
          _searchController.text = state.query;
          _searchController.selection = TextSelection.fromPosition(
            TextPosition(offset: _searchController.text.length),
          );
        }

        return LayoutBuilder(
          builder: (context, constraints) {
            final isTablet =
                constraints.maxWidth >= AppConstants.tabletBreakpoint;
            final userLocation = state.userLocation ?? _currentCenter;
            final mapHeight = screenHeight * AppConstants.homeMapHeightFactor;
            final map = SizedBox(
              height: isTablet ? double.infinity : mapHeight,
              child: HomeMapWidget(
                mapController: _mapController,
                userLocation: userLocation,
                selectedLocation: state.selectedLocation,
              ),
            );
            final sheet = HomeBottomSheet(
              isTablet: isTablet,
              controller: _searchController,
              isSearchLoading: state is HomeSearchLoading,
              isSearchEmpty: state is HomeSearchEmpty,
              showResults: state.query.trim().isNotEmpty,
              results: state.results,
              onChanged: context.read<HomeCubit>().onSearchChanged,
              onClear: () {
                _searchController.clear();
                setState(() {});
                context.read<HomeCubit>().onSearchChanged('');
              },
              onPlaceSelected: (place) {
                _searchController.text = place.placeName;
                context.read<HomeCubit>().selectPlace(place);
              },
              onQuickChipSelected: _handleQuickChip,
              onRequestRide: () => _handleRequestRide(state),
            );

            return Scaffold(
              backgroundColor: AppColors.background,
              body: SafeArea(
                child: isTablet
                    ? Row(
                        children: [
                          Expanded(flex: 55, child: map),
                          Expanded(flex: 45, child: sheet),
                        ],
                      )
                    : Column(
                        children: [
                          map,
                          Expanded(child: sheet),
                        ],
                      ),
              ),
            );
          },
        );
      },
    );
  }
}
