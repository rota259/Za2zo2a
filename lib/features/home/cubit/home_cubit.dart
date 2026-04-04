import 'package:flutter_bloc/flutter_bloc.dart';
import 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial()) {
    _loadInitialData();
  }

  void _loadInitialData() async {
    emit(HomeLoading());
    // Simulate fetching current location and driver status
    await Future.delayed(const Duration(seconds: 1));
    emit(const HomeLoaded(currentLocation: '123 Main St, Springfield'));
  }

  void selectDestination(String? destination) {
    if (state is HomeLoaded) {
      final currentState = state as HomeLoaded;
      emit(HomeLoaded(
        currentLocation: currentState.currentLocation,
        selectedDestination: destination,
        savedHomeAddress: currentState.savedHomeAddress,
        savedWorkAddress: currentState.savedWorkAddress,
      ));
    }
  }

  void saveHomeAddress(String address) {
    if (state is HomeLoaded) {
      final current = state as HomeLoaded;
      emit(HomeLoaded(
        currentLocation: current.currentLocation,
        selectedDestination: current.selectedDestination,
        savedHomeAddress: address,
        savedWorkAddress: current.savedWorkAddress,
      ));
    }
  }

  void saveWorkAddress(String address) {
    if (state is HomeLoaded) {
      final current = state as HomeLoaded;
      emit(HomeLoaded(
        currentLocation: current.currentLocation,
        selectedDestination: current.selectedDestination,
        savedHomeAddress: current.savedHomeAddress,
        savedWorkAddress: address,
      ));
    }
  }
}
