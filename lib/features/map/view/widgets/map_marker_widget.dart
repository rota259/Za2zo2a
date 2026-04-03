import 'package:flutter/material.dart';
import '../../../../../core/constants/app_colors.dart';

enum MarkerType { user, destination, driver }

class MapMarkerWidget extends StatelessWidget {
  final MarkerType type;
  final double size;

  const MapMarkerWidget({super.key, required this.type, this.size = 40.0});

  @override
  Widget build(BuildContext context) {
    return _buildMarker();
  }

  Widget _buildMarker() {
    switch (type) {
      case MarkerType.user:
        return Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            color: AppColors.primary,
            shape: BoxShape.circle,
            border: Border.all(color: Colors.white, width: 3),
            boxShadow: const [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 6,
                offset: Offset(0, 3),
              ),
            ],
          ),
          child: const Center(
            child: Icon(Icons.person, color: Colors.white, size: 20),
          ),
        );
      case MarkerType.destination:
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: AppColors.error,
                borderRadius: BorderRadius.circular(8),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 4,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: const Icon(Icons.flag, color: Colors.white, size: 20),
            ),
            Container(width: 3, height: 12, color: AppColors.error),
            Container(
              width: 8,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.black45,
                borderRadius: BorderRadius.circular(4),
              ),
            ),
          ],
        );
      case MarkerType.driver:
        return Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            color: const Color(0xFF2C3E50),
            shape: BoxShape.circle,
            border: Border.all(color: Colors.amber, width: 2),
            boxShadow: const [
              BoxShadow(
                color: Colors.black45,
                blurRadius: 8,
                offset: Offset(0, 4),
              ),
            ],
          ),
          child: const Center(
            child: Icon(Icons.directions_car, color: Colors.white, size: 20),
          ),
        );
    }
  }
}
