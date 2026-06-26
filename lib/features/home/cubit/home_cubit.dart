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

  void selectDestination(String? destination, {LatLng? coords}) {
    if (state is HomeLoaded) {
      final s = state as HomeLoaded;
      emit(HomeLoaded(
        currentLocation: s.currentLocation,
        currentLocationCoords: s.currentLocationCoords,
        selectedDestination: destination,
        selectedDestinationCoords: coords,
        savedHomeAddress: s.savedHomeAddress,
        savedWorkAddress: s.savedWorkAddress,
      ));
    }
  }

  void saveHomeAddress(String address) {
    if (state is HomeLoaded) {
      final s = state as HomeLoaded;
      emit(HomeLoaded(
        currentLocation: s.currentLocation,
        currentLocationCoords: s.currentLocationCoords,
        selectedDestination: s.selectedDestination,
        selectedDestinationCoords: s.selectedDestinationCoords,
        savedHomeAddress: address,
        savedWorkAddress: s.savedWorkAddress,
      ));
    }
  }

  void saveWorkAddress(String address) {
    if (state is HomeLoaded) {
      final s = state as HomeLoaded;
      emit(HomeLoaded(
        currentLocation: s.currentLocation,
        currentLocationCoords: s.currentLocationCoords,
        selectedDestination: s.selectedDestination,
        selectedDestinationCoords: s.selectedDestinationCoords,
        savedHomeAddress: s.savedHomeAddress,
        savedWorkAddress: address,
      ));
    }
  }
}
