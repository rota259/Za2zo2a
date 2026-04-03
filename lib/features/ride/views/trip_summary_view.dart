import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../../../core/utils/responsive.dart';
import '../../../../core/widgets/custom_button.dart';
import '../cubit/ride_cubit.dart';
import '../cubit/ride_state.dart';

class TripSummaryView extends StatelessWidget {
  const TripSummaryView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RideCubit, RideState>(
      listener: (context, state) {},
      builder: (context, state) {
        if (state is! RideCompleted) {
          return const Scaffold(body: Center(child: Text('No trip data')));
        }

        final ride = state.completedRide;

        return Scaffold(
          backgroundColor: AppColors.background,
          appBar: AppBar(
            backgroundColor: AppColors.background,
            elevation: 0,
            automaticallyImplyLeading: false,
            title: Text('Trip Summary', style: AppTextStyles.h2(context)),
            centerTitle: true,
          ),
          body: SingleChildScrollView(
            padding: EdgeInsets.all(context.widthPct(24)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: context.widthPct(40),
                  backgroundColor: AppColors.success,
                  child: Icon(
                    Icons.check,
                    color: Colors.white,
                    size: context.widthPct(40),
                  ),
                ),
                SizedBox(height: context.heightPct(16)),
                Text('You have arrived!', style: AppTextStyles.h2(context)),
                SizedBox(height: context.heightPct(40)),

                // Receipt Card
                Container(
                  padding: EdgeInsets.all(context.widthPct(24)),
                  decoration: BoxDecoration(
                    color: AppColors.grey50,
                    borderRadius: BorderRadius.circular(context.widthPct(16)),
                    border: Border.all(color: AppColors.grey200),
                  ),
                  child: Column(
                    children: [
                      _ReceiptRow(
                        'Total Price',
                        '\$${ride.price.toStringAsFixed(2)}',
                        isTotal: true,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: context.heightPct(16),
                        ),
                        child: const Divider(),
                      ),
                      const _ReceiptRow('Distance', '8.2 km'), // Dummy data
                      SizedBox(height: context.heightPct(12)),
                      _ReceiptRow('Time', '${ride.durationMinutes} min'),
                      SizedBox(height: context.heightPct(12)),
                      _ReceiptRow('Ride Type', ride.title),
                    ],
                  ),
                ),

                SizedBox(height: context.heightPct(40)),
                CustomButton(
                  text: 'Rate Driver',
                  onPressed: () {
                    context.pushReplacement('/home/driver-rating');
                  },
                ),
                SizedBox(height: context.heightPct(16)),
                TextButton(
                  onPressed: () {
                    context.read<RideCubit>().cancelRide();
                    context.go('/home');
                  },
                  child: Text(
                    'Skip for now',
                    style: AppTextStyles.bodyMedium(context),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _ReceiptRow extends StatelessWidget {
  final String label;
  final String value;
  final bool isTotal;

  const _ReceiptRow(this.label, this.value, {this.isTotal = false});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: isTotal
              ? AppTextStyles.h3(context)
              : AppTextStyles.bodyMedium(
                  context,
                ).copyWith(color: AppColors.textSecondary),
        ),
        Text(
          value,
          style: isTotal
              ? AppTextStyles.h2(context)
              : AppTextStyles.bodyMedium(
                  context,
                ).copyWith(fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
