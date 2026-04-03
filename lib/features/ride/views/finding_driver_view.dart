import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import '../../../../../core/constants/app_colors.dart';
import '../../../../../core/constants/app_text_styles.dart';
import '../../../../../core/utils/responsive.dart';
import '../../../../../core/services/location_service.dart';

class FindingDriverView extends StatefulWidget {
  const FindingDriverView({super.key});

  @override
  State<FindingDriverView> createState() => _FindingDriverViewState();
}

class _FindingDriverViewState extends State<FindingDriverView>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _opacityAnimation;
  final MapController _mapController = MapController();
  LatLng _currentLocation = const LatLng(30.0444, 31.2357);

  @override
  void initState() {
    super.initState();
    _getUserLocation();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat();
    _scaleAnimation = Tween<double>(
      begin: 0.5,
      end: 1.5,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutQuad));
    _opacityAnimation = Tween<double>(
      begin: 1.0,
      end: 0.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutQuad));

    Future.delayed(const Duration(seconds: 4), () {
      if (mounted) context.pushReplacement('/home/active-trip');
    });
  }

  Future<void> _getUserLocation() async {
    try {
      final pos = await LocationService.getCurrentLocation();
      setState(() => _currentLocation = LatLng(pos.latitude, pos.longitude));
      _mapController.move(_currentLocation, 15.0);
    } catch (e) {
      debugPrint('Error: $e');
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          FlutterMap(
            mapController: _mapController,
            options: MapOptions(
              initialCenter: _currentLocation,
              initialZoom: 15.0,
            ),
            children: [
              TileLayer(
                urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                userAgentPackageName: 'com.example',
              ),
            ],
          ),
          Container(color: AppColors.background.withOpacity(0.85)),
          SafeArea(
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.all(context.widthPct(16)),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: IconButton(
                      icon: const Icon(Icons.close),
                      onPressed: () => context.pop(),
                    ),
                  ),
                ),
                const Spacer(),
                Center(
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      AnimatedBuilder(
                        animation: _controller,
                        builder: (context, child) => Transform.scale(
                          scale: _scaleAnimation.value,
                          child: Opacity(
                            opacity: _opacityAnimation.value,
                            child: Container(
                              width: context.widthPct(150),
                              height: context.widthPct(150),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: AppColors.primary.withOpacity(0.5),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        width: context.widthPct(80),
                        height: context.widthPct(80),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColors.primary,
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.black26,
                              blurRadius: 10,
                              spreadRadius: 2,
                            ),
                          ],
                        ),
                        child: const Icon(
                          Icons.search,
                          color: Colors.white,
                          size: 40,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: context.heightPct(40)),
                Text(
                  'Finding the fastest driver\nfor your route...',
                  textAlign: TextAlign.center,
                  style: AppTextStyles.h2(context).copyWith(height: 1.4),
                ),
                SizedBox(height: context.heightPct(16)),
                Text(
                  'Please wait while we connect you to the best drivers nearby.',
                  textAlign: TextAlign.center,
                  style: AppTextStyles.bodyMedium(
                    context,
                  ).copyWith(color: AppColors.textSecondary),
                ),
                const Spacer(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
