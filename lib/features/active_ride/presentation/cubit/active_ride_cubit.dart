import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:latlong2/latlong.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../core/constants/app_strings.dart';
import '../../domain/entities/driver_info_entity.dart';
import '../../domain/usecases/get_driver_info_usecase.dart';
import '../../domain/usecases/get_route_usecase.dart';
import 'active_ride_state.dart';

class ActiveRideCubit extends Cubit<ActiveRideState> {
  final GetRouteUsecase _getRouteUsecase;
  final GetDriverInfoUsecase _getDriverInfoUsecase;
  final DriverInfoEntity _driverInfo;
  final LatLng _defaultOrigin = const LatLng(37.7956, -122.3937);
  final LatLng _defaultDestination = const LatLng(37.8087, -122.4098);
  Timer? _refreshTimer;
  Timer? _retryTimer;
  double _progressSeed = 0;
  double? _initialDistanceMeters;
  String? _rideId;
  LatLng? _origin;
  LatLng? _destination;
  ActiveRideInProgress? _lastSnapshot;

  ActiveRideCubit(this._getRouteUsecase, this._getDriverInfoUsecase)
    : _driverInfo = _getDriverInfoUsecase(),
      super(const ActiveRideLoading());

  ActiveRideInProgress? get lastSnapshot => _lastSnapshot;

  Future<void> startRide(
    String rideId, {
    LatLng? origin,
    LatLng? destination,
  }) async {
    try {
      _rideId = rideId;
      _origin = origin ?? _origin ?? _defaultOrigin;
      _destination = destination ?? _destination ?? _defaultDestination;
      _progressSeed = 0;
      _initialDistanceMeters = null;
      _refreshTimer?.cancel();
      _retryTimer?.cancel();
      emit(const ActiveRideLoading());

      final firstFetchSucceeded = await _fetchRoute();
      if (firstFetchSucceeded) {
        _startRefresh();
      }
    } catch (_) {
      emit(const ActiveRideError(AppStrings.couldNotLoadRoute));
    }
  }

  void _startRefresh() {
    _refreshTimer?.cancel();
    _refreshTimer = Timer.periodic(
      AppConstants.routeRefreshInterval,
      (_) => _refreshRouteSafely(),
    );
  }

  Future<void> _refreshRouteSafely() async {
    try {
      await _fetchRoute();
    } catch (_) {
      emit(const ActiveRideError(AppStrings.couldNotLoadRoute));
    }
  }

  Future<bool> _fetchRoute() async {
    final baseOrigin = _origin;
    final destination = _destination;
    if (baseOrigin == null || destination == null) {
      emit(const ActiveRideError(AppStrings.noDestinationSet));
      return false;
    }

    try {
      final routeOrigin = _interpolate(baseOrigin, destination, _progressSeed);
      final route = await _getRouteUsecase(
        origin: routeOrigin,
        destination: destination,
      );

      _initialDistanceMeters ??= route.distanceMeters;
      final progress = _buildProgress(route.distanceMeters);
      final nextState = ActiveRideInProgress(
        route: route,
        turnInstruction: route.turnInstruction,
        tripProgress: progress,
        driverInfo: _driverInfo,
        eta: _formatEta(route.durationSeconds),
        distanceKm: _formatDistanceKm(route.distanceMeters),
        destination: destination,
      );

      _lastSnapshot = nextState;
      emit(nextState);
      _progressSeed = (progress + 0.18).clamp(0.0, 1.0);

      if (progress >= 0.98 || route.distanceMeters <= 120) {
        await completeRide();
      }
      return true;
    } on DioException {
      _handleRouteFailure();
    } catch (_) {
      _handleRouteFailure();
    }

    return false;
  }

  void _handleRouteFailure() {
    emit(const ActiveRideError(AppStrings.couldNotLoadRoute));
    _refreshTimer?.cancel();
    _retryTimer?.cancel();
    _retryTimer = Timer(AppConstants.routeRetryDelay, () async {
      if (_rideId == null) {
        return;
      }
      final retrySucceeded = await _fetchRoute();
      if (retrySucceeded && state is! ActiveRideCompleted) {
        _startRefresh();
      }
    });
  }

  Future<void> completeRide() async {
    try {
      _refreshTimer?.cancel();
      _retryTimer?.cancel();
      emit(const ActiveRideCompleted());
    } catch (_) {
      emit(const ActiveRideError(AppStrings.couldNotLoadRoute));
    }
  }

  double _buildProgress(double remainingDistance) {
    final total = _initialDistanceMeters ?? remainingDistance;
    if (total <= 0) {
      return 0;
    }
    return ((total - remainingDistance) / total).clamp(0.0, 1.0);
  }

  String _formatEta(double durationSeconds) {
    final minutes = (durationSeconds / 60).ceil().clamp(1, 120);
    return '$minutes ${AppStrings.minutesShort}';
  }

  String _formatDistanceKm(double distanceMeters) {
    return (distanceMeters / 1000).toStringAsFixed(1);
  }

  LatLng _interpolate(LatLng start, LatLng end, double progress) {
    return LatLng(
      start.latitude + ((end.latitude - start.latitude) * progress),
      start.longitude + ((end.longitude - start.longitude) * progress),
    );
  }

  @override
  Future<void> close() {
    _refreshTimer?.cancel();
    _retryTimer?.cancel();
    return super.close();
  }
}
