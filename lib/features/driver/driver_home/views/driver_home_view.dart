import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../../../core/utils/responsive.dart';
import '../cubit/driver_home_cubit.dart';
import '../cubit/driver_home_state.dart';
import '../data/models/ride_request_model.dart';
import '../../driver_trip/cubit/driver_trip_cubit.dart';
import '../../driver_trip/data/models/driver_trip_model.dart';

class DriverHomeView extends StatefulWidget {
  const DriverHomeView({super.key});

  @override
  State<DriverHomeView> createState() => _DriverHomeViewState();
}

class _DriverHomeViewState extends State<DriverHomeView> {

  void _onTabTapped(BuildContext context, int index) {
    if (index == 0) return; // Already on home
    if (index == 1) context.go('/driver/earnings');
    if (index == 2) context.go('/driver/trips');
    if (index == 3) context.go('/driver/profile');
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DriverHomeCubit, DriverHomeState>(
      listener: (context, state) {
        if (state is DriverHomeRequestAccepted) {
          final req = state.request;
          final trip = DriverTripModel(
            id: req.id,
            riderName: req.riderName,
            riderPhoto: req.riderPhoto,
            riderRating: req.riderRating,
            pickupAddress: req.pickupAddress,
            destinationAddress: req.destinationAddress,
            distanceKm: req.distanceKm,
            durationMinutes: req.estimatedMinutes,
            fare: req.fare,
            paymentMethod: req.paymentMethod,
            rideType: req.rideType,
            status: 'heading_to_pickup',
            createdAt: DateTime.now(),
          );
          context.read<DriverTripCubit>().startHeadingToPickup(trip);
          context.push('/driver/active-trip');
        }
      },
      builder: (context, state) {
        final bool isOnline = state is DriverHomeOnline || state is DriverHomeRequestReceived;
        final bool hasRequest = state is DriverHomeRequestReceived;

        return Scaffold(
          backgroundColor: AppColors.grey100,
          body: hasRequest 
              ? _buildAvailableTripsView(context, (state as DriverHomeRequestReceived).request)
              : _buildOfflineOrWaitingView(context, isOnline),
          bottomNavigationBar: _buildBottomNav(context),
        );
      },
    );
  }

