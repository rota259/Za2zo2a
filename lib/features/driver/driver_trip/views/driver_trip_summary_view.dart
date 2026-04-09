import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../../../core/utils/responsive.dart';
import '../cubit/driver_trip_cubit.dart';
import '../cubit/driver_trip_state.dart';

class DriverTripSummaryView extends StatefulWidget {
  const DriverTripSummaryView({super.key});

  @override
  State<DriverTripSummaryView> createState() => _DriverTripSummaryViewState();
}

class _DriverTripSummaryViewState extends State<DriverTripSummaryView> {
  double _riderRating = 5.0;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DriverTripCubit, DriverTripState>(
      listener: (context, state) {
        if (state is DriverTripInitial) {
          context.go('/driver/home');
        }
      },
      builder: (context, state) {
        return Scaffold(
          backgroundColor: AppColors.background,
          body: SafeArea(
            child: Column(
              children: [
                // Top AppBar
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
                        child: Icon(
                          Icons.person,
                          color: Colors.amber.shade200,
                          size: context.widthPct(20),
                        ),
                      ),
                      SizedBox(width: context.widthPct(12)),
                      Text(
                        'VoltRide',
                        style: AppTextStyles.h2(context).copyWith(
                          fontWeight: FontWeight.bold,
                          fontSize: context.fontPct(20),
                        ),
                      ),
                      const Spacer(),
                      Icon(Icons.sensors, color: AppColors.primary, size: 20),
                    ],
                  ),
                ),

                Expanded(
                  child: SingleChildScrollView(
                    padding: EdgeInsets.symmetric(
                      horizontal: context.widthPct(24),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(height: context.heightPct(40)),

                        // Checkmark Icon
                        Container(
                          padding: EdgeInsets.all(context.widthPct(12)),
                          decoration: BoxDecoration(
                            color: AppColors.primary.withValues(alpha: 0.1),
                            shape: BoxShape.circle,
                          ),
                          child: Container(
                            padding: EdgeInsets.all(context.widthPct(16)),
                            decoration: BoxDecoration(
                              color: AppColors.primary,
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              Icons.check,
                              color: Colors.white,
                              size: context.widthPct(30),
                            ),
                          ),
                        ),
                        SizedBox(height: context.heightPct(24)),

                        Text(
                          'Trip Ended',
                          style: AppTextStyles.h1(
                            context,
                          ).copyWith(fontWeight: FontWeight.w900),
                        ),
                        SizedBox(height: context.heightPct(8)),
                        Text(
                          'How was your experience with the rider?',
                          style: AppTextStyles.bodyMedium(
                            context,
                          ).copyWith(color: AppColors.textSecondary),
                        ),
                        SizedBox(height: context.heightPct(32)),

                        // Rider Box
                        Container(
                          padding: EdgeInsets.all(context.widthPct(16)),
                          decoration: BoxDecoration(
                            color: AppColors.grey50,
                            borderRadius: BorderRadius.circular(
                              context.widthPct(16),
                            ),
                          ),
                          child: Row(
                            children: [
                              CircleAvatar(
                                radius: context.widthPct(24),
                                backgroundColor: Colors.blueGrey.shade900,
                                child: Text(
                                  'E',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                  ),
                                ),
                              ),
                              SizedBox(width: context.widthPct(16)),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Elena Rodriguez',
                                    style: AppTextStyles.h3(
                                      context,
                                    ).copyWith(fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    'RIDER SINCE 2022',
                                    style: TextStyle(
                                      fontSize: 10,
                                      color: AppColors.textSecondary,
                                      fontWeight: FontWeight.bold,
                                      letterSpacing: 0.5,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: context.heightPct(32)),

                        // Rating Stars
                        RatingBar.builder(
                          initialRating: 4,
                          minRating: 1,
                          direction: Axis.horizontal,
                          allowHalfRating: true,
                          itemCount: 5,
                          itemSize: context.widthPct(40),
                          itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                          itemBuilder: (context, _) =>
                              Icon(Icons.star, color: Colors.orange),
                          onRatingUpdate: (rating) {
                            setState(() => _riderRating = rating);
                          },
                        ),
                        SizedBox(height: context.heightPct(12)),
                        Text(
                          'GREAT PERFORMANCE',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.orange,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1.0,
                          ),
                        ),
                        SizedBox(height: context.heightPct(32)),

                        // Optional Feedback
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'OPTIONAL FEEDBACK',
                            style: TextStyle(
                              fontSize: 10,
                              color: AppColors.textSecondary,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        SizedBox(height: context.heightPct(8)),
                        TextField(
                          maxLines: 3,
                          decoration: InputDecoration(
                            hintText: 'Tell us about the trip...',
                            hintStyle: TextStyle(color: AppColors.grey400),
                            filled: true,
                            fillColor: AppColors.grey50,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide.none,
                            ),
                          ),
                        ),
                        SizedBox(height: context.heightPct(16)),

                        // Tags
                        Wrap(
                          spacing: 8,
                          runSpacing: 8,
                          children: [
                            _FeedbackTag('Punctual'),
                            _FeedbackTag('Polite'),
                            _FeedbackTag('Quiet'),
                            _FeedbackTag('Good Vibes'),
                          ],
                        ),
                        SizedBox(height: context.heightPct(40)),

                        // Submit Button
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.primary,
                              padding: EdgeInsets.symmetric(
                                vertical: context.heightPct(16),
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            onPressed: () {
                              context.read<DriverTripCubit>().reset();
                            },
                            child: Text(
                              'Submit Review >',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: context.heightPct(24)),
                      ],
                    ),
                  ),
                ),
                _buildBottomNavMenu(context),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildBottomNavMenu(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 10,
            offset: Offset(0, -2),
          ),
        ],
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _NavIcon(
                icon: Icons.dashboard_outlined,
                label: 'HOME',
                onTap: () => context.go('/driver/home'),
              ),
              _NavIcon(
                icon: Icons.account_balance_wallet_outlined,
                label: 'EARNINGS',
                onTap: () => context.go('/driver/earnings'),
              ),
              _NavIcon(
                icon: Icons.rocket_launch_outlined,
                label: 'BOOSTER',
                isActive: true,
                onTap: () {},
              ),
              _NavIcon(
                icon: Icons.person_outline,
                label: 'PROFILE',
                onTap: () => context.go('/driver/profile'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _FeedbackTag extends StatelessWidget {
  final String label;
  const _FeedbackTag(this.label);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.grey200),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.bold,
          color: Colors.black87,
        ),
      ),
    );
  }
}

class _NavIcon extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isActive;
  final VoidCallback onTap;

  const _NavIcon({
    required this.icon,
    required this.label,
    this.isActive = false,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            color: isActive ? AppColors.primary : AppColors.grey400,
            size: context.widthPct(24),
          ),
          SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: context.fontPct(9),
              color: isActive ? AppColors.primary : AppColors.grey400,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
