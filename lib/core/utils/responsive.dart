import 'package:flutter/material.dart';

extension ResponsiveContext on BuildContext {
  double get screenHeight => MediaQuery.of(this).size.height;
  double get screenWidth => MediaQuery.of(this).size.width;

  /// Scales width proportionally based on the primary 390px Figma width design
  double widthPct(double px) => (px / 390) * screenWidth;

  /// Scales height proportionally based on the primary 844px Figma height design
  double heightPct(double px) => (px / 844) * screenHeight;

  /// Keeps a uniform scale for text based on width, but applies a clamp
  /// so it doesn't get ridiculously large on tablets or small on tiny screens
  double fontPct(double px) {
    double scale = screenWidth / 390;
    // Don't shrink fonts too small or grow them too big
    scale = scale.clamp(0.8, 1.2);
    return px * scale;
  }
}
