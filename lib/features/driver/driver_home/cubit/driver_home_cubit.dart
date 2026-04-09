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
      // Silently ignore – keep listening
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