  Widget _buildBottomNav(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 10, offset: Offset(0, -2))],
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _NavIcon(icon: Icons.dashboard_outlined, label: 'HOME', isActive: true, onTap: () => _onTabTapped(context, 0)),
              _NavIcon(icon: Icons.account_balance_wallet_outlined, label: 'EARNINGS', onTap: () => _onTabTapped(context, 1)),
              _NavIcon(icon: Icons.rocket_launch_outlined, label: 'BOOSTER', onTap: () => _onTabTapped(context, 2)),
              _NavIcon(icon: Icons.person_outline, label: 'PROFILE', onTap: () => _onTabTapped(context, 3)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildOfflineOrWaitingView(BuildContext context, bool isOnline) {
    return Stack(
      children: [
        // Map Background
        Container(
          color: const Color(0xFFC0C0C0), // Grayish map representation
          child: CustomPaint(
            painter: _MapGridPainter(),
            size: Size.infinite,
          ),
        ),
        
        // Location Pin (Center)
        Center(
          child: Container(
            width: context.widthPct(40),
            height: context.widthPct(40),
            decoration: BoxDecoration(
              color: AppColors.primary.withOpacity(0.2),
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Container(
                width: context.widthPct(16),
                height: context.widthPct(16),
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white, width: 2),
                ),
              ),
            ),
          ),
        ),

        SafeArea(
          child: Column(
            children: [
              // Custom Top App Bar
              Padding(
                padding: EdgeInsets.symmetric(horizontal: context.widthPct(16), vertical: context.heightPct(12)),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: context.widthPct(18),
                      backgroundColor: Colors.blueGrey.shade800,
                      child: Icon(Icons.person, color: Colors.amber.shade200, size: context.widthPct(20)),
                    ),
                    SizedBox(width: context.widthPct(12)),
                    Text(
                      'VoltRide',
                      style: AppTextStyles.h2(context).copyWith(fontWeight: FontWeight.bold, fontSize: context.fontPct(22)),
                    ),
                    const Spacer(),
                    if (isOnline)
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: context.widthPct(12), vertical: context.heightPct(6)),
                        decoration: BoxDecoration(
                          color: AppColors.primary.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(context.widthPct(20)),
                        ),
                        child: Row(
                          children: [
                            Icon(Icons.sensors, color: AppColors.primary, size: context.widthPct(14)),
                            SizedBox(width: context.widthPct(4)),
                            Text('ONLINE', style: AppTextStyles.caption(context).copyWith(color: AppColors.primary, fontWeight: FontWeight.bold)),
                          ],
                        ),
                      )
                    else
                      Icon(Icons.sensors_off, color: AppColors.grey500),
                  ],
                ),
              ),

              // Stats Row
              Padding(
                padding: EdgeInsets.symmetric(horizontal: context.widthPct(16)),
                child: Row(
                  children: [
                    _TopStatBox(title: 'EARNINGS', value: '\$142.50'),
                    SizedBox(width: context.widthPct(8)),
                    _TopStatBox(title: 'TRIPS', value: '12'),
                    SizedBox(width: context.widthPct(8)),
                    _TopStatBox(title: 'ONLINE', value: '5h 22m'),
                  ],
                ),
              ),
              SizedBox(height: context.heightPct(16)),

              // Bonus Card
              Padding(
                padding: EdgeInsets.symmetric(horizontal: context.widthPct(16)),
                child: Container(
                  padding: EdgeInsets.all(context.widthPct(16)),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(context.widthPct(16)),
                    border: Border.all(color: Colors.orange.shade200),
                    boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 8, offset: Offset(0, 4))],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.auto_awesome, color: Colors.orange, size: context.widthPct(16)),
                          SizedBox(width: context.widthPct(6)),
                          Text('TODAY\'S BONUS', style: AppTextStyles.caption(context).copyWith(color: Colors.orange, fontWeight: FontWeight.bold, letterSpacing: 1.1)),
                        ],
                      ),
                      SizedBox(height: context.heightPct(8)),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('+\$10 for 5 more rides', style: AppTextStyles.h3(context).copyWith(fontWeight: FontWeight.bold)),
                          Container(
                            padding: EdgeInsets.all(context.widthPct(6)),
                            decoration: BoxDecoration(color: Colors.orange.shade50, shape: BoxShape.circle),
                            child: Icon(Icons.flash_on, color: Colors.orange, size: context.widthPct(16)),
                          ),
                        ],
                      ),
                      SizedBox(height: context.heightPct(12)),
                      Text('3/5 COMPLETED', style: AppTextStyles.caption(context).copyWith(color: AppColors.textSecondary, fontWeight: FontWeight.bold)),
                      SizedBox(height: context.heightPct(6)),
                      LinearProgressIndicator(
                        value: 0.6,
                        backgroundColor: AppColors.grey200,
                        valueColor: const AlwaysStoppedAnimation<Color>(Colors.orange),
                        minHeight: 6,
                        borderRadius: BorderRadius.circular(3),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),

        // Bottom Go Online Button
        Positioned(
          bottom: context.heightPct(20),
          left: context.widthPct(30),
          right: context.widthPct(30),
          child: GestureDetector(
            onTap: () {
              if (isOnline) {
                context.read<DriverHomeCubit>().goOffline();
              } else {
                context.read<DriverHomeCubit>().goOnline();
              }
            },
            child: Container(
              height: context.heightPct(60),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: isOnline 
                      ? [Colors.grey.shade700, Colors.grey.shade900]
                      : [AppColors.primary, Colors.pinkAccent.shade400],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                ),
                borderRadius: BorderRadius.circular(context.widthPct(30)),
                boxShadow: [
                  BoxShadow(
                    color: (isOnline ? Colors.grey : AppColors.primary).withOpacity(0.4),
                    blurRadius: 15,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(isOnline ? Icons.power_settings_new : Icons.power_settings_new, color: Colors.white, size: context.widthPct(24)),
                  SizedBox(width: context.widthPct(10)),
                  Text(
                    isOnline ? 'GO OFFLINE' : 'GO ONLINE',
                    style: AppTextStyles.button(context).copyWith(fontWeight: FontWeight.bold, letterSpacing: 1.2),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildAvailableTripsView(BuildContext context, RideRequestModel req) {
    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // AppBar
          Padding(
            padding: EdgeInsets.symmetric(horizontal: context.widthPct(16), vertical: context.heightPct(12)),
            child: Row(
              children: [
                CircleAvatar(
                  radius: context.widthPct(18),
                  backgroundColor: Colors.blueGrey.shade800,
                  child: Icon(Icons.person, color: Colors.amber.shade200, size: context.widthPct(20)),
                ),
                SizedBox(width: context.widthPct(12)),
                Text('VoltRide', style: AppTextStyles.h2(context).copyWith(fontWeight: FontWeight.bold, fontSize: context.fontPct(22))),
                const Spacer(),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: context.widthPct(12), vertical: context.heightPct(6)),
                  decoration: BoxDecoration(
                    color: AppColors.primary.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(context.widthPct(20)),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.sensors, color: AppColors.primary, size: context.widthPct(14)),
                      SizedBox(width: context.widthPct(4)),
                      Text('ONLINE', style: AppTextStyles.caption(context).copyWith(color: AppColors.primary, fontWeight: FontWeight.bold)),
                    ],
                  ),
                ),
              ],
            ),
          ),
          
          Padding(
            padding: EdgeInsets.symmetric(horizontal: context.widthPct(16), vertical: context.heightPct(16)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Available Trips', style: AppTextStyles.h1(context).copyWith(fontWeight: FontWeight.w900)),
                Text('3 high-demand requests nearby', style: AppTextStyles.bodyMedium(context).copyWith(color: AppColors.textSecondary)),
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
                    boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 10, offset: Offset(0, 4))],
                  ),
                  child: Column(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CircleAvatar(
                            radius: context.widthPct(22),
                            backgroundColor: Colors.grey.shade200,
                            backgroundImage: const NetworkImage('https://i.pravatar.cc/100?img=5'), // Dummy avatar
                          ),
                          SizedBox(width: context.widthPct(12)),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Sarah Jenkins', style: AppTextStyles.h3(context).copyWith(fontWeight: FontWeight.bold)),
                                Row(
                                  children: [
                                    Icon(Icons.star, color: Colors.orange, size: context.widthPct(14)),
                                    Text(' 4.9', style: AppTextStyles.caption(context).copyWith(fontWeight: FontWeight.bold)),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: context.widthPct(8), vertical: context.heightPct(4)),
                                decoration: BoxDecoration(color: Colors.orange.shade50, borderRadius: BorderRadius.circular(4)),
                                child: Text('🔥 SURGE 1.4x', style: AppTextStyles.caption(context).copyWith(color: Colors.orange.shade800, fontWeight: FontWeight.bold)),
                              ),
                              SizedBox(height: context.heightPct(6)),
                              Text('\$24.50', style: AppTextStyles.h2(context).copyWith(color: AppColors.primary, fontWeight: FontWeight.bold)),
                              Text('CONSTANT PRICE', style: TextStyle(fontSize: 8, color: AppColors.textSecondary, fontWeight: FontWeight.bold)),
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
                                Text('PICKUP', style: AppTextStyles.caption(context).copyWith(color: AppColors.textSecondary)),
                                Text('Grand Central Terminal, NY', style: AppTextStyles.bodyMedium(context).copyWith(fontWeight: FontWeight.bold)),
                                SizedBox(height: context.heightPct(16)),
                                Text('DESTINATION', style: AppTextStyles.caption(context).copyWith(color: AppColors.textSecondary)),
                                Text('SoHo Boutique District, Broadway', style: AppTextStyles.bodyMedium(context).copyWith(fontWeight: FontWeight.bold)),
                              ],
                            ),
                          )
                        ],
                      ),
                      SizedBox(height: context.heightPct(24)),
                      
                      Row(
                        children: [
                          Expanded(
                            flex: 1,
                            child: OutlinedButton(
                              style: OutlinedButton.styleFrom(
                                foregroundColor: AppColors.textSecondary, side: BorderSide(color: AppColors.grey200),
                                padding: EdgeInsets.symmetric(vertical: context.heightPct(14)),
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                              ),
                              onPressed: () => context.read<DriverHomeCubit>().declineRequest(req.id),
                              child: Text('Decline', style: TextStyle(fontWeight: FontWeight.bold)),
                            ),
                          ),
                          SizedBox(width: context.widthPct(12)),
                          Expanded(
                            flex: 2,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.primary,
                                padding: EdgeInsets.symmetric(vertical: context.heightPct(14)),
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                                elevation: 0,
                              ),
                              onPressed: () => context.read<DriverHomeCubit>().acceptRequest(req.id),
                              child: Text('Accept Trip', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
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
                    border: Border.all(color: Colors.orange.shade200, width: 2),
                    boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 10, offset: Offset(0, 4))],
                  ),
                  child: Column(
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: context.widthPct(16), vertical: context.heightPct(10)),
                        decoration: BoxDecoration(border: Border(bottom: BorderSide(color: AppColors.grey100))),
                        child: Row(
                          children: [
                            Icon(Icons.bolt, color: Colors.orange, size: 18),
                            SizedBox(width: 4),
                            Text('PRIORITY REQUEST', style: AppTextStyles.caption(context).copyWith(color: Colors.orange, fontWeight: FontWeight.bold, letterSpacing: 1.1)),
                            const Spacer(),
                            Text('2 min away', style: AppTextStyles.caption(context).copyWith(color: AppColors.textSecondary)),
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
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('RIDER', style: TextStyle(fontSize: 10, color: AppColors.textSecondary, fontWeight: FontWeight.bold)),
                                    Row(
                                      children: [
                                        Text('Marcus T.', style: AppTextStyles.bodyMedium(context).copyWith(fontWeight: FontWeight.bold)),
                                        SizedBox(width: 8),
                                        Container(
                                          padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                                          decoration: BoxDecoration(color: AppColors.grey100, borderRadius: BorderRadius.circular(4)),
                                          child: Row(
                                            children: [
                                              Text('4.7', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold)),
                                              Icon(Icons.star, size: 10, color: Colors.blueGrey),
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
                                    Text('EARNINGS', style: TextStyle(fontSize: 10, color: AppColors.textSecondary, fontWeight: FontWeight.bold)),
                                    Text('\$18.20', style: AppTextStyles.h3(context).copyWith(color: AppColors.primary, fontWeight: FontWeight.bold)),
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(height: context.heightPct(16)),
                            Container(
                              padding: EdgeInsets.all(context.widthPct(12)),
                              decoration: BoxDecoration(color: AppColors.grey50, borderRadius: BorderRadius.circular(8)),
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Icon(Icons.radio_button_unchecked, color: AppColors.primary, size: 14),
                                      SizedBox(width: 8),
                                      Text('Williamsburg Bridge Plaza', style: AppTextStyles.bodySmall(context)),
                                    ],
                                  ),
                                  SizedBox(height: 8),
                                  Row(
                                    children: [
                                      Icon(Icons.location_on_outlined, color: Colors.black, size: 14),
                                      SizedBox(width: 8),
                                      Text('JFK Terminal 4 - Departures', style: AppTextStyles.bodySmall(context)),
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
                                  padding: EdgeInsets.symmetric(vertical: context.heightPct(14)),
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                                ),
                                onPressed: () => context.read<DriverHomeCubit>().acceptRequest(req.id),
                                child: Text('ACCEPT RAPID RIDE', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, letterSpacing: 1.1)),
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
          )
        ],
      ),
    );
  }
}

