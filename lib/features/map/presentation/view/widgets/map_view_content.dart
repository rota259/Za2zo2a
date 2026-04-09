import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';

import '../../../../../core/constants/app_colors.dart';
import '../../../../../core/utils/responsive.dart';
import '../../../data/models/search_result_model.dart';
import '../../../domain/usecases/get_user_location_use_case.dart';
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
  late final TextEditingController _searchController;
  late final FocusNode _searchFocusNode;
  StreamSubscription<dynamic>? _cameraMoveSubscription;
  LatLng? _currentCenter;
  double _currentZoom = MapConstants.initialZoom;
  String? _lastFittedDestinationKey;
  bool _isShowingDialog = false;
  Timer? _searchDebounce;

  @override
  void initState() {
    super.initState();
    _mapController = MapController();
    _searchController = TextEditingController();
    _searchFocusNode = FocusNode();

    _cameraMoveSubscription = context.read<MapCubit>().cameraMoveStream.listen((
      target,
    ) {
      if (!mounted) {
        return;
      }

      _currentCenter = target;

      // ✅ FIX: Wait for the map widget to be fully built before calling move()
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (!mounted) return;
        _mapController.move(target, _currentZoom);
      });
    });
  }

  @override
  void dispose() {
    _searchDebounce?.cancel();
    _cameraMoveSubscription?.cancel();
    _searchController.dispose();
    _searchFocusNode.dispose();
    super.dispose();
  }

  void _handleMapTap() {
    _searchFocusNode.unfocus();
    context.read<MapCubit>().clearSearchResults();
    setState(() {});
  }

  void _handleSearchChanged(String value) {
    _searchDebounce?.cancel();

    if (value.trim().isEmpty) {
      context.read<MapCubit>().clearSearchResults();
      setState(() {});
      return;
    }

    _searchDebounce = Timer(MapConstants.searchDebounce, () {
      if (!mounted) {
        return;
      }

      context.read<MapCubit>().searchPlaces(value);
    });
  }

  void _handleSearchCleared() {
    _searchDebounce?.cancel();
    _searchController.clear();
    context.read<MapCubit>().clearSearchResults();
    setState(() {});
  }

  Future<void> _handleSuggestionSelected(SearchResultModel result) async {
    _searchController.text = result.title;
    _searchFocusNode.unfocus();
    setState(() {});
    await context.read<MapCubit>().selectDestination(result);
  }

  void _handleCenterOnUser(MapLocationLoaded state) {
    final cubit = context.read<MapCubit>();
    if (!state.isFollowingUser) {
      cubit.toggleFollowUser();
    }
    cubit.moveToLocation(state.userLocation);
  }

  void _handleTripAction(MapLocationLoaded state) {
    final cubit = context.read<MapCubit>();
    if (state.isTripActive) {
      _searchController.clear();
      cubit.endTrip();
      setState(() {});
      return;
    }

    cubit.startTrip();
  }

  void _handlePositionChanged(MapPosition position, bool hasGesture) {
    _currentCenter = position.center ?? _currentCenter;
    _currentZoom = position.zoom ?? _currentZoom;

    final cubit = context.read<MapCubit>();
    final loadedState = cubit.lastLoadedState;
    if (hasGesture && (loadedState?.isFollowingUser ?? false)) {
      cubit.toggleFollowUser();
    }
  }

  void _handleZoom(double delta) {
    if (_currentCenter == null) {
      return;
    }

    final nextZoom = (_currentZoom + delta).clamp(
      MapConstants.minZoom,
      MapConstants.maxZoom,
    );

    _currentZoom = nextZoom;
    _mapController.move(_currentCenter!, nextZoom);
  }

  void _maybeFitCamera(MapLocationLoaded state) {
    final destination = state.destination;
    if (destination == null) {
      _lastFittedDestinationKey = null;
      return;
    }

    final routeSignature =
        '${destination.latitude.toStringAsFixed(6)}_${destination.longitude.toStringAsFixed(6)}_${state.routePoints.length}';
    if (_lastFittedDestinationKey == routeSignature) {
      return;
    }

    _lastFittedDestinationKey = routeSignature;
    final coordinates = state.routePoints.isNotEmpty
        ? state.routePoints
        : [state.userLocation, destination];
    final rightPadding = context.isTablet && widget.showLocationDetails
        ? MapConstants.tabletPanelWidth
        : 32.0;
    final bottomPadding = context.isMobile && widget.showLocationDetails
        ? MapConstants.mobileMapBottomInset
        : 32.0;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted || coordinates.isEmpty) {
        return;
      }

      _mapController.fitCamera(
        CameraFit.coordinates(
          coordinates: coordinates,
          padding: EdgeInsets.fromLTRB(
            32,
            widget.showSearchBar ? 140 : 32,
            rightPadding,
            bottomPadding,
          ),
          maxZoom: MapConstants.maxZoom,
        ),
      );
    });
  }

  Widget _wrapContent(Widget child) {
    if (!widget.showScaffold) {
      return child;
    }

    return Scaffold(body: child);
  }

  Future<void> _handleErrorState(BuildContext context, String message) async {
    final cubit = context.read<MapCubit>();
    final failureType = cubit.lastLocationFailureType;

    if (failureType == null) {
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(
          SnackBar(content: Text(message), backgroundColor: AppColors.error),
        );
      return;
    }

    if (_isShowingDialog) {
      return;
    }

    _isShowingDialog = true;
    await showDialog<void>(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: Text(_resolveDialogTitle(failureType)),
          content: Text(_resolveDialogMessage(failureType)),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(dialogContext).pop(),
              child: const Text(MapConstants.cancelLabel),
            ),
            TextButton(
              onPressed: () async {
                Navigator.of(dialogContext).pop();
                switch (failureType) {
                  case LocationFailureType.servicesDisabled:
                    await Geolocator.openLocationSettings();
                    break;
                  case LocationFailureType.permissionDenied:
                  case LocationFailureType.permissionDeniedForever:
                    await Geolocator.openAppSettings();
                    break;
                  case LocationFailureType.timeout:
                    if (mounted) {
                      await context.read<MapCubit>().initLocation();
                    }
                    break;
                }
              },
              child: Text(_resolveDialogActionLabel(failureType)),
            ),
          ],
        );
      },
    );
    _isShowingDialog = false;
  }

  String _resolveDialogTitle(LocationFailureType failureType) {
    switch (failureType) {
      case LocationFailureType.servicesDisabled:
        return MapConstants.gpsDialogTitle;
      case LocationFailureType.permissionDenied:
      case LocationFailureType.permissionDeniedForever:
        return MapConstants.permissionDialogTitle;
      case LocationFailureType.timeout:
        return MapConstants.timeoutDialogTitle;
    }
  }

  String _resolveDialogMessage(LocationFailureType failureType) {
    switch (failureType) {
      case LocationFailureType.servicesDisabled:
        return MapConstants.gpsDialogMessage;
      case LocationFailureType.permissionDenied:
      case LocationFailureType.permissionDeniedForever:
        return MapConstants.permissionDialogMessage;
      case LocationFailureType.timeout:
        return MapConstants.timeoutDialogMessage;
    }
  }

  String _resolveDialogActionLabel(LocationFailureType failureType) {
    switch (failureType) {
      case LocationFailureType.servicesDisabled:
        return MapConstants.enableGpsLabel;
      case LocationFailureType.permissionDenied:
      case LocationFailureType.permissionDeniedForever:
        return MapConstants.openSettingsLabel;
      case LocationFailureType.timeout:
        return MapConstants.retryLabel;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MapCubit, MapState>(
      listener: (context, state) {
        if (state is MapLocationLoaded) {
          _currentCenter = state.userLocation;
          _maybeFitCamera(state);
        }

        if (state is MapError) {
          _handleErrorState(context, state.message);
        }
      },
      builder: (context, state) {
        final cubit = context.read<MapCubit>();
        final cachedState = cubit.lastLoadedState;
        final mapState = state is MapLocationLoaded ? state : cachedState;
        final searchResults = cubit.searchResults;
        final destinationDetails = cubit.selectedDestinationResult;
        final isSearching = state is MapSearching;
        final isRouteFetching =
            state is MapRouteFetching || cubit.isRouteFetching;

        if (state is MapError && mapState == null) {
          return _wrapContent(
            SafeArea(
              child: MapEmptyState(
                title: MapConstants.mapUnavailableTitle,
                description: state.message,
                onRetry: context.read<MapCubit>().initLocation,
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
                    if (state is MapLocationLoading)
                      const MapLoadingOverlay(
                        message: MapConstants.locationLoadingMessage,
                      ),
                  ],
                );
              }

              final content = widget.showLocationDetails
                  ? context.isMobile
                        ? MapMobileLayout(
                            state: mapState,
                            mapController: _mapController,
                            showSearchBar: widget.showSearchBar,
                            showMapControls: widget.showMapControls,
                            searchController: _searchController,
                            searchFocusNode: _searchFocusNode,
                            searchResults: searchResults,
                            destinationDetails: destinationDetails,
                            isSearching: isSearching,
                            isRouteFetching: isRouteFetching,
                            onMapTap: _handleMapTap,
                            onSearchChanged: _handleSearchChanged,
                            onSearchCleared: _handleSearchCleared,
                            onSuggestionSelected: _handleSuggestionSelected,
                            onNavigate: cubit.navigateWithGoogleMaps,
                            onPositionChanged: _handlePositionChanged,
                            onCenterOnUserLocation: () =>
                                _handleCenterOnUser(mapState),
                            onZoomIn: () => _handleZoom(MapConstants.zoomStep),
                            onZoomOut: () =>
                                _handleZoom(-MapConstants.zoomStep),
                            onTripAction: () => _handleTripAction(mapState),
                          )
                        : MapTabletLayout(
                            state: mapState,
                            mapController: _mapController,
                            showSearchBar: widget.showSearchBar,
                            showMapControls: widget.showMapControls,
                            searchController: _searchController,
                            searchFocusNode: _searchFocusNode,
                            searchResults: searchResults,
                            destinationDetails: destinationDetails,
                            isSearching: isSearching,
                            isRouteFetching: isRouteFetching,
                            onMapTap: _handleMapTap,
                            onSearchChanged: _handleSearchChanged,
                            onSearchCleared: _handleSearchCleared,
                            onSuggestionSelected: _handleSuggestionSelected,
                            onNavigate: cubit.navigateWithGoogleMaps,
                            onPositionChanged: _handlePositionChanged,
                            onCenterOnUserLocation: () =>
                                _handleCenterOnUser(mapState),
                            onZoomIn: () => _handleZoom(MapConstants.zoomStep),
                            onZoomOut: () =>
                                _handleZoom(-MapConstants.zoomStep),
                            onTripAction: () => _handleTripAction(mapState),
                          )
                  : MapInteractivePane(
                      state: mapState,
                      mapController: _mapController,
                      bottomInset: 16,
                      showSearchBar: widget.showSearchBar,
                      showMapControls: widget.showMapControls,
                      searchController: _searchController,
                      searchFocusNode: _searchFocusNode,
                      searchResults: searchResults,
                      isSearching: isSearching,
                      showNavigateButton: false,
                      onMapTap: _handleMapTap,
                      onSearchChanged: _handleSearchChanged,
                      onSearchCleared: _handleSearchCleared,
                      onSuggestionSelected: _handleSuggestionSelected,
                      onNavigate: cubit.navigateWithGoogleMaps,
                      onPositionChanged: _handlePositionChanged,
                      onCenterOnUserLocation: () =>
                          _handleCenterOnUser(mapState),
                      onZoomIn: () => _handleZoom(MapConstants.zoomStep),
                      onZoomOut: () => _handleZoom(-MapConstants.zoomStep),
                    );

              return Stack(
                fit: StackFit.expand,
                children: [
                  content,
                  if (state is MapLocationLoading)
                    const MapLoadingOverlay(
                      message: MapConstants.locationLoadingMessage,
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