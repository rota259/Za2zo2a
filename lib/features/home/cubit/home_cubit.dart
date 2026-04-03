import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:latlong2/latlong.dart';
import '../../../core/services/location_service.dart';
import 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial()) {
    _loadInitialData();
  }

  void _loadInitialData() async {
    emit(HomeLoading());
    try {
      final position = await LocationService.getCurrentLocation();
      emit(
        HomeLoaded(
          currentLocation: 'Current Location',
          currentLocationCoords: LatLng(position.latitude, position.longitude),
        ),
      );
    } catch (e) {
      emit(const HomeLoaded(currentLocation: 'Location Error'));
    }
  }

  void selectDestination(String? destination) {
    if (state is HomeLoaded) {
      final currentState = state as HomeLoaded;
      emit(
        HomeLoaded(
          currentLocation: currentState.currentLocation,
          selectedDestination: destination,
          savedHomeAddress: currentState.savedHomeAddress,
          savedWorkAddress: currentState.savedWorkAddress,
        ),
      );
    }
  }

  void saveHomeAddress(String address) {
    if (state is HomeLoaded) {
      final current = state as HomeLoaded;
      emit(
        HomeLoaded(
          currentLocation: current.currentLocation,
          selectedDestination: current.selectedDestination,
          savedHomeAddress: address,
          savedWorkAddress: current.savedWorkAddress,
        ),
      );
    }
  }

  void saveWorkAddress(String address) {
    if (state is HomeLoaded) {
      final current = state as HomeLoaded;
      emit(
        HomeLoaded(
          currentLocation: current.currentLocation,
          selectedDestination: current.selectedDestination,
          savedHomeAddress: current.savedHomeAddress,
          savedWorkAddress: address,
        ),
      );
    }
  }
}
