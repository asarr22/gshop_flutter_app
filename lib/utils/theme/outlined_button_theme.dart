import 'package:flutter/material.dart';
import 'package:gshopp_flutter/utils/constants/color_palette.dart';

class TOutlinedButtonTheme {
  TOutlinedButtonTheme._();

  static OutlinedButtonThemeData outlinedButtonThemeLight =
      OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      side: const BorderSide(color: ColorPalette.primaryLight, width: 2),
    ),
  );
  static OutlinedButtonThemeData outlinedButtonThemeDark =
      OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      side: const BorderSide(color: ColorPalette.primaryDark, width: 2),
    ),
  );
}
