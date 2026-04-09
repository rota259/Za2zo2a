import 'package:flutter/material.dart';

import '../../../../../core/constants/app_colors.dart';

class MapUserLocationMarker extends StatefulWidget {
  const MapUserLocationMarker({super.key});

  @override
  State<MapUserLocationMarker> createState() => _MapUserLocationMarkerState();
}

class _MapUserLocationMarkerState extends State<MapUserLocationMarker>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1800),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        final pulseScale = 1 + (_controller.value * 1.1);
        final pulseOpacity = 0.35 * (1 - _controller.value);

        return Center(
          child: SizedBox(
            width: 70,
            height: 70,
            child: Stack(
              alignment: Alignment.center,
              children: [
                Transform.scale(
                  scale: pulseScale,
                  child: Opacity(
                    opacity: pulseOpacity,
                    child: Container(
                      width: 34,
                      height: 34,
                      decoration: BoxDecoration(
                        color: AppColors.info,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                ),
                Container(
                  width: 22,
                  height: 22,
                  decoration: BoxDecoration(
                    color: AppColors.info,
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white, width: 4),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 10,
                        offset: Offset(0, 4),
                      ),
                    ],
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

class MapDestinationMarker extends StatelessWidget {
  const MapDestinationMarker({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 44,
          height: 44,
          decoration: BoxDecoration(
            color: AppColors.error,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Colors.white, width: 2),
            boxShadow: const [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 12,
                offset: Offset(0, 5),
              ),
            ],
          ),
          child: const Icon(Icons.place_rounded, color: Colors.white),
        ),
        Container(
          width: 4,
          height: 16,
          decoration: BoxDecoration(
            color: AppColors.error,
            borderRadius: BorderRadius.circular(999),
          ),
        ),
      ],
    );
  }
}
