import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../../../core/utils/responsive.dart';
import '../../cubit/home_cubit.dart';
import '../../cubit/home_state.dart';

class DestinationSheet extends StatelessWidget {
  final HomeLoaded state;
  const DestinationSheet({super.key, required this.state});

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
                    state.selectedDestination!,
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
                onPressed: () => context.push('/home/ride-selection'),
                child: Text(
                  'Confirm & Request Ride',
                  style: AppTextStyles.button(
                    context,
                  ).copyWith(color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
