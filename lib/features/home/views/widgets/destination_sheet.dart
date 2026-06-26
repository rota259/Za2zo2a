import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../../../core/network/api_error.dart';
import '../../../../core/utils/responsive.dart';
import '../../../../injection_container.dart';
import '../../../trip/data/models/trip_models.dart';
import '../../../trip/data/repos/trip_repo.dart';
import '../../cubit/home_cubit.dart';
import '../../cubit/home_state.dart';

class DestinationSheet extends StatefulWidget {
  final HomeLoaded state;
  const DestinationSheet({super.key, required this.state});

  @override
  State<DestinationSheet> createState() => _DestinationSheetState();
}

class _DestinationSheetState extends State<DestinationSheet> {
  bool _requesting = false;

  Future<void> _requestRide(BuildContext context) async {
    final homeState = widget.state;
    if (_requesting) return;
    if (homeState.currentLocationCoords == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Location is still loading')),
      );
      return;
    }

    final destCoords = homeState.selectedDestinationCoords;
    if (destCoords == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please search or pick a destination')),
      );
      return;
    }

    setState(() => _requesting = true);
    try {
      final origin = homeState.currentLocationCoords!;
      final trip = await sl<TripRepo>().requestTrip(
        origin: GeoPoint(lat: origin.latitude, lng: origin.longitude),
        destination: GeoPoint(
          lat: destCoords.latitude,
          lng: destCoords.longitude,
          address: homeState.selectedDestination,
        ),
      );
      if (!mounted) return;
      context.go('/trip/${trip.id}');
    } on ApiError catch (e) {
      if (!mounted) return;
      if (e.isConflict) {
        await _handleActiveTrip(context);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(e.message), backgroundColor: AppColors.error),
        );
      }
    } finally {
      if (mounted) setState(() => _requesting = false);
    }
  }

  Future<void> _handleActiveTrip(BuildContext context) async {
    TripModel? active;
    try {
      active = await sl<TripRepo>().getActiveTrip();
    } catch (_) {
      // couldn't fetch — fall through to dialog
    }

    if (!mounted) return;

    if (active != null && active.id.isNotEmpty) {
      final goToTrip = await showDialog<bool>(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text('Ongoing trip'),
          content: const Text(
              'You already have an active trip. Would you like to track it?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(ctx, false),
              child: const Text('Stay here'),
            ),
            TextButton(
              onPressed: () => Navigator.pop(ctx, true),
              child: const Text('Go to trip'),
            ),
          ],
        ),
      );
      if (goToTrip == true && mounted) {
        context.go('/trip/${active.id}');
      }
    } else {
      showDialog<void>(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text('Ongoing trip'),
          content: const Text(
              'You already have an active trip. Complete or cancel it first.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(ctx),
              child: const Text('OK'),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(
        context.widthPct(24),
        context.heightPct(16),
        context.widthPct(24),
        context.heightPct(24),
      ),
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(context.widthPct(24)),
        ),
        boxShadow: const [
          BoxShadow(color: Colors.black12, blurRadius: 12, spreadRadius: 2),
        ],
      ),
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Center(
              child: Container(
                width: context.widthPct(40),
                height: 4,
                decoration: BoxDecoration(
                  color: AppColors.grey300,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            SizedBox(height: context.heightPct(20)),
            Row(
              children: [
                Icon(
                  Icons.location_on,
                  color: AppColors.error,
                  size: context.widthPct(28),
                ),
                SizedBox(width: context.widthPct(12)),
                Expanded(
                  child: Text(
                    widget.state.selectedDestination!,
                    style: AppTextStyles.h2(context),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.close, color: AppColors.textSecondary),
                  onPressed: () =>
                      context.read<HomeCubit>().selectDestination(null),
                ),
              ],
            ),
            SizedBox(height: context.heightPct(20)),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  padding: EdgeInsets.symmetric(
                    vertical: context.heightPct(18),
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(context.widthPct(50)),
                  ),
                ),
                onPressed: _requesting ? null : () => _requestRide(context),
                child: _requesting
                    ? const SizedBox(
                        width: 22,
                        height: 22,
                        child: CircularProgressIndicator(
                            strokeWidth: 2.4, color: Colors.white))
                    : Text(
                        'Confirm & Request Ride',
                        style: AppTextStyles.button(context).copyWith(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
