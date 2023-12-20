import 'package:flutter/material.dart';
import 'package:gshopp_flutter/utils/constants/color_palette.dart';

class TCheckboxTheme {
  TCheckboxTheme._();

  static CheckboxThemeData lightCheckboxTheme = CheckboxThemeData(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      checkColor: MaterialStateProperty.resolveWith((states) {
        if (states.contains(MaterialState.selected)) {
          return Colors.white;
        } else {
          return Colors.black;
        }
      }),
      fillColor: MaterialStateProperty.resolveWith((states) {
        if (states.contains(MaterialState.selected)) {
          return ColorPalette.primaryLight;
        } else {
          return Colors.transparent;
        }
      }));

  static CheckboxThemeData darkCheckboxTheme = CheckboxThemeData(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      checkColor: MaterialStateProperty.resolveWith((states) {
        if (states.contains(MaterialState.selected)) {
          return Colors.white;
        } else {
          return Colors.black;
        }
      }),
      fillColor: MaterialStateProperty.resolveWith((states) {
        if (states.contains(MaterialState.selected)) {
          return ColorPalette.primaryDark;
        } else {
          return Colors.transparent;
        }
      }));
}
