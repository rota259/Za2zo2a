import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:latlong2/latlong.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../core/constants/app_strings.dart';
import '../../data/models/nominatim_place_model.dart';
import '../../domain/entities/place_entity.dart';
import '../../domain/usecases/get_user_location_usecase.dart';
import '../../domain/usecases/search_places_usecase.dart';
import 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final SearchPlacesUsecase _searchPlacesUsecase;
  final GetUserLocationUsecase _getUserLocationUsecase;
  Timer? _debounce;
  LatLng? _userLocation;
  LatLng? _selectedLocation;
  PlaceEntity? _selectedPlace;
  List<NominatimPlaceModel> _results = const [];
  String _query = '';

  HomeCubit(this._searchPlacesUsecase, this._getUserLocationUsecase)
    : super(const HomeInitial());

  bool get canStartRide => _userLocation != null && _selectedLocation != null;
  LatLng? get userLocation => _userLocation;
  LatLng? get selectedLocation => _selectedLocation;

  Future<void> loadUserLocation() async {
    try {
      emit(_locationLoadingState());
      _userLocation = await _getUserLocationUsecase();
      emit(_locationLoadedState());
    } on LocationAccessException catch (error) {
      emit(
        HomeLocationError(
          error.message,
          openSettings: error.shouldOpenSettings,
          selectedLocation: _selectedLocation,
          selectedPlace: _selectedPlace,
          results: _results,
          query: _query,
        ),
      );
    } catch (_) {
      emit(
        HomeLocationError(
          AppStrings.locationPermissionDenied,
          openSettings: false,
          selectedLocation: _selectedLocation,
          selectedPlace: _selectedPlace,
          results: _results,
          query: _query,
        ),
      );
    }
  }

  void onSearchChanged(String value) {
    _debounce?.cancel();
    _query = value;

    if (value.trim().isEmpty) {
      _results = const [];
      emit(_locationLoadedState(query: value));
      return;
    }

    emit(_searchLoadingState());
    _debounce = Timer(AppConstants.searchDebounce, _performSearch);
  }

  Future<void> retrySearch() async {
    try {
      if (_query.trim().isEmpty) {
        return;
      }

      emit(_searchLoadingState());
      await _performSearch();
    } catch (_) {
      _emitSearchError();
    }
  }

  void selectPlace(NominatimPlaceModel place) {
    _selectedPlace = place;
    _selectedLocation = place.latLng;
    _results = const [];
    emit(_locationLoadedState(query: place.placeName));
  }

  Future<void> _performSearch() async {
    try {
      final response = await _searchPlacesUsecase(_query.trim());
      _results = response.whereType<NominatimPlaceModel>().toList(
        growable: false,
      );

      if (_results.isEmpty) {
        emit(
          HomeSearchEmpty(
            userLocation: _userLocation,
            selectedLocation: _selectedLocation,
            selectedPlace: _selectedPlace,
            query: _query,
          ),
        );
        return;
      }

      emit(
        HomeSearchLoaded(
          results: _results,
          userLocation: _userLocation,
          selectedLocation: _selectedLocation,
          selectedPlace: _selectedPlace,
          query: _query,
        ),
      );
    } on DioException {
      _emitSearchError();
    } catch (_) {
      _emitSearchError();
    }
  }

  void _emitSearchError() {
    emit(
      HomeSearchError(
        AppStrings.checkInternet,
        userLocation: _userLocation,
        selectedLocation: _selectedLocation,
        selectedPlace: _selectedPlace,
        results: _results,
        query: _query,
      ),
    );
  }

  HomeLocationLoading _locationLoadingState() {
    return HomeLocationLoading(
      userLocation: _userLocation,
      selectedLocation: _selectedLocation,
      selectedPlace: _selectedPlace,
      results: _results,
      query: _query,
    );
  }

  HomeSearchLoading _searchLoadingState() {
    return HomeSearchLoading(
      userLocation: _userLocation,
      selectedLocation: _selectedLocation,
      selectedPlace: _selectedPlace,
      results: _results,
      query: _query,
    );
  }

  HomeLocationLoaded _locationLoadedState({String? query}) {
    return HomeLocationLoaded(
      userLocation: _userLocation ?? const LatLng(30.0444, 31.2357),
      selectedLocation: _selectedLocation,
      selectedPlace: _selectedPlace,
      results: _results,
      query: query ?? _query,
    );
  }

  @override
  Future<void> close() {
    _debounce?.cancel();
    return super.close();
  }
}
