import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/constants/app_colors.dart';
import '../../../../../core/constants/app_text_styles.dart';
import '../../../../../core/utils/responsive.dart';
import '../../../trip/data/models/trip_models.dart';
import '../../dispatch/driver_dispatch_cubit.dart';
import '../../dispatch/driver_dispatch_state.dart';

class DriverAvailableTrips extends StatelessWidget {
  const DriverAvailableTrips({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DriverDispatchCubit, DriverDispatchState>(
      builder: (context, state) {
        final trips = state.trips;
        return SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: context.widthPct(16),
                  vertical: context.heightPct(12),
                ),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: context.widthPct(18),
                      backgroundColor: Colors.blueGrey.shade800,
                      child: Icon(Icons.person,
                          color: Colors.amber.shade200,
                          size: context.widthPct(20)),
                    ),
                    SizedBox(width: context.widthPct(12)),
                    Expanded(
                      child: Text('Za2zo2a',
                          overflow: TextOverflow.ellipsis,
                          style: AppTextStyles.h2(context).copyWith(
                              fontWeight: FontWeight.bold,
                              fontSize: context.fontPct(22))),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: context.widthPct(12),
                          vertical: context.heightPct(6)),
                      decoration: BoxDecoration(
                        color: AppColors.primary.withValues(alpha: 0.1),
                        borderRadius:
                            BorderRadius.circular(context.widthPct(20)),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.sensors,
                              color: AppColors.primary,
                              size: context.widthPct(14)),
                          SizedBox(width: context.widthPct(4)),
                          Text('ONLINE',
                              style: AppTextStyles.caption(context).copyWith(
                                  color: AppColors.primary,
                                  fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: context.widthPct(16),
                    vertical: context.heightPct(16)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Available Trips',
                        style: AppTextStyles.h1(context)
                            .copyWith(fontWeight: FontWeight.w900)),
                    Text(
                        '${trips.length} request${trips.length == 1 ? '' : 's'} nearby',
                        style: AppTextStyles.bodyMedium(context)
                            .copyWith(color: AppColors.textSecondary)),
                  ],
                ),
              ),
              Expanded(
                child: trips.isEmpty
                    ? Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.hourglass_empty,
                                size: 48, color: Colors.grey),
                            const SizedBox(height: 12),
                            const Text('Waiting for ride requests…',
                                textAlign: TextAlign.center),
                          ],
                        ),
                      )
                    : ListView.builder(
                        padding: EdgeInsets.symmetric(
                            horizontal: context.widthPct(16)),
                        itemCount: trips.length,
                        itemBuilder: (context, index) {
                          final trip = trips[index];
                          final accepting =
                              state.acceptingIds.contains(trip.id);
                          if (index == 0) {
                            return _highlightedCard(context, trip, accepting);
                          }
                          return _compactCard(context, trip, accepting);
                        },
                      ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _highlightedCard(
      BuildContext context, TripModel trip, bool accepting) {
    return Container(
      margin: EdgeInsets.only(bottom: context.heightPct(16)),
      padding: EdgeInsets.all(context.widthPct(16)),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(context.widthPct(16)),
        boxShadow: const [
          BoxShadow(
              color: Colors.black12, blurRadius: 10, offset: Offset(0, 4)),
        ],
      ),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                radius: context.widthPct(22),
                backgroundColor: Colors.grey.shade200,
                child: Icon(Icons.person,
                    size: context.widthPct(22), color: Colors.grey),
              ),
              SizedBox(width: context.widthPct(12)),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(trip.riderName ?? 'Rider',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: AppTextStyles.h3(context)
                            .copyWith(fontWeight: FontWeight.bold)),
                    Row(
                      children: [
                        Icon(Icons.star,
                            color: Colors.orange,
                            size: context.widthPct(14)),
                        Text(
                            ' ${trip.riderRating?.toStringAsFixed(1) ?? '--'}',
                            style: AppTextStyles.caption(context)
                                .copyWith(fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  SizedBox(height: context.heightPct(6)),
                  Text(
                    trip.fare != null
                        ? 'EGP ${trip.fare!.toStringAsFixed(0)}'
                        : '--',
                    style: AppTextStyles.h2(context).copyWith(
                        color: AppColors.primary, fontWeight: FontWeight.bold),
                  ),
                  Text('CONSTANT PRICE',
                      style: TextStyle(
                          fontSize: 8,
                          color: AppColors.textSecondary,
                          fontWeight: FontWeight.bold)),
                ],
              ),
            ],
          ),
          SizedBox(height: context.heightPct(20)),
          _routeColumn(context, trip),
          SizedBox(height: context.heightPct(24)),
          Row(
            children: [
              Expanded(
                flex: 1,
                child: OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    foregroundColor: AppColors.textSecondary,
                    side: BorderSide(color: AppColors.grey200),
                    padding:
                        EdgeInsets.symmetric(vertical: context.heightPct(14)),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)),
                  ),
                  onPressed: accepting
                      ? null
                      : () =>
                          context.read<DriverDispatchCubit>().dismiss(trip.id),
                  child:
                      Text('Decline', style: TextStyle(fontWeight: FontWeight.bold)),
                ),
              ),
              SizedBox(width: context.widthPct(12)),
              Expanded(
                flex: 2,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    padding:
                        EdgeInsets.symmetric(vertical: context.heightPct(14)),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)),
                    elevation: 0,
                  ),
                  onPressed: accepting
                      ? null
                      : () =>
                          context.read<DriverDispatchCubit>().accept(trip.id),
                  child: accepting
                      ? const SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(
                              strokeWidth: 2, color: Colors.white))
                      : Text('Accept Trip',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold)),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _compactCard(BuildContext context, TripModel trip, bool accepting) {
    return Container(
      margin: EdgeInsets.only(bottom: context.heightPct(16)),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(context.widthPct(16)),
        border: Border.all(color: Colors.orange.shade200, width: 2),
        boxShadow: const [
          BoxShadow(
              color: Colors.black12, blurRadius: 10, offset: Offset(0, 4)),
        ],
      ),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(
                horizontal: context.widthPct(16),
                vertical: context.heightPct(10)),
            decoration: BoxDecoration(
                border:
                    Border(bottom: BorderSide(color: AppColors.grey100))),
            child: Row(
              children: [
                Icon(Icons.bolt, color: Colors.orange, size: 18),
                SizedBox(width: 4),
                Expanded(
                  child: Text('PRIORITY REQUEST',
                      overflow: TextOverflow.ellipsis,
                      style: AppTextStyles.caption(context).copyWith(
                          color: Colors.orange,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.1)),
                ),
                Text(
                    trip.distanceMeters != null
                        ? '${(trip.distanceMeters! / 1000).toStringAsFixed(1)} km'
                        : '',
                    style: AppTextStyles.caption(context)
                        .copyWith(color: AppColors.textSecondary)),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.all(context.widthPct(16)),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('RIDER',
                              style: TextStyle(
                                  fontSize: 10,
                                  color: AppColors.textSecondary,
                                  fontWeight: FontWeight.bold)),
                          Row(
                            children: [
                              Flexible(
                                child: Text(trip.riderName ?? 'Rider',
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: AppTextStyles.bodyMedium(context)
                                        .copyWith(
                                            fontWeight: FontWeight.bold)),
                              ),
                              SizedBox(width: 8),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 4, vertical: 2),
                                decoration: BoxDecoration(
                                    color: AppColors.grey100,
                                    borderRadius: BorderRadius.circular(4)),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                        trip.riderRating
                                                ?.toStringAsFixed(1) ??
                                            '--',
                                        style: TextStyle(
                                            fontSize: 10,
                                            fontWeight: FontWeight.bold)),
                                    Icon(Icons.star,
                                        size: 10, color: Colors.blueGrey),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text('EARNINGS',
                            style: TextStyle(
                                fontSize: 10,
                                color: AppColors.textSecondary,
                                fontWeight: FontWeight.bold)),
                        Text(
                            trip.fare != null
                                ? 'EGP ${trip.fare!.toStringAsFixed(0)}'
                                : '--',
                            style: AppTextStyles.h3(context).copyWith(
                                color: AppColors.primary,
                                fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: context.heightPct(16)),
                _routeBox(context, trip),
                SizedBox(height: context.heightPct(16)),
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          foregroundColor: AppColors.textSecondary,
                          side: BorderSide(color: AppColors.grey200),
                          padding: EdgeInsets.symmetric(
                              vertical: context.heightPct(14)),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8)),
                        ),
                        onPressed: accepting
                            ? null
                            : () => context
                                .read<DriverDispatchCubit>()
                                .dismiss(trip.id),
                        child: Text('Decline',
                            style: TextStyle(fontWeight: FontWeight.bold)),
                      ),
                    ),
                    SizedBox(width: context.widthPct(12)),
                    Expanded(
                      flex: 2,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primary,
                          padding: EdgeInsets.symmetric(
                              vertical: context.heightPct(14)),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8)),
                        ),
                        onPressed: accepting
                            ? null
                            : () => context
                                .read<DriverDispatchCubit>()
                                .accept(trip.id),
                        child: accepting
                            ? const SizedBox(
                                width: 20,
                                height: 20,
                                child: CircularProgressIndicator(
                                    strokeWidth: 2, color: Colors.white))
                            : Text('ACCEPT',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 1.1)),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _routeColumn(BuildContext context, TripModel trip) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: [
            Icon(Icons.circle, color: AppColors.primary, size: 10),
            Container(width: 2, height: 30, color: AppColors.grey200),
            Icon(Icons.circle, color: Colors.black, size: 10),
          ],
        ),
        SizedBox(width: context.widthPct(12)),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('PICKUP',
                  style: AppTextStyles.caption(context)
                      .copyWith(color: AppColors.textSecondary)),
              Text(trip.origin?.address ?? 'Pickup location',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: AppTextStyles.bodyMedium(context)
                      .copyWith(fontWeight: FontWeight.bold)),
              SizedBox(height: context.heightPct(16)),
              Text('DESTINATION',
                  style: AppTextStyles.caption(context)
                      .copyWith(color: AppColors.textSecondary)),
              Text(trip.destination?.address ?? 'Destination',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: AppTextStyles.bodyMedium(context)
                      .copyWith(fontWeight: FontWeight.bold)),
            ],
          ),
        ),
      ],
    );
  }

  Widget _routeBox(BuildContext context, TripModel trip) {
    return Container(
      padding: EdgeInsets.all(context.widthPct(12)),
      decoration: BoxDecoration(
          color: AppColors.grey50, borderRadius: BorderRadius.circular(8)),
      child: Column(
        children: [
          Row(
            children: [
              Icon(Icons.radio_button_unchecked,
                  color: AppColors.primary, size: 14),
              SizedBox(width: 8),
              Expanded(
                child: Text(trip.origin?.address ?? 'Pickup',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: AppTextStyles.bodySmall(context)),
              ),
            ],
          ),
          SizedBox(height: 8),
          Row(
            children: [
              Icon(Icons.location_on_outlined, color: Colors.black, size: 14),
              SizedBox(width: 8),
              Expanded(
                child: Text(trip.destination?.address ?? 'Destination',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: AppTextStyles.bodySmall(context)),
              ),
            ],
          ),
        ],
      ),
    );
  }

}
