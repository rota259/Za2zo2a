import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../core/utils/responsive.dart';
import '../cubit/home_cubit.dart';
import '../cubit/home_state.dart';
import 'widgets/app_drawer.dart';
import 'widgets/where_to_sheet.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeState>(
      listener: (context, state) {},
      builder: (context, state) {
        final bool hasDestination = state is HomeLoaded &&
            state.selectedDestination != null &&
            state.selectedDestination!.isNotEmpty;
        final HomeLoaded? homeLoaded = state is HomeLoaded ? state : null;

        return Scaffold(
          key: _scaffoldKey,
          drawer: const AppDrawer(),
          body: Stack(
            children: [
              // ── Map placeholder
              Container(
                color: const Color(0xFFCDD5BF), // muted map green like screenshot
                child: Stack(
                  children: [
                    // Subtle grid hint
                    Positioned.fill(
                      child: CustomPaint(painter: _MapGridPainter()),
                    ),
                    if (hasDestination) ...[
                      Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.my_location, color: AppColors.primary, size: context.widthPct(32)),
                            Container(width: context.widthPct(60), height: 3, color: AppColors.textPrimary),
                            Icon(Icons.location_on, color: AppColors.error, size: context.widthPct(40)),
                          ],
                        ),
                      ),
                    ],
                  ],
                ),
              ),

              // ── Top bar: Hamburger logo + bell + safety
              Positioned(
                top: context.heightPct(50),
                left: context.widthPct(16),
                right: context.widthPct(16),
                child: Row(
                  children: [
                    // Logo + menu
                    GestureDetector(
                      onTap: () => _scaffoldKey.currentState?.openDrawer(),
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: context.widthPct(14),
                          vertical: context.heightPct(10),
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.primary,
                          borderRadius: BorderRadius.circular(context.widthPct(10)),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.menu, color: Colors.white, size: context.widthPct(20)),
                            SizedBox(width: context.widthPct(8)),
                            Text(
                              'Za2zo2a',
                              style: AppTextStyles.bodyLarge(context).copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const Spacer(),
                    // Bell
                    _MapButton(icon: Icons.notifications_none_outlined, onTap: () {}),
                    SizedBox(width: context.widthPct(8)),
                    // GPS
                    _MapButton(icon: Icons.gps_fixed, onTap: () {}),
                    SizedBox(width: context.widthPct(8)),
                    // Safety badge
                    GestureDetector(
                      onTap: () {},
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: context.widthPct(12),
                          vertical: context.heightPct(10),
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.background,
                          borderRadius: BorderRadius.circular(context.widthPct(10)),
                          boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 6)],
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.shield_outlined, color: AppColors.primary, size: context.widthPct(18)),
                            SizedBox(width: context.widthPct(4)),
                            Text('Safety',
                                style: AppTextStyles.bodySmall(context)
                                    .copyWith(fontWeight: FontWeight.bold, color: AppColors.textPrimary)),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // ── Map marker pins (decorative)
              Positioned(
                top: context.heightPct(185),
                left: context.widthPct(90),
                child: _MapPin(label: 'A', color: AppColors.primary),
              ),
              Positioned(
                top: context.heightPct(255),
                right: context.widthPct(130),
                child: _MapPin(label: 'B', color: AppColors.textPrimary),
              ),

              // ── Bottom sheet
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: hasDestination && homeLoaded != null
                    ? _DestinationSheet(state: homeLoaded)
                    : const WhereToSheet(),
              ),
            ],
          ),
        );
      },
    );
  }
}

// ── Map floating button
class _MapButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;
  const _MapButton({required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(context.widthPct(10)),
        decoration: BoxDecoration(
          color: AppColors.background,
          shape: BoxShape.circle,
          boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 6)],
        ),
        child: Icon(icon, size: context.widthPct(20), color: AppColors.textPrimary),
      ),
    );
  }
}

// ── Map decorative pin
class _MapPin extends StatelessWidget {
  final String label;
  final Color color;
  const _MapPin({required this.label, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: context.widthPct(32),
      height: context.widthPct(32),
      decoration: BoxDecoration(color: color, shape: BoxShape.circle),
      child: Center(
        child: Text(label,
            style: TextStyle(
              color: Colors.white,
              fontSize: context.fontPct(13),
              fontWeight: FontWeight.bold,
            )),
      ),
    );
  }
}

// ── Destination confirmed sheet
class _DestinationSheet extends StatelessWidget {
  final HomeLoaded state;
  const _DestinationSheet({required this.state});

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
        borderRadius: BorderRadius.vertical(top: Radius.circular(context.widthPct(24))),
        boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 12, spreadRadius: 2)],
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
                decoration: BoxDecoration(color: AppColors.grey300, borderRadius: BorderRadius.circular(2)),
              ),
            ),
            SizedBox(height: context.heightPct(20)),
            Row(
              children: [
                Icon(Icons.location_on, color: AppColors.error, size: context.widthPct(28)),
                SizedBox(width: context.widthPct(12)),
                Expanded(child: Text(state.selectedDestination!, style: AppTextStyles.h2(context))),
                IconButton(
                  icon: Icon(Icons.close, color: AppColors.textSecondary),
                  onPressed: () => context.read<HomeCubit>().selectDestination(null),
                ),
              ],
            ),
            SizedBox(height: context.heightPct(20)),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  padding: EdgeInsets.symmetric(vertical: context.heightPct(18)),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(context.widthPct(50))),
                ),
                onPressed: () => context.push('/home/ride-selection'),
                child: Text('Confirm & Request Ride',
                    style: AppTextStyles.button(context).copyWith(color: Colors.white, fontWeight: FontWeight.bold)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ── Subtle grid painter for map feel
class _MapGridPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withOpacity(0.15)
      ..strokeWidth = 1;
    const spacing = 40.0;
    for (double x = 0; x < size.width; x += spacing) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), paint);
    }
    for (double y = 0; y < size.height; y += spacing) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
