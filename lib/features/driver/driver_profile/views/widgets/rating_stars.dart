import 'package:flutter/material.dart';

/// Displays a 5-star rating from an average score (0–5).
class RatingStars extends StatelessWidget {
  final double rating;
  final double size;
  final Color activeColor;
  final Color inactiveColor;

  const RatingStars({
    super.key,
    required this.rating,
    this.size = 14,
    this.activeColor = Colors.amber,
    this.inactiveColor = const Color(0xFFE0E0E0),
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(5, (index) {
        final starValue = rating - index;
        IconData icon;
        if (starValue >= 1) {
          icon = Icons.star;
        } else if (starValue >= 0.5) {
          icon = Icons.star_half;
        } else {
          icon = Icons.star_border;
        }
        return Icon(
          icon,
          size: size,
          color: starValue >= 0.5 ? activeColor : inactiveColor,
        );
      }),
    );
  }
}
