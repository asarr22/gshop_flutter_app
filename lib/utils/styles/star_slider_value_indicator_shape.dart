import 'package:flutter/material.dart';
import 'dart:math' as math;

class StarValueIndicatorShape extends SliderComponentShape {
  @override
  Size getPreferredSize(bool isEnabled, bool isDiscrete) {
    return const Size.fromRadius(20); // Adjust the radius for size
  }

  @override
  void paint(
    PaintingContext context,
    Offset center, {
    required Animation<double> activationAnimation,
    required Animation<double> enableAnimation,
    required bool isDiscrete,
    required TextPainter labelPainter,
    required RenderBox parentBox,
    required SliderThemeData sliderTheme,
    required TextDirection textDirection,
    required double value,
    required double textScaleFactor,
    required Size sizeWithOverflow,
  }) {
    final Canvas canvas = context.canvas;

    double radius = 22; // Radius for the star

    // Adjust the center to move the star up
    Offset starCenter = center - Offset(0, radius * 2);

    Paint paint = Paint()
      ..color = sliderTheme.valueIndicatorColor ?? Colors.blue
      ..style = PaintingStyle.fill;

    Path path = Path();
    for (int i = 0; i < 5; i++) {
      double angle = (i * 2 * math.pi / 5) - math.pi / 2;
      double x = starCenter.dx + radius * math.cos(angle);
      double y = starCenter.dy + radius * math.sin(angle);
      if (i == 0) {
        path.moveTo(x, y);
      } else {
        path.lineTo(x, y);
      }

      // Inner vertex
      double innerAngle = angle + math.pi / 5;
      x = starCenter.dx + radius / 2 * math.cos(innerAngle);
      y = starCenter.dy + radius / 2 * math.sin(innerAngle);
      path.lineTo(x, y);
    }
    path.close();
    canvas.drawPath(path, paint);

    // Center the text within the star
    labelPainter.paint(canvas, starCenter - Offset(labelPainter.width / 2, labelPainter.height / 2));
  }
}
