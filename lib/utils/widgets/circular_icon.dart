import 'package:flutter/material.dart';
import 'package:gshopp_flutter/utils/constants/color_palette.dart';
import 'package:gshopp_flutter/utils/constants/sizes_values.dart';
import 'package:gshopp_flutter/utils/helpers/helper_fuctions.dart';

class CircularIcon extends StatelessWidget {
  /// A custom Circular Icon widget with a background color.

  /// Properties are:
  /// Container [width], [height], & [backgroundColor].

  /// Icon's [size], [color] & [onPressed]
  const CircularIcon({
    super.key,
    required this.icon,
    this.width,
    this.height,
    this.size = SizesValue.lg,
    this.onPressed,
    this.color,
    this.backgroundColor,
    this.boxShadow,
  });
  final double? width, height, size;
  final IconData icon;
  final Color? color;
  final Color? backgroundColor;
  final VoidCallback? onPressed;
  final List<BoxShadow>? boxShadow;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: backgroundColor != null
            ? backgroundColor!
            : GHelper.isDarkMode(context)
                ? ColorPalette.black.withOpacity(0.8)
                : ColorPalette.white.withOpacity(0.8),
        borderRadius: BorderRadius.circular(100),
        boxShadow: boxShadow,
      ),
      child: Center(
        child: IconButton(onPressed: onPressed, icon: Icon(icon, color: color, size: size)),
      ),
    );
  }
}
