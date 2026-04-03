import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/constants/app_colors.dart';
import '../../../../../core/constants/app_text_styles.dart';
import '../../../../../core/utils/responsive.dart';
import '../data/models/ride_request_model.dart';
import '../cubit/driver_home_cubit.dart';

class DriverAvailableTrips extends StatelessWidget {
  final RideRequestModel req;
  const DriverAvailableTrips({super.key, required this.req});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // AppBar
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
                      fontSize: context.fontPct(22),
                    ),
                  ),
                  const Spacer(),
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: context.widthPct(12),
                      vertical: context.heightPct(6),
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.primary.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(context.widthPct(20)),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.sensors,
                          color: AppColors.primary,
                          size: context.widthPct(14),
                        ),
                        SizedBox(width: context.widthPct(4)),
                        Text(
                          'ONLINE',
                          style: AppTextStyles.caption(context).copyWith(
                            color: AppColors.primary,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: context.widthPct(16),
                vertical: context.heightPct(16),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Available Trips',
                    style: AppTextStyles.h1(
                      context,
                    ).copyWith(fontWeight: FontWeight.w900),
                  ),
                  Text(
                    '3 high-demand requests nearby',
                    style: AppTextStyles.bodyMedium(
                      context,
                    ).copyWith(color: AppColors.textSecondary),
                  ),
                ],
              ),
            ),

            Expanded(
              child: ListView(
                padding: EdgeInsets.symmetric(horizontal: context.widthPct(16)),
                children: [
                  // Highlighted Card
                  Container(
                    margin: EdgeInsets.only(bottom: context.heightPct(16)),
                    padding: EdgeInsets.all(context.widthPct(16)),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(context.widthPct(16)),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 10,
                          offset: Offset(0, 4),
                        ),
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
                              backgroundImage: const NetworkImage(
                                'https://i.pravatar.cc/100?img=5',
                              ), // Dummy avatar
                            ),
                            SizedBox(width: context.widthPct(12)),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Sarah Jenkins',
                                    style: AppTextStyles.h3(
                                      context,
                                    ).copyWith(fontWeight: FontWeight.bold),
                                  ),
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.star,
                                        color: Colors.orange,
                                        size: context.widthPct(14),
                                      ),
                                      Text(
                                        ' 4.9',
                                        style: AppTextStyles.caption(
                                          context,
                                        ).copyWith(fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: context.widthPct(8),
                                    vertical: context.heightPct(4),
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.orange.shade50,
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                  child: Text(
                                    '🔥 SURGE 1.4x',
                                    style: AppTextStyles.caption(context)
                                        .copyWith(
                                          color: Colors.orange.shade800,
                                          fontWeight: FontWeight.bold,
                                        ),
                                  ),
                                ),
                                SizedBox(height: context.heightPct(6)),
                                Text(
                                  '\$24.50',
                                  style: AppTextStyles.h2(context).copyWith(
                                    color: AppColors.primary,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  'CONSTANT PRICE',
                                  style: TextStyle(
                                    fontSize: 8,
                                    color: AppColors.textSecondary,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(height: context.heightPct(20)),

                        // Route
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Column(
                              children: [
                                Icon(
                                  Icons.circle,
                                  color: AppColors.primary,
                                  size: 10,
                                ),
                                Container(
                                  width: 2,
                                  height: 30,
                                  color: AppColors.grey200,
                                ),
                                Icon(
                                  Icons.circle,
                                  color: Colors.black,
                                  size: 10,
                                ),
                              ],
                            ),
                            SizedBox(width: context.widthPct(12)),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'PICKUP',
                                    style: AppTextStyles.caption(
                                      context,
                                    ).copyWith(color: AppColors.textSecondary),
                                  ),
                                  Text(
                                    'Grand Central Terminal, NY',
                                    style: AppTextStyles.bodyMedium(
                                      context,
                                    ).copyWith(fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(height: context.heightPct(16)),
                                  Text(
                                    'DESTINATION',
                                    style: AppTextStyles.caption(
                                      context,
                                    ).copyWith(color: AppColors.textSecondary),
                                  ),
                                  Text(
                                    'SoHo Boutique District, Broadway',
                                    style: AppTextStyles.bodyMedium(
                                      context,
                                    ).copyWith(fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: context.heightPct(24)),

                        Row(
                          children: [
                            Expanded(
                              flex: 1,
                              child: OutlinedButton(
                                style: OutlinedButton.styleFrom(
                                  foregroundColor: AppColors.textSecondary,
                                  side: BorderSide(color: AppColors.grey200),
                                  padding: EdgeInsets.symmetric(
                                    vertical: context.heightPct(14),
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                                onPressed: () => context
                                    .read<DriverHomeCubit>()
                                    .declineRequest(req.id),
                                child: Text(
                                  'Decline',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                            SizedBox(width: context.widthPct(12)),
                            Expanded(
                              flex: 2,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: AppColors.primary,
                                  padding: EdgeInsets.symmetric(
                                    vertical: context.heightPct(14),
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  elevation: 0,
                                ),
                                onPressed: () => context
                                    .read<DriverHomeCubit>()
                                    .acceptRequest(req.id),
                                child: Text(
                                  'Accept Trip',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  // Priority Request Card
                  Container(
                    margin: EdgeInsets.only(bottom: context.heightPct(16)),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(context.widthPct(16)),
                      border: Border.all(
                        color: Colors.orange.shade200,
                        width: 2,
                      ),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 10,
                          offset: Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: context.widthPct(16),
                            vertical: context.heightPct(10),
                          ),
                          decoration: BoxDecoration(
                            border: Border(
                              bottom: BorderSide(color: AppColors.grey100),
                            ),
                          ),
                          child: Row(
                            children: [
                              Icon(Icons.bolt, color: Colors.orange, size: 18),
                              SizedBox(width: 4),
                              Text(
                                'PRIORITY REQUEST',
                                style: AppTextStyles.caption(context).copyWith(
                                  color: Colors.orange,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 1.1,
                                ),
                              ),
                              const Spacer(),
                              Text(
                                '2 min away',
                                style: AppTextStyles.caption(
                                  context,
                                ).copyWith(color: AppColors.textSecondary),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(context.widthPct(16)),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'RIDER',
                                        style: TextStyle(
                                          fontSize: 10,
                                          color: AppColors.textSecondary,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            'Marcus T.',
                                            style:
                                                AppTextStyles.bodyMedium(
                                                  context,
                                                ).copyWith(
                                                  fontWeight: FontWeight.bold,
                                                ),
                                          ),
                                          SizedBox(width: 8),
                                          Container(
                                            padding: const EdgeInsets.symmetric(
                                              horizontal: 4,
                                              vertical: 2,
                                            ),
                                            decoration: BoxDecoration(
                                              color: AppColors.grey100,
                                              borderRadius:
                                                  BorderRadius.circular(4),
                                            ),
                                            child: Row(
                                              children: [
                                                Text(
                                                  '4.7',
                                                  style: TextStyle(
                                                    fontSize: 10,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                Icon(
                                                  Icons.star,
                                                  size: 10,
                                                  color: Colors.blueGrey,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Text(
                                        'EARNINGS',
                                        style: TextStyle(
                                          fontSize: 10,
                                          color: AppColors.textSecondary,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                        '\$18.20',
                                        style: AppTextStyles.h3(context)
                                            .copyWith(
                                              color: AppColors.primary,
                                              fontWeight: FontWeight.bold,
                                            ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              SizedBox(height: context.heightPct(16)),
                              Container(
                                padding: EdgeInsets.all(context.widthPct(12)),
                                decoration: BoxDecoration(
                                  color: AppColors.grey50,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.radio_button_unchecked,
                                          color: AppColors.primary,
                                          size: 14,
                                        ),
                                        SizedBox(width: 8),
                                        Text(
                                          'Williamsburg Bridge Plaza',
                                          style: AppTextStyles.bodySmall(
                                            context,
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 8),
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.location_on_outlined,
                                          color: Colors.black,
                                          size: 14,
                                        ),
                                        SizedBox(width: 8),
                                        Text(
                                          'JFK Terminal 4 - Departures',
                                          style: AppTextStyles.bodySmall(
                                            context,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: context.heightPct(16)),
                              SizedBox(
                                width: double.infinity,
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: AppColors.primary,
                                    padding: EdgeInsets.symmetric(
                                      vertical: context.heightPct(14),
                                    ),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                  onPressed: () => context
                                      .read<DriverHomeCubit>()
                                      .acceptRequest(req.id),
                                  child: Text(
                                    'ACCEPT RAPID RIDE',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      letterSpacing: 1.1,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
  }
}
