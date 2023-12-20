import 'package:flutter/material.dart';
import 'package:gshopp_flutter/utils/constants/color_palette.dart';

class RoundedContainer extends StatelessWidget {
  const RoundedContainer({
    super.key,
    this.child,
    this.width,
    this.height,
    this.margin,
    this.padding,
    this.showBorder = false,
    this.radius = 16,
    this.backgroundColor = ColorPalette.backgroundLight,
    this.borderColor = Colors.orange,
    this.borderThickness = 1,
    this.boxShadow,
  });

  final double? width;
  final double? height;
  final double radius;
  final Widget? child;
  final bool showBorder;
  final Color borderColor;
  final Color backgroundColor;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final double borderThickness;
  final List<BoxShadow>? boxShadow;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      padding: padding,
      margin: margin,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(radius),
        border: showBorder
            ? Border.all(color: borderColor, width: borderThickness)
            : null,
        boxShadow: boxShadow,
      ),
      child: child,
    );
  }
}
