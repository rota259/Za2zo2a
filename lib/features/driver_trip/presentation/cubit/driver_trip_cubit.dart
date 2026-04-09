import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:latlong2/latlong.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../core/constants/app_strings.dart';
import '../../domain/entities/destination_entity.dart';
import '../../domain/usecases/end_trip_usecase.dart';
import '../../domain/usecases/get_driver_route_usecase.dart';
import '../../domain/usecases/navigate_to_destination_usecase.dart';
import 'driver_trip_state.dart';

class DriverTripCubit extends Cubit<DriverTripState> {
  final GetDriverRouteUsecase _getDriverRouteUsecase;
  final EndTripUsecase _endTripUsecase;
  final NavigateToDestinationUsecase _navigateToDestinationUsecase;
  final DestinationEntity _destination = const DestinationEntity.mock();
  final LatLng _start = const LatLng(37.7950, -122.3980);
  Timer? _refreshTimer;
  Timer? _retryTimer;
  String? _rideId;
  double _progressSeed = 0;
  DriverTripActive? _lastSnapshot;

  DriverTripCubit(
    this._getDriverRouteUsecase,
    this._endTripUsecase,
    this._navigateToDestinationUsecase,
  ) : super(const DriverTripLoading());

  DriverTripActive? get lastSnapshot => _lastSnapshot;
  DestinationEntity get destination => _destination;

  Future<void> loadTrip(String rideId) async {
    _rideId = rideId;
    _progressSeed = 0;
    emit(const DriverTripLoading());
    await _fetchRoute();
    _startRefresh();
  }

  void _startRefresh() {
    _refreshTimer?.cancel();
    _refreshTimer = Timer.periodic(
      AppConstants.routeRefreshInterval,
      (_) => _fetchRoute(),
    );
  }

  Future<void> _fetchRoute() async {
    try {
      final origin = _interpolate(
        _start,
        LatLng(_destination.lat, _destination.lng),
        _progressSeed,
      );
      final route = await _getDriverRouteUsecase(
        origin: origin,
        destination: LatLng(_destination.lat, _destination.lng),
      );
      final state = DriverTripActive(
        route: route,
        turnInstruction: route.turnInstruction,
        distanceToTurn: _formatDistanceToTurn(route.distanceToTurnMeters),
        eta: _formatEta(route.durationSeconds),
        destination: _destination,
        distanceKm: _destination.distanceKm,
        tripTime: _destination.tripTime,
      );

      _lastSnapshot = state;
      emit(state);
      _progressSeed = (_progressSeed + 0.18).clamp(0.0, 1.0);
    } on DioException {
      _handleFailure();
    } catch (_) {
      _handleFailure();
    }
  }

  void _handleFailure() {
    emit(const DriverTripError(AppStrings.couldNotLoadRoute));
    _refreshTimer?.cancel();
    _retryTimer?.cancel();
    _retryTimer = Timer(AppConstants.routeRetryDelay, () async {
      if (_rideId == null) {
        return;
      }
      await _fetchRoute();
      if (state is! DriverTripEnded) {
        _startRefresh();
      }
    });
  }

  Future<void> endTrip() async {
    _refreshTimer?.cancel();
    _retryTimer?.cancel();
    await _endTripUsecase(_rideId ?? '');
    emit(const DriverTripEnded());
  }

  Future<NavigationLaunchStatus> navigateToDestination() {
    return _navigateToDestinationUsecase(_destination);
  }

  String _formatDistanceToTurn(double meters) {
    return '${meters.round()} ${AppStrings.meterSuffix}';
  }

  String _formatEta(double durationSeconds) {
    final minutes = (durationSeconds / 60).ceil().clamp(1, 99);
    return '$minutes ${AppStrings.minuteShort}';
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
