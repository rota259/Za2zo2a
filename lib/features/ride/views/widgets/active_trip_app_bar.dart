import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../../../core/utils/responsive.dart';
import '../../cubit/ride_cubit.dart';
import '../../cubit/ride_state.dart';

class ActiveTripAppBar extends StatelessWidget {
  const ActiveTripAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: context.heightPct(40),
      left: 0,
      right: 0,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: context.widthPct(8)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              icon: Icon(Icons.arrow_back, color: AppColors.primary),
              onPressed: () {
                context.read<RideCubit>().cancelRide();
              },
            ),
            Text(
              'Ride in Progress',
              style: AppTextStyles.h2(
                context,
              ).copyWith(fontWeight: FontWeight.bold),
            ),
            IconButton(
              icon: Icon(Icons.more_vert, color: AppColors.primary),
              onPressed: () {
                final state = context.read<RideCubit>().state;
                if (state is RideActive) {
                  context.read<RideCubit>().endTrip(state.activeRide);
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
