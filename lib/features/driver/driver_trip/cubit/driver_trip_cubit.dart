import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:latlong2/latlong.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../driver_trip/domain/usecases/get_driver_route_usecase.dart';
import '../data/models/driver_trip_model.dart';
import '../data/repos/driver_trip_repo.dart';
import 'driver_trip_state.dart';

class DriverTripCubit extends Cubit<DriverTripState> {
  final DriverTripRepo _repo;
  final GetDriverRouteUsecase? _getDriverRouteUsecase;
  Timer? _refreshTimer;
  Timer? _retryTimer;
  double _progressSeed = 0;

  DriverTripCubit(this._repo, [this._getDriverRouteUsecase])
      : super(DriverTripInitial());

  /// Called once a ride request is accepted – driver heads to pickup.
  void startHeadingToPickup(DriverTripModel trip) {
    _progressSeed = 0;
    emit(DriverHeadingToPickup(trip: trip));
    _startRouteTracking();
  }

  /// Called when driver arrives at pickup and confirms rider is on board.
  void startTrip() {
    if (state is DriverHeadingToPickup) {
      final trip = (state as DriverHeadingToPickup).trip;
      _progressSeed = 0;
      emit(DriverTripInProgress(trip: trip));
      _startRouteTracking();
    }
  }

  /// Start periodic route fetching
  void _startRouteTracking() {
    _refreshTimer?.cancel();
    _retryTimer?.cancel();
    _fetchRoute();
    _refreshTimer = Timer.periodic(
      AppConstants.routeRefreshInterval,
      (_) => _fetchRoute(),
    );
  }

  /// Fetch route from OSRM for the current phase
  Future<void> _fetchRoute() async {
    if (_getDriverRouteUsecase == null) return;

    LatLng? origin;
    LatLng? destination;
    DriverTripModel? trip;

    if (state is DriverHeadingToPickup) {
      final s = state as DriverHeadingToPickup;
      trip = s.trip;
      // Driver's simulated current location → pickup
      final pickupTarget = LatLng(trip.pickupLat, trip.pickupLng);
      // Simulate driver moving towards pickup
      origin = _interpolate(
        LatLng(trip.pickupLat - 0.012, trip.pickupLng - 0.008),
        pickupTarget,
        _progressSeed,
      );
      destination = pickupTarget;
    } else if (state is DriverTripInProgress) {
      final s = state as DriverTripInProgress;
      trip = s.trip;
      // Pickup → destination
      final pickupPoint = LatLng(trip.pickupLat, trip.pickupLng);
      final destPoint = LatLng(trip.destinationLat, trip.destinationLng);
      origin = _interpolate(pickupPoint, destPoint, _progressSeed);
      destination = destPoint;
    }

    if (origin == null || destination == null || trip == null) return;

    try {
      final route = await _getDriverRouteUsecase(
        origin: origin,
        destination: destination,
      );

      final etaStr = _formatEta(route.durationSeconds);
      final distToTurn = _formatDistanceToTurn(route.distanceToTurnMeters);

      if (state is DriverHeadingToPickup) {
        emit((state as DriverHeadingToPickup).copyWithRoute(
          route: route,
          turnInstruction: route.turnInstruction,
          distanceToTurn: distToTurn,
          eta: etaStr,
        ));
      } else if (state is DriverTripInProgress) {
        emit((state as DriverTripInProgress).copyWithRoute(
          route: route,
          turnInstruction: route.turnInstruction,
          distanceToTurn: distToTurn,
          eta: etaStr,
        ));
      }

      _progressSeed = (_progressSeed + 0.12).clamp(0.0, 0.85);
    } on DioException {
      _handleRouteFailure();
    } catch (_) {
      _handleRouteFailure();
    }
  }

  void _handleRouteFailure() {
    _refreshTimer?.cancel();
    _retryTimer?.cancel();
    _retryTimer = Timer(AppConstants.routeRetryDelay, () {
      _fetchRoute();
      if (state is! DriverTripCompleted && state is! DriverTripInitial) {
        _refreshTimer = Timer.periodic(
          AppConstants.routeRefreshInterval,
          (_) => _fetchRoute(),
        );
      }
    });
  }

  /// Open Google Maps to navigate to the current target
  Future<bool> navigateToTarget() async {
    LatLng? target;
    if (state is DriverHeadingToPickup) {
      target = (state as DriverHeadingToPickup).targetLocation;
    } else if (state is DriverTripInProgress) {
      target = (state as DriverTripInProgress).targetLocation;
    }

    if (target == null) return false;

    final uri = Uri.parse(
      'https://www.google.com/maps/dir/?api=1'
      '&destination=${target.latitude},${target.longitude}'
      '&travelmode=driving',
    );
    return launchUrl(uri, mode: LaunchMode.externalApplication);
  }

  /// Called when driver arrives at destination and ends the trip.
  Future<void> completeTrip() async {
    _refreshTimer?.cancel();
    _retryTimer?.cancel();
    if (state is DriverTripInProgress) {
      final trip = (state as DriverTripInProgress).trip;
      try {
        await _repo.completeTrip(trip.id, trip.fare);
        final completedTrip = DriverTripModel(
          id: trip.id,
          riderName: trip.riderName,
          riderPhoto: trip.riderPhoto,
          riderRating: trip.riderRating,
          pickupAddress: trip.pickupAddress,
          destinationAddress: trip.destinationAddress,
          distanceKm: trip.distanceKm,
          durationMinutes: trip.durationMinutes,
          fare: trip.fare,
          paymentMethod: trip.paymentMethod,
          rideType: trip.rideType,
          status: 'completed',
          createdAt: trip.createdAt,
          pickupLat: trip.pickupLat,
          pickupLng: trip.pickupLng,
          destinationLat: trip.destinationLat,
          destinationLng: trip.destinationLng,
        );
        emit(DriverTripCompleted(completedTrip));
      } catch (e) {
        emit(
          const DriverTripError(
            'Failed to complete the trip. Please try again.',
          ),
        );
      }
    }
  }

  /// Load driver trip history.
  Future<void> loadTripHistory() async {
    emit(DriverTripLoading());
    try {
      final trips = await _repo.getTripHistory();
      emit(DriverTripHistoryLoaded(trips));
    } catch (e) {
      emit(const DriverTripError('Failed to load trip history.'));
    }
  }

  /// Submit rating for the rider after trip is done.
  Future<void> submitRiderRating(
    String tripId,
    double rating,
    String? comment,
  ) async {
    try {
      await _repo.submitRiderRating(tripId, rating, comment);
    } catch (_) {
      // Non-critical: silent fail
    }
  }

  /// Reset trip state (back to home screen).
  void reset() {
    _refreshTimer?.cancel();
    _retryTimer?.cancel();
    emit(DriverTripInitial());
  }

  String _formatEta(double durationSeconds) {
    final minutes = (durationSeconds / 60).ceil().clamp(1, 99);
    return '$minutes ${AppStrings.minuteShort}';
  }

  String _formatDistanceToTurn(double meters) {
    return '${meters.round()} ${AppStrings.meterSuffix}';
  }

  LatLng _interpolate(LatLng start, LatLng end, double t) {
    return LatLng(
      start.latitude + ((end.latitude - start.latitude) * t),
      start.longitude + ((end.longitude - start.longitude) * t),
    );
  }

  @override
  Future<void> close() {
    _refreshTimer?.cancel();
    _retryTimer?.cancel();
    return super.close();
  }
}
