import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/utils/responsive.dart';
import '../../../../core/services/location_service.dart';
import '../cubit/ride_cubit.dart';
import '../cubit/ride_state.dart';
import 'widgets/ride_selection_sheet.dart';

class RideSelectionView extends StatefulWidget {
  const RideSelectionView({super.key});

  @override
  State<RideSelectionView> createState() => _RideSelectionViewState();
}

class _RideSelectionViewState extends State<RideSelectionView> {
  final MapController _mapController = MapController();
  LatLng _currentLocation = const LatLng(30.0444, 31.2357);

  @override
  void initState() {
    super.initState();
    context.read<RideCubit>().fetchRideOptions();
    _getUserLocation();
  }

  Future<void> _getUserLocation() async {
    try {
      final pos = await LocationService.getCurrentLocation();
      setState(() => _currentLocation = LatLng(pos.latitude, pos.longitude));
      _mapController.move(_currentLocation, 14.0);
    } catch (e) {
      debugPrint('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RideCubit, RideState>(
      listener: (context, state) {
        if (state is RideActive) {
          context.push('/home/finding-driver');
        }
      },
      builder: (context, state) {
        return Scaffold(
          body: Stack(
            children: [
              FlutterMap(
                mapController: _mapController,
                options: MapOptions(
                  initialCenter: _currentLocation,
                  initialZoom: 14.0,
                ),
                children: [
                  TileLayer(
                    urlTemplate:
                        'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                    userAgentPackageName: 'com.example.app',
                  ),
                ],
              ),
              SafeArea(
                child: Padding(
                  padding: EdgeInsets.all(context.widthPct(16)),
                  child: CircleAvatar(
                    backgroundColor: Colors.white,
                    child: IconButton(
                      icon: Icon(
                        Icons.arrow_back,
                        color: AppColors.textPrimary,
                      ),
                      onPressed: () => context.pop(),
                    ),
                  ),
                ),
              ),
              RideSelectionSheet(state: state),
            ],
          ),
        );
      },
    );
  }
}
