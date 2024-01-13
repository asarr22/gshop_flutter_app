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
    this.strokeAlign = BorderSide.strokeAlignInside,
    this.elevation = 0,
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
  final double strokeAlign;
  final double elevation;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      elevation: elevation,
      borderRadius: BorderRadius.circular(radius),
      child: Container(
        width: width,
        height: height,
        padding: padding,
        margin: margin,
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(radius),
          border: showBorder ? Border.all(color: borderColor, width: borderThickness, strokeAlign: strokeAlign) : null,
          boxShadow: boxShadow,
        ),
        child: child,
      ),
    );
  }
}
