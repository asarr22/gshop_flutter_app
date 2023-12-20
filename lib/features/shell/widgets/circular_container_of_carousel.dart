import 'package:flutter/material.dart';

class CircularContainer extends StatelessWidget {
  const CircularContainer({
    super.key,
    this.height = 400,
    this.width = 400,
    this.padding = 0,
    this.margin,
    this.radius = 400,
    this.child,
    this.backgroundColor = Colors.white,
  });

  final double? height;
  final double? width;
  final double padding;
  final EdgeInsetsGeometry? margin;
  final double radius;
  final Widget? child;
  final Color backgroundColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      margin: margin,
      padding: EdgeInsets.all(padding),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radius),
        color: backgroundColor,
      ),
      child: child,
    );
  }
}