class _TopStatBox extends StatelessWidget {
  final String title;
  final String value;
  const _TopStatBox({required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.symmetric(vertical: context.heightPct(12), horizontal: context.widthPct(8)),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(context.widthPct(12)),
          boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 4, offset: Offset(0, 2))],
        ),
        child: Column(
          children: [
            Text(title, style: TextStyle(fontSize: context.fontPct(10), color: AppColors.textSecondary, fontWeight: FontWeight.bold, letterSpacing: 0.5)),
            SizedBox(height: context.heightPct(4)),
            Text(value, style: AppTextStyles.h3(context).copyWith(fontWeight: FontWeight.w900)),
          ],
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

  const _NavIcon({required this.icon, required this.label, this.isActive = false, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: isActive ? AppColors.primary : AppColors.grey400, size: context.widthPct(24)),
          SizedBox(height: context.heightPct(4)),
          Text(label, style: TextStyle(fontSize: context.fontPct(9), color: isActive ? AppColors.primary : AppColors.grey400, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}

class _MapGridPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // Implement Map grid lines
    Paint paint = Paint()..color = Colors.white.withOpacity(0.3)..strokeWidth = 1.0;
    for (double i = 0; i < size.width; i += 30) canvas.drawLine(Offset(i, 0), Offset(i, size.height), paint);
    for (double i = 0; i < size.height; i += 30) canvas.drawLine(Offset(0, i), Offset(size.width, i), paint);

    // Circular concentric rings around center
    Paint ringPaint = Paint()..color = Colors.white.withOpacity(0.4)..style = PaintingStyle.stroke..strokeWidth = 1.5;
    canvas.drawCircle(Offset(size.width / 2, size.height / 2), 60, ringPaint);
    canvas.drawCircle(Offset(size.width / 2, size.height / 2), 120, ringPaint);
    canvas.drawCircle(Offset(size.width / 2, size.height / 2), 180, ringPaint);
    canvas.drawCircle(Offset(size.width / 2, size.height / 2), 240, ringPaint);
    
    // Some mock curved roads
    Path path = Path()..moveTo(0, size.height * 0.4)..quadraticBezierTo(size.width * 0.5, size.height * 0.6, size.width, size.height * 0.2);
    canvas.drawPath(path, ringPaint..strokeWidth = 3);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
