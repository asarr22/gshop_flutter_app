import 'package:flutter/material.dart';
import 'package:gshopp_flutter/utils/constants/color_palette.dart';

class ShadowStyle {
  static final verticolProductShadow = BoxShadow(
      color: ColorPalette.darkGrey.withOpacity(0.1),
      blurRadius: 50,
      spreadRadius: 7,
      offset: const Offset(0, 2)); // BoxShadow

  static final horizontolProductShadow = BoxShadow(
      color: ColorPalette.darkGrey.withOpacity(0.1), blurRadius: 50, spreadRadius: 7, offset: const Offset(0, 2));

  static BoxShadow tileListShadow = BoxShadow(
    color: Colors.grey.withOpacity(0.5),
    spreadRadius: 1.5,
    blurRadius: 5.0,
    offset: const Offset(-1, 4),
  );
}
